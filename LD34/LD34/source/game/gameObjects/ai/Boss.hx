package game.gameObjects.ai;

import core.system.AudioManager;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;
import game.gameObjects.BaseGameObject;
import game.gameState.GamePlayState;
import utils.AssetPaths;

/**
 * ...
 * @author Husky
 */
class Boss extends FlxSpriteGroup
{
    private static var MIN_JUMP_DELAY:Float = 3.0;
    private static var MAX_JUMP_DELAY:Float = 8.0;
    
    private static var JUMP_HEIGHT:Float = 200.0;
    private static var JUMP_DISTANCE:Float = 350.0;
    private static var JUMP_DURATION:Float = 2.0;
    
    private var body:BossBody;
    
    private var leftLeg:BaseGameObject;
    private var rightLeg:BaseGameObject;
    
    private var playState:GamePlayState;
    
    private var nextJumpDir = FlxObject.LEFT;
    
    private var firstMeet:Bool = false;
    
    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
		
        playState = cast(FlxG.state.subState, GamePlayState);
        
        body = new BossBody(0, 0);
        
        leftLeg = new BaseGameObject();
        leftLeg.makeGraphic(1, 1);
        leftLeg.solid = true;
        leftLeg.immovable = true;
        //leftLeg.immovable = true;
        
        rightLeg = new BaseGameObject();
        rightLeg.makeGraphic(1, 1);
        rightLeg.solid = true;
        rightLeg.immovable = true;
        //rightLeg.immovable = true;
        
        this.add(body);
        this.add(leftLeg);
        this.add(rightLeg);
    }
    
    public function Initial():Void 
    {
        //origin.set(48 * 0.5 * body.scale.x, 48 * 0.5 * body.scale.y);

        body.width = 24 * body.scale.x;
        body.height = 24 * body.scale.y;
        
		body.offset.set(24 * 0.5 * body.scale.x, 24 * 0.5 * body.scale.y);
        
        this.centerOrigin();
        
        this.y -= 32 * body.scale.y;
        
        leftLeg.width = 20;
        leftLeg.height = 100;
        leftLeg.setPosition(this.x + 24, this.y + 200);
        
        rightLeg.width = 20;
        rightLeg.height = 100;
        rightLeg.setPosition(this.x + 160, this.y + 200);
        
        new FlxTimer(MIN_JUMP_DELAY + (Math.random() * MAX_JUMP_DELAY - MIN_JUMP_DELAY), this.DoJump, 1);
    }
    
    override public function update():Void 
    {
        super.update();
        
        if (body.alive == false)
        {
            this.kill();
        }
        
        if (FlxG.keys.pressed.Q)
        {
            this.x -= 10;
            this.facing = FlxObject.LEFT;
        }
        else if (FlxG.keys.pressed.W)
        {
            this.x += 10;
            this.facing = FlxObject.RIGHT;
        }
        
        AnimationUpdate();
        
        //FlxG.collide(leftLeg, playState.player);
        
        //FlxG.collide(rightLeg, playState.player);
        
        FlxG.overlap(leftLeg, playState.player, OverlapPlayerHandler);
        FlxG.overlap(rightLeg, playState.player, OverlapPlayerHandler);
        FlxG.overlap(body, playState.player, OverlapPlayerHandler);
    }
    
    private function DoJump(timer:FlxTimer):Void 
    {
        var source:FlxPoint = new FlxPoint(this.x, this.y);
        var goal:FlxPoint = new FlxPoint(this.x, this.y);
        
        if (nextJumpDir == FlxObject.LEFT)
        {
            goal.x -= JUMP_DISTANCE;
            goal.y -= JUMP_HEIGHT;
            
            nextJumpDir = FlxObject.RIGHT;
        }
        else
        {
            goal.x += JUMP_DISTANCE;
            goal.y -= JUMP_HEIGHT;
            
            nextJumpDir = FlxObject.LEFT;
        }
        
        FlxTween.tween(this, {x:goal.x}, JUMP_DURATION, {complete:function (tween:FlxTween):Void 
        {
            new FlxTimer(MIN_JUMP_DELAY + (Math.random() * MAX_JUMP_DELAY - MIN_JUMP_DELAY), this.DoJump, 1);
        }});
        
        FlxTween.tween(this, {y:goal.y}, JUMP_DURATION/2, {complete:function (tween:FlxTween):Void 
        {
            FlxTween.tween(this, {y:source.y}, JUMP_DURATION/2);
        }});
    }
    
    private function AnimationUpdate():Void
    {
        var distance:Int = FlxMath.distanceBetween(this, playState.player);
        
        var isPlayerLeft = playState.player.x < body.x;
        
        body.set_facing((isPlayerLeft == true) ? FlxObject.LEFT : FlxObject.RIGHT);
        
        if (distance > 500)
        {
            body.animation.play("idle");
            return;
        }
        
        if (firstMeet == false)
        {
            firstMeet = true;
            AudioManager.Get().PlayMusic(AssetPaths.BossBattle__wav);
        }
        
        body.animation.play("attack");
    }
    
    private function OverlapPlayerHandler(Body:FlxObject, Player:FlxObject):Void 
    {
        var isPlayerLeft = playState.player.x < body.x;
        var isPlayerUp:Bool = playState.player.y < body.y + body.offset.y;
        
        //trace("isPlayerUp: " + isPlayerUp);
        
        //being jump attack
        //if (player.isTouching(FlxObject.DOWN) 
        if (isPlayerUp == true)
            //&& player.animation.name == "jumpUp" || player.animation.name == "falling" )
        {
            if (body.IsInvincible() == true)
            {
                return;
            }
            
            var forceVelocity:FlxPoint = new FlxPoint();
            forceVelocity.x = playState.player.velocity.x*1.5;
            forceVelocity.y = -playState.player.velocity.y*1.5;
            playState.player.velocity = forceVelocity;
            
            body.hurt(5.0);
        }
        //hurt player currently
        else if (playState.player.IsInvincible() == false)
        {
            playState.player.hurt(5);
            
            var forceVelocity:FlxPoint = new FlxPoint();
            forceVelocity.x = (isPlayerLeft == true) ? -200 : 200;
            forceVelocity.y = -100;
            playState.player.velocity = forceVelocity;
        }
    }
    
    override public function hurt(Damage:Float):Void 
    {
        body.hurt(Damage);
        
        AudioManager.Get().PlaySound(AssetPaths.Hit_Hurt3__wav);
    }
    
    public function IsBodyAlive():Bool
    {
        return body.alive;
    }
    
    public function IsInvincible():Bool
    {
        return body.IsInvincible();
    }
}