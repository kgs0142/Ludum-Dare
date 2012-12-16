package com.ai 
{
	/**
     * ...
     * @author Husky
     */
    public class CHangerSmall extends CIAObject 
    {
        [Embed(source="../../../assets/Hanger-Small.PNG")]
        private static const HANGER_SAMLL:Class;
        
        public function CHangerSmall(nX:Number, nY:Number) : void
        {
            super(nX, nY);
         
            this.loadGraphic(HANGER_SAMLL);
        }
        
    }

}