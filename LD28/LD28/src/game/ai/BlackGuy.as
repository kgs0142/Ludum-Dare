package game.ai 
{
    import husky.flixel.controller.BaseController;
	import husky.flixel.MySprite;
	
	/**
     * ...
     * @author Husky
     */
    public class BlackGuy extends MySprite 
    {
        [Embed(source="../../../assets/NPCAnimSet.png")]
        private static const NPC_PIC:Class;
        
        public function BlackGuy() 
        {
            this.loadGraphic(NPC_PIC, true, true, 16, 16);
            
            this.addAnimation("idle", [16, 17], 2, true);
            
			this.addAnimation("idle_weapon", [18, 19], 2, true);
            
			this.addAnimation("attack", [20, 21, 19], 4, false);
            
            this.play("idle");
            
            this.acceleration.y = 100;
            
            this.SetController(new BaseController());
        }
        
        override public function update():void 
        {
            super.update();
        }
        
        override public function destroy():void 
        {
            super.destroy();
        }
        
        override public function hurt(Damage:Number):void 
        {
            super.hurt(Damage);
        }
        
        public function SetHp(uiHp:uint) : void
        {
            this.health = uiHp;
        }
    }
}