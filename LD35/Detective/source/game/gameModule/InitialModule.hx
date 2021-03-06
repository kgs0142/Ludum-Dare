package game.gameModule;

import core.misc.CustomInterp;
import game.manager.AudioManager;
import core.system.HScriptManager;
import flixel.FlxG;
import flixel.FlxState;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.scaleModes.FixedScaleMode;
import game.manager.LevelManager;
import utils.Fonts;

using core.util.CustomExtension;

/**
 * The first and initialized state.
 * @author Husky
 */
class InitialModule extends FlxState
{
    /**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
        
        //FlxG.debugger.visible = true;
        
        // We need the MouseEventManager plugin for sprite-mouse-interaction
		FlxG.plugins.add(new FlxMouseEventManager());
        
        Fonts.Get().Initial();
        AudioManager.Get().Initial();
        
        HScriptManager.Get().Initial(function ():Void 
        {
            var interp:CustomInterp = new CustomInterp();
            interp.CommonInitial();
            interp.variables.set("LevelManager", LevelManager);
            
            interp.execute(HScriptManager.Get().GetParsedScript(AssetPaths.config__hs));
            interp.variables.get("testCreateFunction")();
            
            FlxG.switchState(new MenuModule());
            //FlxG.switchState(new EndGameModule());
        });
        
        //----------------------------------------------------------------------------------------	}
    }
    
	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}