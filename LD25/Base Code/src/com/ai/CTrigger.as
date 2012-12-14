package com.ai 
{
    import org.flixel.FlxCamera;
    import org.flixel.FlxBasic;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	public class CTrigger extends CBaseAI
	{
        ///trigger for once?
        private var m_bOnce:Boolean;
        
        ///mask enemy? defalut is true
        private var m_bMaskEnemy:Boolean;
        
		public var target:String = "";
		public var targetObject:Object = null;
		public var moveDir:uint = FlxObject.NONE;
		
        //arrOverlap: [{obj, bEnter, bStay, bExit}..]
        //check the bExit at update()
        
		public function CTrigger(nX:Number, nY:Number, nWidth:uint, nHeight:uint) 
		{
            this.x = nX;
            this.y = nY;
			this.width = nWidth;
			this.height = nHeight;
			this.visible = false;
		}
        
        public override function OnOverlap(aiOverlap:CBaseAI) : void
        {
            super.OnOverlap(aiOverlap);
            
            trace("Trigger overlap something, OnEnter, OnStay, or OnExit");
        }
        
        //FIXME Trigger's ParseProperties
		public override function ParseProperties(arrParam:Array) : void
		{
			if (arrParam == null)
            {
                return;
            }
            
            var uiLength:uint = arrParam.length;
            for (var ui:uint = 0; ui < uiLength; ui++)
            {
                //Trigger's guid
                //if (arrParam[ui].name == "guid")
                
                if (arrParam[ui].name == "target")
                {
                    target = arrParam[ui].value;
                }
            }
		}
		
		public function AddLinkTo(obj:Object):void
		{
			targetObject = obj;
		}
	}
}