package  
{
    import com.game.module.CCreateModule;
    import com.game.module.CGameOverModule;
    import com.game.module.CTitleModule;
    import com.greensock.TweenLite;
    import flash.events.Event;
	import org.flixel.*;
	
	[SWF(width = "640", height = "320", backgroundColor = "#000000")]
	[Frame(factoryClass = "Preloader")]
	public class MainGame extends FlxGame
	{
		public function MainGame():void
		{
			super(320, 160, CCreateModule, 2, 60, 60);
		}
        
        //override protected function onFocusLost(FlashEvent:Event = null):void 
        //{
            //super.onFocusLost(FlashEvent);
            //
            //TweenLite.
        //}
        //
        //override protected function onFocus(FlashEvent:Event = null):void 
        //{
            //super.onFocus(FlashEvent);
        //}
        
        //disable the onFocusLost(cause tweenLite
        override protected function create(FlashEvent:Event):void
        {
            super.create(FlashEvent);
            stage.removeEventListener(Event.DEACTIVATE, onFocusLost);
            stage.removeEventListener(Event.ACTIVATE, onFocus);
        }
	}
}