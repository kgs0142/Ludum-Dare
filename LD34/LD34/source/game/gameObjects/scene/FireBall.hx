package game.gameObjects.scene;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import game.gameObjects.ai.Protagonist;
import game.gameState.GamePlayState;
import utils.AssetPaths;

/**
 * ...
 * @author Husky
 */
class FireBall extends BaseGameObject
{

    private var playState:GamePlayState;
    
    public function new(X, Y) 
    {
        super(X, Y);
		
        this.makeGraphic(16, 16, FlxColor.RED);
        
        this.width = this.height = 16;
        
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
        
        FlxG.overlap(this, playState.player, OverlapHandler);
    }
    
    private function KillSelf(obj:FlxObject, bullet:FlxObject):Void 
    {
        this.kill();
    }
    
    private function OverlapHandler(obj:FlxObject, Player:FlxObject):Void 
    {
        //hit player, do damage.
        var player:Protagonist = cast(Player, Protagonist);
        if (player.IsInvincible() == true)
        {
            return;
        }
        
        trace("player touch fireball!");
        
        FlxG.camera.flash(FlxColor.WHITE, 0.05);

        player.hurt(5);
    }
}