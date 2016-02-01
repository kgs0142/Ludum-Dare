package game.gameModule;

import core.system.AudioManager;
import flixel.FlxG;
import flixel.FlxState;
import flixel.plugin.MouseEventManager;
import flixel.system.scaleModes.FixedScaleMode;
import game.test.TestModule;
import utils.Fonts;

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
        
        // We need the MouseEventManager plugin for sprite-mouse-interaction
		FlxG.plugins.add(new MouseEventManager());
        
        Fonts.Get().Initial();
        AudioManager.Get().Initial();
        
        //----------------------------------------------------------------------------------------
        
        //No scale mode
        FlxG.scaleMode = new FixedScaleMode();
        
        FlxG.switchState(new TestModule());
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
	override public function update():Void
	{
		super.update();
	}
}