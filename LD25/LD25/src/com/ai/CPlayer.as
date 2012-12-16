package com.ai
{
    import com.greensock.TweenLite;
    import com.system.CLuaManager;
    import com.system.QTEManager;
    import com.ui.flash.CWheelUI;
    import org.flixel.FlxG;
    import org.flixel.FlxObject;
    import org.flixel.FlxSound;
    import org.flixel.FlxSprite;
    import org.flixel.FlxText;
    import org.flixel.plugin.photonstorm.FlxBar;
    import org.flixel.plugin.photonstorm.FlxControl;
    import org.flixel.plugin.photonstorm.FlxControlHandler;
    
	public class CPlayer extends CBaseAI
	{
        //player's hp is in SceneMgr
        
        [Embed(source="../../../assets/PlayerAnim.png")]
        private static const PLAYER_PIC:Class;

        [Embed(source="../../../audio/mp3/sfx/RightStep.mp3")]
        private static const STEP_SND:Class;
        
        private static var ms_StepSnd:FlxSound = new FlxSound();
        
		public function CPlayer(nX:Number, nY:Number):void 
		{
            this.x = nX;
            this.y = nY;
            
            this.loadGraphic(PLAYER_PIC, true, true, 16, 20);

            this.addAnimation("idle", [3], 0, false);
            this.addAnimation("down", [3, 2, 1, 0], 4, false);
            this.addAnimation("up", [0, 1, 2, 3], 4, false);
            this.addAnimation("hurt", [4, 5, 4, 5, 4, 5, 4, 5, 3], 4, false)
            this.addAnimation("attack", [6, 7, 8, 9, 8], 10, false);
            this.addAnimation("cryQTE", [3, 2, 1, 0, 0, 0, 1, 2, 16, 
                                         17, 16, 17, 16, 17, 16, 17], 4, false);
            this.addAnimation("cry", [16, 17], 4);
            this.addAnimation("skull", [12], 1);
            
            this.play("idle");

            this.offset.y = -8;
            
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, 
                                    FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
            
			FlxControl.player1.setWASDControl(false, false, true, true);
			
			FlxControl.player1.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 200, 
                                              FlxObject.FLOOR, 250, 200);
			
            ms_StepSnd.loadEmbedded(STEP_SND);
            FlxControl.player1.setSounds(null, null, ms_StepSnd);
                                              
			FlxControl.player1.setMovementSpeed(150, 0, 150, 100, 100, 0);
			FlxControl.player1.setDeceleration(2000, 500);

			FlxControl.player1.setGravity(0, 500);
		}
        
        override public function OnOverlap(aiOverlap:CBaseAI):void 
        {           
            super.OnOverlap(aiOverlap);
            
            if (this.active == false ||
                aiOverlap.bPauseUpdate == true ||
                aiOverlap.active == false ||
                aiOverlap.iHP <= 0)
            {
                return;
            }
            
            //overlap enemy qte to survive
            if (aiOverlap is CEnemy)
            {
                CLuaManager.Get().cLuaAlchemy.setGlobal("enemy", aiOverlap as CEnemy);
                
                QTEManager.Get().Active(this, aiOverlap,
                function () : void
                {
                    CLuaManager.Get().cLuaAlchemy.doString("playerQTEOK()");
                },
                function () : void
                {
                    CLuaManager.Get().cLuaAlchemy.doString("playerQTEFail()");
                },
                function () : void
                {
                    //let the enemy die
                    aiOverlap.kill();
                    m_ftDialog.text = "he runs away...";
                    TweenLite.delayedCall(1.5, function () : void
                    {
                        m_ftDialog.text = "";
                    });
                });
            }
        }
        
		public override function update():void 
		{
            super.update();
            
			m_ftDialog.x = this.x - this.width/2;
            m_ftDialog.y = this.y - 30;
		}
        
        public override function draw():void 
        {
            super.draw();
            
            m_ftDialog.draw();
        }
	}
}