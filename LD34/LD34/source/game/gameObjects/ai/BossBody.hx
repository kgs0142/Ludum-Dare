package game.gameObjects.ai;

import core.system.AudioManager;
import flixel.addons.editors.tiled.TiledLayer;
import flixel.effects.FlxFlicker;
import flixel.FlxG;
import flixel.FlxObject;
import utils.AssetPaths;

/**
 * ...
 * @author Husky
 */
class BossBody extends BaseGameObject
{
    private static var INVINCIBLE_DURATION:Float = 0.5;
    
    private var invincibleDuration = 0.0;
    
    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
        
        this.health = 100;
        //this.health = 5;
        
        this.loadGraphic(AssetPaths.Monster_sheet__png, true, 48, 48);
        this.scale.set(8, 8);
        this.animation.add("idle", [3], 1, true);
        this.animation.add("attack", [0, 1, 2], 10, true);
        this.animation.play("idle");
        
        this.setFacingFlip(FlxObject.LEFT, false, false);
		this.setFacingFlip(FlxObject.RIGHT, true, false);
    }
 
    override public function update():Void 
    {
        super.update();
        
        this.invincibleDuration -= FlxG.elapsed;
    }
    
    override public function hurt(Damage:Float):Void 
    {
        super.hurt(Damage);
        
        this.invincibleDuration = INVINCIBLE_DURATION;
        
        FlxFlicker.flicker(this, INVINCIBLE_DURATION);
        
        AudioManager.Get().PlaySound(AssetPaths.Hit_Hurt3__wav);
    }
    
    override public function kill():Void 
    {
        super.kill();
        
        AudioManager.Get().PlaySound(AssetPaths.Dead__wav);
    }
    
    public function IsInvincible():Bool
    {
        return (this.invincibleDuration > 0.0);
    }
}