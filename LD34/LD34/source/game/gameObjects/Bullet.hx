package game.gameObjects;

import flixel.FlxG;
import flixel.FlxObject;
import game.gameObjects.ai.Monster_01;
import game.gameObjects.scene.DestroyableWall;
import game.gameState.GamePlayState;
import utils.AssetPaths;

/**
 * ...
 * @author Husky
 */
class Bullet extends BaseGameObject
{
    private var playState:GamePlayState;
    
    public function new(X, Y) 
    {
        super(X, Y);
		
        this.loadGraphic(AssetPaths.ojects__png, true, 16, 16);
        
        this.animation.add("play", [0, 1, 2, 1], 10, true);
        
        this.animation.play("play");
        
        this.setFacingFlip(FlxObject.LEFT, true, false);
		this.setFacingFlip(FlxObject.RIGHT, false, false);
        
        playState = cast(FlxG.state.subState, GamePlayState);
    }
    
    override public function update():Void 
    {
        super.update();
        
        if (this.isOnScreen() == false)
        {
            this.kill();
            return;
        }
        
        playState.level.collideWithLevel(this, KillSelf);
        
		playState.level.OverlapWithObjects(this, OverlapHandler);
        
		playState.level.CollideWithObjects(this, CollideHandler);
        
        FlxG.overlap(this, playState.boss, HitBossHandler);
        FlxG.collide(this, playState.boss, HitBossHandler);
    }
    
    private function KillSelf(obj:FlxObject, bullet:FlxObject):Void 
    {
        this.kill();
    }
    
    private function HitBossHandler(bullet:FlxObject, boss:FlxObject):Void 
    {
        this.kill();

        if (playState.boss.IsInvincible() == true)        
        {
            return;
        }
        
        playState.boss.hurt(5);
    }
    
    private function CollideHandler(obj:FlxObject, bullet:FlxObject):Void 
    {
        //break DestroyableWall
        if (Std.is(obj, DestroyableWall) == true)
        {
            obj.kill();
        }
        
        this.kill();
    }
    
    private function OverlapHandler(obj:FlxObject, bullet:FlxObject):Void 
    {
        //hit monster, do damage.
        if (Std.is(obj, Monster_01) == true)
        {
            var monster:Monster_01 = cast(obj, Monster_01);
            monster.hurt(5);
            monster.kill();
            
            this.kill();
        }
    }
}