package org.dame.objects
{
	import org.flixel.FlxGroup;

	public class CircleData extends ShapeData
	{
		public var radius:Number;

		public function CircleData( X:Number, Y:Number, Radius:Number, Group:FlxGroup ) 
		{
			super(X, Y, Group);
			radius = Radius;
		}
	}
}
