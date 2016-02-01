package game.gameState;

import flixel.FlxG;
import flixel.FlxSubState;

/**
 * All these state all working as a logic strategy in different gameModule as a "subState".
 * @author Husky
 */
class BaseGameState extends FlxSubState
{
/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
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