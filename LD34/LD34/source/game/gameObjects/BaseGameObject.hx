package game.gameObjects;

import flixel.FlxSprite;
import game.gameObjects.ai.Protagonist;

/**
 * ...
 * @author Husky
 */
class BaseGameObject extends FlxSprite
{

    public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
    {
        super(X, Y, SimpleGraphic);
    }
    
    public function Initial():Void 
    {
        
    }
    
    public function OverlapPlayerHandler(player:Protagonist):Void 
    {
        
    }
    
    public function CollidePlayerHandler(player:Protagonist):Void 
    {
        
    }
}