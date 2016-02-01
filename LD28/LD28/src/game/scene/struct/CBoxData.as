package game.scene.struct 
{
    import org.flixel.FlxGroup;
	/**
     * ...
     * @author Husky
     */
    public class CBoxData extends CShapeData 
    {
        public var angle:Number;
		public var width:uint;
		public var height:uint;
        
        public function CBoxData(nX:Number, nY:Number, nAngle:Number, uiWidth:uint, 
                                 uiHeight:uint, group:FlxGroup) 
		{
			super(nX, nY, group);
			angle = nAngle;
			width = uiWidth;
			height = uiHeight;
        }
    }
}