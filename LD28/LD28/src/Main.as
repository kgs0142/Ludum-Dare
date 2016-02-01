package 
{
	import flash.display.Sprite;
	import flash.events.Event;
    import game.global.Define;
    import game.module.CreateModule;
    import nc.entity.NcEntityManager;
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
            super(Define.TILE_WIDTH*16, Define.TILE_HEIGHT*10, CreateModule, 3); 
            
            FlxG.debug = CONFIG::debug;
		}
        
        //override protected function onFocusLost(FlashEvent:Event = null):void 
        //{
            //Donothing
        //}
        
        //override protected function onFocus(FlashEvent:Event = null):void 
        //{
            //Donothing
        //}
        
        override protected function update():void 
        {
            super.update();
            
            NcEntityManager.Get().Update();
        }
	}
}