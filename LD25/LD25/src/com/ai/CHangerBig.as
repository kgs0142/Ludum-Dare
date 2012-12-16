package com.ai 
{
	/**
     * ...
     * @author Husky
     */
    public class CHangerBig extends CIAObject 
    {
        [Embed(source="../../../assets/Hanger-BIG.png")]
        private static const HANGER_BIG:Class;
        
        public function CHangerBig(nX:Number, nY:Number) : void
        {
            super(nX, nY);
            
            this.loadGraphic(HANGER_BIG);
        }
    }
}