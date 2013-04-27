package 
{
    import com.game.module.CCreateState;
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
            super(208, 176, CCreateState, 3); 
            
            FlxG.debug = true;
		}
    }
}