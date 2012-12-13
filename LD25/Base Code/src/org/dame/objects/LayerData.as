package org.dame.objects 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author ...
	 */
	public class LayerData extends FlxGroup
	{
		public var name:String;
		public var xScroll:Number;
		public var yScroll:Number;
		
		public function LayerData( Name:String, XScroll:Number = 1, YScroll:Number = 1 ) 
		{
			name = Name;
			xScroll = XScroll;
			yScroll = YScroll;
		}
		
	}

}