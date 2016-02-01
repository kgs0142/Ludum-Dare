package game.gameObjects.scene;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import game.gameObjects.BaseGameObject;
import game.gameState.GamePlayState;
import utils.AssetPaths;

/**
 * ...
 * @author Husky
 */
class Launcher extends BaseGameObject
{
    private var fireDir:Int = FlxObject.NONE;
    private var fireDelay:Float = 0.0;
    
    private var playState:GamePlayState;
    
    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);

        this.loadGraphic(AssetPaths.test__png, false, 32, 32);
        
        this.animation.add("default", [13], 0, false);
        this.animation.play("default");
        
        playState = cast(FlxG.state.subState, GamePlayState);
    }
    
    override public function destroy():Void 
    {
        super.destroy();
    }
    
    override public function Initial():Void 
    {
        super.Initial();
        
        new FlxTimer(fireDelay, FireBullet, 1);
    }
    
    private function FireBullet(Timer:FlxTimer):Void
    {
        if (this.alive == false)
        {
            trace("this.alive == false");
            return;
        }
        
        var fireBall:FireBall = new FireBall(this.x, this.y);
        switch (fireDir) 
        {
            case FlxObject.DOWN:
                fireBall.velocity.y = 200;
                fireBall.acceleration.y = 300;
                
            default:
                fireBall.velocity.y = 200;
                fireBall.acceleration.y = 300;
        }
        
        //FlxG.state.subState.add(fireBall);
        playState.level.backgroundTiles.add(fireBall);
        
        new FlxTimer(fireDelay, FireBullet, 1);
    }
    
    public function SetDirection(dir:String)
    {
        switch (dir) 
        {
            case "DOWN":
                this.fireDir = FlxObject.DOWN;
                
            default:
                this.fireDir = FlxObject.DOWN;
        }
    }
    
    public function SetFireDelay(delay:Float):Void 
    {
        this.fireDelay = delay;
    }
}