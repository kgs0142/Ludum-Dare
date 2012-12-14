package com.ai 
{
	import org.flixel.FlxSprite;
	
	/**
     * Base AI
     * @author Husky
     */
    public class CBaseAI extends FlxSprite 
    {
        //the unique guid created from DAME, didn't set every object
        private var m_sGUID:String;
        
        //the connected object's guid
        private var m_sConnectGUID:String;
        
        public function ParseProperties(arrParam:Array):void
		{
        }
        
        /**
         * the over lap happened
         * @param	aiOverlap
         */
        public function OnOverlap(aiOverlap:CBaseAI) : void
        {
            
        }
        
        public function CBaseAI() 
        {
            m_sGUID = "";
        }
    }
}