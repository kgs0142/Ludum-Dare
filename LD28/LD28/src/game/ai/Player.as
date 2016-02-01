package game.ai 
{
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import flash.geom.Point;
    import game.module.BaseSceneModule;
    import game.module.GamePlayModule;
    import game.scene.CBaseScene;
    import game.ui.HUD;
    import husky.flixel.controller.BaseController;
	import husky.flixel.MySprite;
    import husky.flixel.util.BlurBmpUnit;
    import org.flixel.FlxG;
    import org.flixel.FlxObject;
    import org.flixel.plugin.photonstorm.FlxControl;
    import org.flixel.plugin.photonstorm.FlxControlHandler;
    import org.flixel.plugin.photonstorm.FlxDelay;
	
	/**
     * ...
     * @author Husky
     */
    public class Player extends MySprite 
    {
        [Embed(source="../../../assets/PlayerAnimSet.png")]
        private static const PLAYER_PIC:Class;
        
        public static const MAX_LIFE:uint = 3;
        
        //衝刺技能相關-----------------------------------------------------------------
        private static const DASH_DOUBLE_DOWN_TIME:Number = 0.2;
        
        private var m_bDashRight:Boolean;
        
        private var m_bDashLeft:Boolean;
        
        private var m_bDashStart:Boolean;
        
        private var m_bDashRemainderTime:Number;
        
        //雙擊方向鍵的時間
        private var m_doubleDownTime:Number;
        //-----------------------------------------------------------------------------
        
        //Blur variable---------------------------------------
        private static const MAX_BLUR_SIZE:uint = 8;
        
        protected var m_bBlurFlag:Boolean = false;
        
        private var m_uiAccuSkipFrame:uint;
        
        private var m_vBlurBmpUnit:Vector.<BlurBmpUnit>;
        //------------------------------------------------------------
        
        private var m_bLockControl:Boolean;
        
        public function Player() 
        {
            this.health = MAX_LIFE;
            
			this.loadGraphic(PLAYER_PIC, true, true, 16, 16, true);
            
            this.width = 14;
			this.height = 14;
            
            this.offset.x = 2;
            this.offset.y = 2;
            
            this.addAnimation("idle", [0, 1, 2, 1, 2, 3, 4], 10, true);
			this.addAnimation("walk", [1, 16, 17], 10, true);
			this.addAnimation("jump_up", [16], 0, false);
			this.addAnimation("jump_down", [17], 0, false);
            this.addAnimation("dead", [32], 0, false);
            
            this.play("idle");
            
            //Control
            FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, 
                                    FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
            FlxControl.player1.setWASDControl(false, false, true, true);
            FlxControl.player1.setJumpButton("W", FlxControlHandler.KEYMODE_PRESSED, 200,
                                              FlxObject.FLOOR, 250, 200, function () : void
                                              {
                                                    FlxG.play(SndJump, 0.3);  
                                              });
			FlxControl.player1.setMovementSpeed(400, 0, 150, 300, 400, 0);
			FlxControl.player1.setGravity(0, 400);
            FlxControl.player1.enabled = true;
            
            //Dash
            m_bDashLeft = false;
            m_bDashRight = false;
            m_bDashStart = false;
            m_bDashRemainderTime = 0.0;
            m_doubleDownTime = 0.0;
            
            m_bLockControl = false;
            
            m_vBlurBmpUnit = Vector.<BlurBmpUnit>([]);
            
            this.SetController(new BaseController());
        }
        
        override public function hurt(Damage:Number):void 
        {
            this.flicker(0.5);
            
            health = health - Damage;
			
            if (health <= 0)
            {
                FlxG.score = 0;
                
                this.m_bLockControl = false;
                FlxControl.player1.enabled = false;
                this.play("dead");
                
                FlxG.fade(0xFF000000, 1.5, function () : void
                {
                   FlxG.resetState(); 
                });
            }
        }
        
        override public function update():void 
        {
            super.update();

            if (health <= 0)
            {
                return;
            }
            
            //Slow blur motion--------------------------------------------
            if (m_vBlurBmpUnit.length == MAX_BLUR_SIZE)
            {
                m_vBlurBmpUnit[0].Destroy();
                m_vBlurBmpUnit[0] = null;
                m_vBlurBmpUnit.shift();
            }
            
            const SKIP_FRAME:uint = (FlxG.timeScale < 1) ? IF_SLOW_THEN_SKIP_FRAME : NORMAL_SKIP_FRAME;
            
            m_uiAccuSkipFrame++;
            if (m_uiAccuSkipFrame > SKIP_FRAME)
            {
                m_uiAccuSkipFrame = 0;
                
                if (m_bBlurFlag == true)
                {
                    SnapAndStoreBlurUnit();
                }
            }
            //-------------------------------------------
            
            if (touching == FlxObject.FLOOR)
			{
				if (this.velocity.x != 0)
				{
					this.play("walk");
				}
				else
				{
					this.play("idle");
				}
			}
			else if (this.velocity.y < 0)
			{
				this.play("jump_up");
			}
            else if (this.velocity.y > 0)
			{
				this.play("jump_down");
			}
            
            if (m_bLockControl)
            {
                return;
            }
            
            //Dash--------------------------------------------------------------
            if (m_bDashStart == true)
            {
                m_bDashRemainderTime -= FlxG.elapsed;
            }
            
            if (m_bDashRemainderTime <= 0.0 && m_bDashStart == true)
            {
                m_bDashStart = false;
                this.RemoveBlurEffect();
                FlxControl.player1.setGravity(0, 400);
                FlxControl.player1.setMovementSpeed(400, 0, 150, 300, 400, 0);
            }
            
            m_doubleDownTime -= FlxG.elapsed;

            if (FlxG.state is GamePlayModule &&
                (FlxG.state as BaseSceneModule).Hud.enBar.percent >= 100)
            {
                //可以開motion blur和粉塵效果嗎
                if (FlxG.keys.justPressed("D") == true)
                {
                    if (m_doubleDownTime >= 0.0 && m_bDashRight == true)
                    {
                        m_bDashStart = true;
                        m_bDashRemainderTime = 0.5;
                        m_doubleDownTime = 0.0;
                        m_bDashLeft = false;
                        m_bDashRight = false;
                        
                        (FlxG.state as BaseSceneModule).Hud.enBar.currentValue = 0;
                        
                        this.facing = FlxObject.RIGHT;
                        this.velocity.x = 3000;
                        this.velocity.y = 0;
                        
                        this.PlayBlurEffect();
                        
                        FlxControl.player1.setGravity(0, 0);
                        FlxControl.player1.setMovementSpeed(3000, 0, 150, 3000, 400, 0);
                    }
                    
                    m_bDashRight = true;
                    m_doubleDownTime = DASH_DOUBLE_DOWN_TIME;
                }
                
                if (FlxG.keys.justPressed("A") == true)
                {
                    if (m_doubleDownTime >= 0.0 && m_bDashLeft == true)
                    {
                        m_bDashStart = true;
                        m_bDashRemainderTime = 0.5;
                        m_doubleDownTime = 0.0;
                        m_bDashLeft = false;
                        m_bDashRight = false;
                     
                        (FlxG.state as BaseSceneModule).Hud.enBar.currentValue = 0;
                        
                        this.facing = FlxObject.LEFT;
                        this.velocity.x = -3000;
                        this.velocity.y = 0;
                        
                        this.PlayBlurEffect();
                        
                        FlxControl.player1.setGravity(0, 0);
                        FlxControl.player1.setMovementSpeed(3000, 0, 150, 3000, 400, 0);
                    }
                    
                    m_bDashLeft = true;
                    m_doubleDownTime = DASH_DOUBLE_DOWN_TIME;
                }
            }
            //------------------------------------------------------------------
        }
        
        override public function draw():void 
        {
            //Slow motion and Blur effect----------------------------------------
            var uiLength:uint = m_vBlurBmpUnit.length;
            for (var ui:uint = 0; ui < uiLength; ui++)
            {
                var ct:ColorTransform = new ColorTransform();
                ct.alphaMultiplier = ui*(0.8/uiLength);
                FlxG.camera.buffer.draw(m_vBlurBmpUnit[ui].bmpBlur, 
                                        m_vBlurBmpUnit[ui].getMatrix(), ct, blend, null, antialiasing);
            }
            //-----------------------------------------------------------------------
            
            super.draw();
        }
        
        public function PlayBlurEffect() : void
        {
            m_bBlurFlag = true;
        }
        
        public function RemoveBlurEffect() : void
        {
            m_bBlurFlag = false;
            m_vBlurBmpUnit.splice(0, m_vBlurBmpUnit.length);
        }
        
        private function SnapAndStoreBlurUnit() : void
        {
            var bmpd:BitmapData = new BitmapData(this.framePixels.width, this.framePixels.height);
            bmpd.copyPixels(this.framePixels, this.framePixels.rect, new Point(0, 0));
            var unit:BlurBmpUnit = new BlurBmpUnit(this.x - this.offset.x, this.y - this.offset.y, bmpd);
            m_vBlurBmpUnit.push(unit);
        }
        
        protected function get NORMAL_SKIP_FRAME() : int
        {
            return 2;
        }
        
        protected function get IF_SLOW_THEN_SKIP_FRAME() : int
        {
            return 3;
        }
        
        override public function destroy():void 
        {
            super.destroy();
        }
        
        public function get bLockControl():Boolean 
        {
            return m_bLockControl;
        }
        
        public function set bLockControl(value:Boolean):void 
        {
            m_bLockControl = value;
            
            if (m_bLockControl == true)
            {
                FlxControl.player1.enabled = false;
            }
        }
    }
}