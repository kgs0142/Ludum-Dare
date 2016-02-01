package game.gameObjects.ai;

import core.system.AudioManager;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import game.gameObjects.ai.Protagonist;
import game.gameObjects.BaseGameObject;
import game.gameState.GamePlayState;
import utils.AssetPaths;

/**
 * ...
 * @author Husky
 */
class Monster_01 extends BaseGameObject
{
    private var playState:GamePlayState;
    
    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
		
        this.health = 5;
        
        this.loadGraphic(AssetPaths.Monster_sheet__png, true, 48, 48);
        
        this.scale.set(2, 2);
        
        this.height = 64;
        
        this.animation.add("idle", [3], 1, true);
        this.animation.add("attack", [0, 1, 2], 10, true);
        
        this.animation.play("idle");
        
        this.setFacingFlip(FlxObject.LEFT, false, false);
		this.setFacingFlip(FlxObject.RIGHT, true, false);
        
        playState = cast(FlxG.state.subState, GamePlayState);
    }
    
    override public function Initial():Void 
    {
        super.Initial();
        
        this.centerOffsets(true);

        this.x -= 24;
        this.y -= 32;
        
        //this.offset.set(24, 32);
        
        //this.centerOrigin();
    }
    
    override public function update():Void 
    {
        super.update();
        
        var distance:Int = FlxMath.distanceBetween(this, playState.player);
        
        if (distance > 100)
        {
            animation.play("idle");
            return;
        }
        
        animation.play("attack");
        
        var isPlayerLeft = playState.player.x < this.x;
        
        this.set_facing((isPlayerLeft == true) ? FlxObject.LEFT : FlxObject.RIGHT);
    }
    
    override public function OverlapPlayerHandler(player:Protagonist):Void 
    {
        super.OverlapPlayerHandler(player);
        
        var isPlayerLeft = player.x < this.x;
        
        var isPlayerUp:Bool = player.y < this.y - this.offset.y;
        
        //trace("isPlayerLeft: " + isPlayerLeft);
        //trace("isPlayerUp: " + isPlayerUp);
        
        //being jump attack
        //if (player.isTouching(FlxObject.DOWN) 
        if (isPlayerUp == true)
            //&& player.animation.name == "jumpUp" || player.animation.name == "falling" )
        {
            var forceVelocity:FlxPoint = new FlxPoint();
            forceVelocity.x = player.velocity.x*1.5;
            forceVelocity.y = -player.velocity.y*1.5;
            player.velocity = forceVelocity;
            
            this.kill();
        }
        //hurt player currently
        else if (player.IsInvincible() == false)
        {
            player.hurt(5);
            
            var forceVelocity:FlxPoint = new FlxPoint();
            forceVelocity.x = (isPlayerLeft == true) ? -200 : 200;
            forceVelocity.y = -100;
            player.velocity = forceVelocity;
        }
    }
    
    override public function kill():Void 
    {
        super.kill();
        
        AudioManager.Get().PlaySound(AssetPaths.Dead__wav);
    }
    
    override public function hurt(Damage:Float):Void 
    {
        super.hurt(Damage);
        
        AudioManager.Get().PlaySound(AssetPaths.Hit_Hurt3__wav);
    }
}