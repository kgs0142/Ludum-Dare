package 
{
    import com.define.CDefine;
    import com.game.state.CCreateState;
    import org.flixel.FlxG;
    import org.flixel.FlxGame;
	
	/**
	 * ...
	 * @author Husky
	 */
    [Frame(factoryClass="Preloader")]
	public class Main extends FlxGame 
	{
		
		public function Main() : void 
		{
            super(CDefine.TILE_WIDTH*13, CDefine.TILE_HEIGHT*8, CCreateState, 3); 
            
            CONFIG::debug
            {
                FlxG.debug = true;
            }    
		}
    }
}