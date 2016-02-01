package game.gameObjects.scene;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import game.gameObjects.ai.Protagonist;
import utils.AssetPaths;

/**
 * ...
 * @author Husky
 */
class Spike extends BaseGameObject
{

    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
        
        this.loadGraphic(AssetPaths.test__png, false, 32, 32);
        
        //this.solid = true;
        //this.immovable = true;
        
        this.width = 12;
        this.height = 14;
        
        //this.offset.set(8, 20);
        //x += offset.x;
        //y += offset.y;
        //this.origin.set(16, 32);
        this.centerOffsets(true);
        this.centerOrigin();
        
        this.animation.add("default", [5], 0, false);
        this.animation.play("default");
    }
    
    override public function OverlapPlayerHandler(player:Protagonist):Void 
    {
        super.OverlapPlayerHandler(player);
        
        if (player.IsInvincible() == true)
        {
            return;
        }
        
        trace("player touch spike!");
        
        //FlxG.camera.flash(FlxColor.WHITE, 0.05);

        player.hurt(5);
        
        //var forceVelocity:FlxPoint = new FlxPoint();
        //forceVelocity.x = -player.velocity.x*2;
        //forceVelocity.y = -player.velocity.y*2;
        //player.velocity = forceVelocity;
    }
}