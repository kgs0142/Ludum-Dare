package game.scene.struct 
{
    import org.flixel.FlxPoint;
	/**
     * ...
     * @author Husky
     */
    public class CPathNode extends FlxPoint
    {
        public var tan1:FlxPoint = null;
		public var tan2:FlxPoint = null;
        
        public function CPathNode(X:Number, Y:Number) 
		{
			super(X, Y);
        }
    }
}