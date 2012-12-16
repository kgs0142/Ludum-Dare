package com.ai 
{
	import org.flixel.FlxSprite;
    import org.flixel.FlxText;
	
	/**
     * Base AI
     * @author Husky
     */
    public class CBaseAI extends FlxSprite 
    {
        //the unique guid created from DAME, didn't set every object
        //protected var m_sGUID:String;
        
        //the connected object's guid
        protected var m_sConnectGUID:String;
        
        protected var m_ftDialog:FlxText
        
        protected var m_iHP:int;
        
        protected var m_bPauseUpdate:Boolean;
        
        //the lua QTE Event
        protected var m_sQTEFn:String;
        
        public function ParseProperties(arrParam:Array):void
		{
            if (arrParam == null)
            {
                return;
            }
            
            var uiLength:uint = arrParam.length;
            for (var ui:uint = 0; ui < uiLength; ui++)
            {
                if (arrParam[ui].name == "visible")
                {
                    this.visible = (arrParam[ui].value == "true");
                }
                else if (arrParam[ui].name == "active")
                {
                    this.active = (arrParam[ui].value == "true");
                }
            }
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
            //m_sGUID = "";
            m_sQTEFn = "";
            m_bPauseUpdate = false;
            
            m_ftDialog = new FlxText(this.x, this.y, 100);
            m_ftDialog.color = 0XFF000000;
        }
        
        public function get ftDialog() : FlxText { return m_ftDialog; }
        
        public function get iHP() : int { return m_iHP; }
        public function set iHP(value:int) : void { m_iHP = value; }
        
        public function get bPauseUpdate() : Boolean { return m_bPauseUpdate; }
        public function set bPauseUpdate(value:Boolean) : void { m_bPauseUpdate = value; }
        
        public function get sQTEFn() : String { return m_sQTEFn; }
        
        public function set sQTEFn(value:String):void 
        {
            m_sQTEFn = value;
        }
    }
}