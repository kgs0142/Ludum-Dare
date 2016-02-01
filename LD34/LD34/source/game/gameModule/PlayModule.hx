package game.gameModule;

import core.system.AudioManager;
import flixel.FlxState;
import game.gameState.GamePlayState;
import utils.AssetPaths;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayModule extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
        
        AudioManager.Get().PlayMusic(AssetPaths.NormalBattle__wav);
        
        //Test set substate
        this.openSubState(new GamePlayState());
        this.persistentUpdate = true;
        //---------------------------------------------------------------------------------------
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