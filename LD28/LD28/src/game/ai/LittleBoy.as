package game.ai 
{
	import husky.flixel.MySprite;
	
	/**
     * ...
     * @author Husky
     */
    public class LittleBoy extends MySprite 
    {
        [Embed(source="../../../assets/NPCAnimSet.png")]
        private static const NPC_PIC:Class;
        
        public function LittleBoy() 
        {
            this.loadGraphic(NPC_PIC, true, true, 16, 16);
            
            this.addAnimation("idle", [0], 0, false);
            
			this.addAnimation("play", [1], 0, false);
            
			this.addAnimation("kidnap", [2, 3, 4, 5], 20, true);
            
            this.addAnimation("onChair", [6, 7], 4, true);
            
            this.play("idle");
            
            this.acceleration.y = 100;
        }
    }
}