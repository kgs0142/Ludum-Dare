package com.ai 
{
    import com.ai.CBaseAI;
	/**
     * Interactive objects
     * @author Husky
     */
    public class CIAObject extends CBaseAI
    {
        
        private var m_sClass:String;
        
        public function CIAObject(nX:Number, nY:Number) 
        {
            this.x = nX;
            this.y = nY;
        }
        
        override public function ParseProperties(arrParam:Array):void 
        {
            super.ParseProperties(arrParam);
            
            if (arrParam == null)
            {
                return;
            }
            
            var uiLength:uint = arrParam.length;
            for (var ui:uint = 0; ui < uiLength; ui++)
            {
                //Trigger's guid
                //if (arrParam[ui].name == "guid")
                
                if (arrParam[ui].name == "class")
                {
                    m_sClass = arrParam[ui].value;
                }
                
                if (arrParam[ui].name == "animLabel")
                {
                    this.play(arrParam[ui].value);
                }
            }
        }
    }
}