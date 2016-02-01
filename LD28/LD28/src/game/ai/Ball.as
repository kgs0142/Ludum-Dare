package game.ai 
{
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import flash.geom.Point;
    import game.state.ball.BallIdleState;
	import husky.flixel.MySprite;
    import husky.flixel.util.BlurBmpUnit;
    import husky.state.IState;
    import husky.state.OOStateMachine;
    import org.flixel.FlxG;
	
	/**
     * ...
     * @author Husky
     */
    public class Ball extends MySprite 
    {
        [Embed(source="../../../assets/StuffSet.png")]
        private static const STUFF_PIC:Class;
        
        //Blur variable---------------------------------------
        private static const MAX_BLUR_SIZE:uint = 8;
        
        protected var m_bBlurFlag:Boolean = false;
        
        private var m_uiAccuSkipFrame:uint;
        
        private var m_vBlurBmpUnit:Vector.<BlurBmpUnit>;
        //------------------------------------------------------------
        
        private var m_StateMachine:OOStateMachine;
        
        public function Ball() 
        {
            this.loadGraphic(STUFF_PIC, false, false, 16, 16);
            
            this.addAnimation("normal", [0], 0, false);
            
            this.addAnimation("bowling", [3], 0, false);
            
            this.play("normal");
            
            //彈力係數等等
            //m_nDestroyTime = 5;
            
            this.elasticity = 0.5;
            //this.mass = 5000;
            
            //this.maxVelocity.x = 500;       
            //this.maxVelocity.y = 50;
            //this.drag.y = 500;
            
            this.angularAcceleration = 30;
            this.angularVelocity = 30;
            
            //this.acceleration.x = 200;           
            this.acceleration.y = 100;
            
            //this.velocity.x = this.acceleration.x * 5;           
            //this.velocity.y = this.acceleration.y;
            
            m_vBlurBmpUnit = Vector.<BlurBmpUnit>([]);
            
            m_StateMachine = new OOStateMachine(null);
            
            m_StateMachine.SetState(new BallIdleState(this));
        }
        
        public function SetState(state:IState) : void
        {
            m_StateMachine.SetState(state);
        }
        
        override public function update():void 
        {
            super.update();
            
            m_StateMachine.Update();
            
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
        
        override public function destroy():void 
        {
            super.destroy();
            
            m_StateMachine.Release();
            m_StateMachine = null;
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
            return 30;
        }
    }
}