package com.ai 
{
    import com.game.CBaseScene;
    import com.global.CDefine;
    import com.system.CLuaManager;
    import org.flixel.FlxG;
    
	/**
     * ...
     * @author Husky
     */
    public class CEnemy extends CBaseAI 
    {
        [Embed(source="../../../assets/PlayerAnim.png")]
        private static const ANIM_CLS:Class;
        
        public function CEnemy(nX:Number, nY:Number) 
        {
            this.x = nX;
            this.y = nY;
            
            this.loadGraphic(ANIM_CLS, true, true, 16, 20);
            this.offset.y = -8
            
            this.addAnimation("idle", [12], 0, false);
            this.addAnimation("attack", [12, 11, 10, 11, 12, 13, 12], 10, false);
            
            this.play("idle");
            
            this.maxVelocity.x = 20;
            this.maxVelocity.y = 500;
            //this.acceleration.x = 20;
            this.acceleration.y = 800;
            this.drag.x = this.maxVelocity.x*4;
            this.mass = 1000;

            m_iHP = 3;
            
            //default qte function
            this.m_sQTEFn = CDefine.ENEMY_QTE_3_TIMES;
            
            //cause there is only one enemy in the game...
            CLuaManager.Get().cLuaAlchemy.setGlobal("enemy", this);
            
            FlxG.watch(this, "iHP", "eny hp");
        }
        
        public override function update():void 
		{
            super.update();
            
            this.acceleration.x = 0;
            
            if (active == false)
            {
                return;
            }
            
			m_ftDialog.x = this.x - this.width/2;
            m_ftDialog.y = this.y - 40;
            
            //escape
            if (m_iHP <= 0)
            {
                this.acceleration.x = 20;
                this.kill();
            }
            
            //pause the rest update
            if (m_bPauseUpdate == true)
            {
                return;
            }
            
            //find player
            var cScene:CBaseScene = FlxG.state as CBaseScene;
            var iDir:int = (cScene.player.x > this.x) ? 1 : -1;
            
            this.acceleration.x = 20*iDir;
		}
        
        override public function kill():void 
        {
            super.kill();
            
            this.active = false;
        }
        
        public override function draw():void 
        {
            super.draw();
            
            m_ftDialog.draw();
        }
    }
}