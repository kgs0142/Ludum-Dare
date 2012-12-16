package com.ai 
{
	/**
     * ...
     * @author Husky
     */
    public class CFishPic extends CIAObject 
    {
        [Embed(source="../../../assets/FishPic.PNG")]
        private static const FISH_PIC:Class;
        
        public function CFishPic(nX:Number, nY:Number) : void
        {
            super(nX, nY);
            
            this.loadGraphic(FISH_PIC, true, false, 16, 16);
            
            this.addAnimation("idle", [0]);
            this.addAnimation("die", [3]);
            this.addAnimation("dieAnim", [0, 1, 2, 3], 1, false);
        }
    }
}