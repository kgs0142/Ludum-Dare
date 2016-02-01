package game.scene.struct 
{
	/**
     * ...
     * @author Husky
     */
    public class CTextData extends CShapeData 
    {
		public var width:uint;
		public var height:uint;
		public var angle:Number;
		public var text:String;
		public var fontName:String;
		public var size:uint;
		public var color:uint;
		public var alignment:String;
        
        public function CTextData(nX:Number, nY:Number, uiWidth:uint, uiHeight:uint, 
                                  nAngle:Number, sText:String, sFontName:String, 
                                  uiSize:uint, uiColor:uint, sAlignment:String )
		{
            super(0, 0, null);
            
			x = nX;
			y = nY;
			width = uiWidth;
			height = uiHeight;
			angle = nAngle;
			text = sText;
			fontName = sFontName;
			size = uiSize;
			color = uiColor;
			alignment = sAlignment;
        }
    }
}