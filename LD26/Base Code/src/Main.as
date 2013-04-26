package 
{
    import com.game.module.CMenuState;
    import com.scene.CSceneManager;
	import flash.display.Sprite;
	import flash.events.Event;
    import org.flixel.FlxGame;
	
	/**
	 * ...
	 * @author Husky
	 */
	public class Main extends FlxGame 
	{
		
		public function Main() : void 
		{
            super(400, 300, CMenuState, 2); 
		}
    }
}