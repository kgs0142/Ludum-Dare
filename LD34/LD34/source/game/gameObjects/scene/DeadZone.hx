package game.gameObjects.scene;

import flixel.FlxG;
import game.gameObjects.ai.Protagonist;
import game.gameObjects.BaseGameObject;

/**
 * ...
 * @author Husky
 */
class DeadZone extends BaseGameObject
{

    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
        
        this.makeGraphic(1, 1);
    }
    
    override public function OverlapPlayerHandler(player:Protagonist):Void 
    {
        super.OverlapPlayerHandler(player);
        
        //FlxG.resetState();
        player.hurt(10000);
    }
}