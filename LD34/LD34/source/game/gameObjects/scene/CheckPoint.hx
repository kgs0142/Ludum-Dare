package game.gameObjects.scene;

import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import game.gameObjects.ai.Protagonist;
import game.gameObjects.BaseGameObject;

/**
 * ...
 * @author Husky
 */
class CheckPoint extends BaseGameObject
{
    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
		
        this.makeGraphic(1, 1, FlxColor.TRANSPARENT);
    }
    
    override public function OverlapPlayerHandler(player:Protagonist):Void 
    {
        super.OverlapPlayerHandler(player);
        
        player.SetCheckPoint(new FlxPoint(this.x, this.y));
        
        trace("SetCheckPoint: " + this.x + ", " + this.y);
    }
}