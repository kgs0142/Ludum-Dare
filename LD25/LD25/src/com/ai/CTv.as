package com.ai 
{
	/**
     * ...
     * @author Husky
     */
    public class CTv extends CIAObject 
    {
        [Embed(source="../../../assets/TV.png")]
        private static const TV_PIC:Class;
        
        public function CTv(nX:Number, nY:Number) : void
        {
            super(nX, nY);
            this.loadGraphic(TV_PIC);
        }
    }
}