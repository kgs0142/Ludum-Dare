package com.ai 
{
	/**
     * ...
     * @author Husky
     */
    public class CDiary extends CIAObject 
    {
        [Embed(source="../../../assets/Diary.png")]
        private static const DIARY_PIC:Class;
        
        public function CDiary(nX:Number, nY:Number) : void
        {
            super(nX, nY);
            
            this.loadGraphic(DIARY_PIC);
        }
    }
}