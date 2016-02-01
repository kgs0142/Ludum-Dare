package 
{
	import flash.display.Sprite;
	import flash.events.Event;
    import game.module.CreateModule;
    import org.flixel.FlxG;
    import org.flixel.FlxGame;
	
	/**
	 * ...
	 * @author Husky
	 */
	public class Main extends FlxGame 
	{
		
		public function Main() : void 
		{
            super(208, 176, CreateModule, 3); 
            
            FlxG.debug = true;
            
            //暫停拿掉？
		}
	}
}