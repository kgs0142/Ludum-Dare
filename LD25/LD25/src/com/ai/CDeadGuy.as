package com.ai 
{
	/**
     * ...
     * @author Husky
     */
    public class CDeadGuy extends CIAObject 
    {
        [Embed(source="../../../assets/DeadGuy.PNG")]
        private static const DEAD_GUY_PIC:Class;
        
        public function CDeadGuy(nX:Number, nY:Number) : void
        {
            super(nX, nY);
            
            this.loadGraphic(DEAD_GUY_PIC);
        }
    }
}