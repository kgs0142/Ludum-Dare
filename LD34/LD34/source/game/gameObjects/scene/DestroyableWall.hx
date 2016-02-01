package game.gameObjects.scene;

import utils.AssetPaths;

/**
 * ...
 * @author Husky
 */
class DestroyableWall extends BaseGameObject
{

    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
        
        this.loadGraphic(AssetPaths.test__png, false, 32, 32);
        
        this.solid = true;
        this.immovable = true;
        
        this.animation.add("default", [0], 0, false);
        this.animation.play("default");
    }
}