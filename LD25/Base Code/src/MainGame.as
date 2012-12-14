package  
{
    import com.game.module.XmlState;
	import org.flixel.*;
	
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	[Frame(factoryClass = "Preloader")]
	public class MainGame extends FlxGame
	{
		
		public function MainGame():void
		{
			super(640, 480, XmlState, 1, 60, 60);
		}
	}
}