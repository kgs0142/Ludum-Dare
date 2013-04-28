package com.game 
{
	import org.flixel.FlxSprite;
	
	/**
     * ...
     * @author Husky
     */
    public class CFlxMySprite extends FlxSprite 
    {
        public var sName:String;
        public var uiDepth:uint;
        public var clzGraphics:Class;
        
        public function CFlxMySprite(clzGraphics_:Class, sName_:String, uiDepth_:uint)
        {
            super(0, 0, clzGraphics_);
            
            sName = sName_;
            uiDepth = uiDepth_;
            clzGraphics = clzGraphics_;
        }
    }
}