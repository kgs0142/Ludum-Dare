package com.ai 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	public class CTrigger extends FlxSprite
	{
		public var target:String = "";
		public var targetObject:Object = null;
		public var moveDir:uint = FlxObject.NONE;
		
		public function CTrigger(nX:Number, nY:Number, nWidth:uint, nHeight:uint) 
		{
			super(nX, nY);
			width = nWidth;
			height = nHeight;
			visible = false;
		}
		
        //FIXME Trigger's ParseProperties
		public function ParseProperties( properties:Array):void
		{
			if (properties == null)
            {
                return;
            }
            
            var uiLength:uint = properties.length;
            for (var ui:uint = 0; ui < uiLength; ui++)
            {
                if (properties[ui].name == "target")
                {
                    target = properties[ui].value;
                }
                else if ( properties[ui].name == "moveDir" )
                {
                    switch( properties[ui].value )
                    {
                        case "LEFT":
                            moveDir = FlxObject.LEFT;
                            break;
                        case "RIGHT":
                            moveDir = FlxObject.RIGHT;
                            break;
                        case "UP":
                            moveDir = FlxObject.UP;
                            break;
                        case "DOWN":
                            moveDir = FlxObject.DOWN;
                            break;
                        default:
                            moveDir = FlxObject.LEFT;
                            break;
                    }
                }
            }
		}
		
		public function AddLinkTo(obj:Object):void
		{
			targetObject = obj;
		}
	}
}