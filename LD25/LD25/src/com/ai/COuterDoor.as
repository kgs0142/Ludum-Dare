package com.ai 
{
	/**
     * ...
     * @author Husky
     */
    public class COuterDoor extends CIAObject 
    {
        [Embed(source="../../../assets/OuterDoor.PNG")]
        private static const OUTER_DOOR_CLS:Class;
        
        public function COuterDoor(nX:Number, nY:Number) : void
        {
            super(nX, nY);
            
            this.loadGraphic(OUTER_DOOR_CLS);
        }
        
    }

}