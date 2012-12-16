package org.dame.objects 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author ...
	 */
	public class PathNode extends FlxPoint
	{
		public var tan1:FlxPoint = null;
		public var tan2:FlxPoint = null;
		
		public function PathNode(X:Number, Y:Number) 
		{
			super(X, Y);
		}
		
	}

}