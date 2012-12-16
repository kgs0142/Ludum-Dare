package com.ai 
{
	/**
     * ...
     * @author Husky
     */
    public class CDoor extends CIAObject 
    {
        [Embed(source="../../../assets/Door.png")]
        private static const DOOR_PIC:Class;
        
        public function CDoor(nX:Number, nY:Number) : void
        {
            super(nX, nY);
            
            this.loadGraphic(DOOR_PIC, true, false, 32, 32);
            
            this.addAnimation("idle", [0]);
            this.addAnimation("open", [1]);
            
            this.play("idle");
        }
    }
}