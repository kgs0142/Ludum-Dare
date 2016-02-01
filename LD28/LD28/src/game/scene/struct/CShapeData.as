package game.scene.struct 
{
    import org.flixel.FlxGroup;
	/**
     * ...
     * @author Husky
     */
    public class CShapeData 
    {
        public var x:Number;
		public var y:Number;
		public var group:FlxGroup;
        
        public function CShapeData(X:Number, Y:Number, Group:FlxGroup )
		{
			x = X;
			y = Y;
			group = Group;
        }
        
        public function Release():void
		{
			group = null;
		}
    }
}