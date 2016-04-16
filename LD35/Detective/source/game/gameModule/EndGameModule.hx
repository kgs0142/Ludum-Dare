package game.gameModule;

import flixel.FlxState;

/**
 * ...
 * @author Husky
 */
class EndGameModule extends FlxState
{
	override public function create():Void
	{
		super.create();
        
        trace("End game module");
    }
    
    override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);    
    }
}