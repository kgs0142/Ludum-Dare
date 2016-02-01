package game.scene.struct 
{
    import org.flixel.FlxGroup;
	/**
     * ...
     * @author Husky
     */
    public class CCircleData extends CShapeData 
    {
        public var radius:Number;
                
        public function CCircleData(nX:Number, nY:Number, nRadius:Number, group:FlxGroup) 
		{
			super(nX, nY, group);
			radius = nRadius;
        }
    }
}