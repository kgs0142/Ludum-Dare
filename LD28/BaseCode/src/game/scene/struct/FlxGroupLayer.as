package game.scene.struct 
{
	import org.flixel.FlxGroup;
	
	/**
     * The FlxGroup layer data 
     * @author Husky
     */
    public class FlxGroupLayer extends FlxGroup 
    {
        public var name:String;
		public var xScroll:Number;
		public var yScroll:Number;
        
        public function FlxGroupLayer(Name:String, XScroll:Number = 1, YScroll:Number = 1) 
        {
            name = Name;
			xScroll = XScroll;
			yScroll = YScroll;
        }
    }
}