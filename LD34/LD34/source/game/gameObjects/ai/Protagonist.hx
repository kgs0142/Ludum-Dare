package game.gameObjects.ai;

import core.system.AudioManager;
import flixel.addons.display.FlxExtendedSprite;
import flixel.addons.display.shapes.FlxShapeDoubleCircle;
import flixel.addons.plugin.control.FlxControl;
import flixel.addons.plugin.control.FlxControlHandler;
import flixel.effects.FlxFlicker;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;
import game.gameObjects.Bullet;
import game.gameState.GamePlayState;
import openfl.utils.AGALMiniAssembler;
import utils.AssetPaths;

/**
 * ...
 * @author Husky
 */
class Protagonist extends BaseGameObject
{
    private static var INVINCIBLE_DURATION:Float = 1.0;
    
    private var invincibleDuration = 0.0;
    
    private var checkPoint:FlxPoint = new FlxPoint();
    
    private var playState:GamePlayState;
    
    private var playDieing:Bool = false;
    private var playDancing:Bool = false;
    
    private var hpBar:FlxBar;
    
    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
		
        //Debug------------------------------------------------------------------------------
        FlxG.watch.add(this.animation, "name", "curAnim");
        FlxG.watch.add(this.velocity, "x", "velocity_x");
        FlxG.watch.add(this.acceleration, "x", "acceleration_x");
        FlxG.watch.add(this.acceleration, "y", "acceleration_y");
        //------------------------------------------------------------------------------
        
        this.health = 30;
        
        //graphic, animations----------------------------------------------------------------
        this.loadGraphic(AssetPaths.Protagonist__png, true, 32, 32);
        
        this.setFacingFlip(FlxObject.LEFT, true, false);
		this.setFacingFlip(FlxObject.RIGHT, false, false);
        
        this.width = 16;
        this.height = 16;
        this.offset.x = 10;
        this.offset.y = 13;
        
        this.animation.add("idle", [0, 1], 10, true);
        this.animation.add("initialRun", [2, 3, 4, 5], 2, false);
        this.animation.add("run", [6, 7], 20, true);
        this.animation.add("slideBlade", [8, 9, 10, 11], 15, false);
        this.animation.add("jumpUp", [12, 13], 10, true);
        this.animation.add("falling", [14, 15], 10, true);
        this.animation.add("dead", [16, 17, 18, 19, 20], 10, false);
        this.animation.add("dance", [21, 22, 23, 24, 21, 22, 23, 24, 25, 26, 27, 28, 29], 10, false);
        
        this.animation.play("idle");
        
        //controlling behaviours----------------------------------------------------------------
        this.drag.set(150, 50);
        this.collisonXDrag = true;
        
        this.maxVelocity.set(300, 600);
        
        this.acceleration.y = 600;
        
        playState = cast(FlxG.state.subState, GamePlayState);
        
        // The player sprite will accelerate and decelerate smoothly
        //FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES);
        // Enable cursor keys, but only the left and right ones
        //FlxControl.player1.setCursorControl(false, false, true, true);
        // Gravity will pull the player down
        //FlxControl.player1.setGravity(0, 400);
        // All speeds are in pixels per second, the follow lets the player run left/right
        //FlxControl.player1.setMovementSpeed(400, 0, 100, 200, 400, 0);
        
        //UI
        hpBar = new FlxBar(10, 10, FlxBar.FILL_LEFT_TO_RIGHT, 100, 10, this, "health", 0, 30);
        hpBar.color = FlxColor.CHARTREUSE;
        hpBar.scrollFactor.set(0, 0);
        playState.add(hpBar);
        //new(x:Float = 0, y:Float = 0, direction:Int = FILL_LEFT_TO_RIGHT, width:Int = 100, height:Int = 10, parentRef:Dynamic, variable:String = "", min:Float = 0, max:Float = 100, border:Bool = false)
    }
    
    override public function Initial():Void 
    {
        super.Initial();
        
        checkPoint = new FlxPoint(this.x, this.y);
    }
    
    override public function kill():Void 
    {
        super.kill();
        
        var instance:Protagonist = this;
 
        FlxG.camera.fade(FlxColor.BLACK, 0.5, true, function ():Void 
        {
            //FlxG.camera.fade(FlxColor.BLACK, 0.5, true, function ():Void 
            //{
                instance.health = 30;
                instance.x = checkPoint.x;
                instance.y = checkPoint.y;
                
                trace("SetCheckPoint: " + checkPoint.x + ", " + checkPoint.y);
                
                instance.revive();
                
                playState.level.overlapableObjects.forEachDead(function (dead:FlxBasic):Void 
                {
                    dead.revive();
                });
            //});
        });
    }
    
    override public function update():Void 
    {
        if (playState.boss.IsBodyAlive() == false && this.isTouching(FlxObject.DOWN))
        {
            if (playDancing == false)
            {
                trace("Boss is dead, Play stand on floor");
                playDancing = true;
                
                this.velocity.set(0, 0);
                this.acceleration.set(0, 0);
                
                this.animation.play("dance");
                
                playState.GameClearHandler();
            }
        }
        
        this.ControllerUpdate();   
        
        super.update();
        
        this.AnimationUpdate();
        
        this.invincibleDuration -= FlxG.elapsed;
    }
    
    private function AnimationUpdate():Void 
    {
        if (this.playDieing == true)
        {
            return;
        }
        
        if (this.playDancing == true)
        {
            return;
        }
        
        if (animation.name == "slideBlade" && animation.finished == false)
        {
            return;
        }
        
        var absSpeed:Float = Math.abs(velocity.x);
        var rightDir:Bool = (velocity.x >= 0);
        
        this.facing = (rightDir == true) ? FlxObject.RIGHT : FlxObject.LEFT;

        // ANIMATION
		if (this.velocity.y < 0 && this.acceleration.y > 5)
		{
            animation.play("jumpUp", false);
		}
        else if (this.velocity.y > 0 && this.acceleration.y > 5)
        {
            animation.play("falling", false);
        }
		else if (absSpeed == 0)
		{
            animation.play("idle", false);
		}
		else if (absSpeed > 0)
		{
            if (absSpeed < 101)
            {
                animation.play("initialRun", false);
            }
            else
            {
                animation.play("run", false);
            }
		}
    }
    
    private function ControllerUpdate():Void 
    {
        if (this.playDieing == true)
        {
            return;
        }
        
        if (this.playDancing == true)
        {
            return;
        }
        
        //if it's landing
        if (this.isTouching(FlxObject.DOWN))
        {
            this.acceleration.y = 1;
        }
        else 
        {
            this.acceleration.y = 600;
        }
        
        //Jump on wall, right
        if (FlxG.keys.anyPressed(["Z"]) && FlxG.keys.anyJustPressed(["X"]) && this.isTouching(FlxObject.RIGHT))
        {
            //trace("Jump on wall, right!");
            this.velocity.y = -300;
            this.velocity.x = -300;
            //this.acceleration.x = -1;
            //this.acceleration.x = -100;
            AudioManager.Get().PlaySound(AssetPaths.Jump__wav);
        }
        else if (FlxG.keys.anyJustPressed(["Z"]) && FlxG.keys.anyPressed(["X"]) && this.isTouching(FlxObject.RIGHT))
        {
            //trace("Jump on wall, right!");
            this.velocity.y = -300;
            this.velocity.x = -300;
            //this.acceleration.x = -1;
            //this.acceleration.x = -100;
            AudioManager.Get().PlaySound(AssetPaths.Jump__wav);
        }
        //Jump on wall, left
        else if (FlxG.keys.anyPressed(["Z"]) && FlxG.keys.anyJustPressed(["X"]) && this.isTouching(FlxObject.LEFT))
        {
            //trace("Jump on wall, left!");
            this.velocity.y = -300;
            this.velocity.x = 300;
            //this.acceleration.x = 1;
            //this.acceleration.x = 100;
            AudioManager.Get().PlaySound(AssetPaths.Jump__wav);
        }
        else if (FlxG.keys.anyJustPressed(["Z"]) && FlxG.keys.anyPressed(["X"]) && this.isTouching(FlxObject.LEFT))
        {
            //trace("Jump on wall, left!");
            this.velocity.y = -300;
            this.velocity.x = 300;
            //this.acceleration.x = 1;
            //this.acceleration.x = 100;
            AudioManager.Get().PlaySound(AssetPaths.Jump__wav);
        }
        //Jump
        else if (FlxG.keys.anyPressed(["Z"]) && FlxG.keys.anyJustPressed(["X"]) && this.isTouching(FlxObject.FLOOR))
        {
            //trace("jump!");
            this.velocity.y = -300;
            AudioManager.Get().PlaySound(AssetPaths.Jump__wav);
        }
        else if (FlxG.keys.anyJustPressed(["Z"]) && FlxG.keys.anyPressed(["X"]) && this.isTouching(FlxObject.FLOOR))
        {
            //trace("jump!");
            this.velocity.y = -300;
            AudioManager.Get().PlaySound(AssetPaths.Jump__wav);
        }
        //Move Left
        else if (FlxG.keys.justPressed.Z) 
        {
            //trace("tried run to left");
            //increase left speed , or if you had enough speed to right, it will cast a slid-blade
            //this.acceleration.x -= 50;
            this.velocity.x -= 100;
            //this.acceleration.x = -1;
            
            if (this.velocity.x > 0)
            {
                //this.acceleration.x = -100;
                //this.acceleration.x = -1;
                this.velocity.x = -150;
                
                //this.facing = FlxObject.LEFT;
                this.facing = FlxObject.RIGHT;
                animation.play("slideBlade", true);
                
                //var bullet:Bullet = new Bullet(this.x, this.y + 2);
                var bullet:Bullet = new Bullet(this.x, this.y);
                bullet.facing = FlxObject.RIGHT;
                bullet.velocity.x = 100;
                bullet.acceleration.x = 600;
                FlxG.state.subState.add(bullet);
                
                AudioManager.Get().PlaySound(AssetPaths.Shoot__wav);
            }
        }
        //Move Right
        else if (FlxG.keys.justPressed.X) 
        {
            //trace("tried run to right");
            //increase right speed , or if you had enough speed to left, it will cast a slid-blade
            //this.acceleration.x += 50;
            this.velocity.x += 100;
            //this.acceleration.x = 1;
            
            if (this.velocity.x < 0)
            {
                //this.acceleration.x = 100;
                //this.acceleration.x = 1;
                this.velocity.x = 150;
                
                //this.facing = FlxObject.RIGHT;
                this.facing = FlxObject.LEFT;
                animation.play("slideBlade", true);
                
                //var bullet:Bullet = new Bullet(this.x, this.y + 2);
                var bullet:Bullet = new Bullet(this.x, this.y);
                bullet.facing = FlxObject.LEFT;
                bullet.velocity.x = -100;
                bullet.acceleration.x = -600;
                FlxG.state.subState.add(bullet);
                
                AudioManager.Get().PlaySound(AssetPaths.Shoot__wav);
            }
        }
        
        //Trick processing for acceleration.x
        this.acceleration.x = 0;
        
        if (FlxG.keys.pressed.Z && this.isTouching(FlxObject.LEFT)) 
        {
            this.acceleration.x = (this.facing == FlxObject.RIGHT) ? 1 : -1;
        }
        else if (FlxG.keys.pressed.X && this.isTouching(FlxObject.RIGHT)) 
        {
            this.acceleration.x = (this.facing == FlxObject.RIGHT) ? 1 : -1;
        }
        //if (FlxG.keys.pressed.Z && this.isTouching(FlxObject.LEFT)) 
        else if (FlxG.keys.pressed.Z) 
        {
            this.acceleration.x = (this.facing == FlxObject.RIGHT) ? 1 : -1;
            //this.acceleration.x = -1;
            //trace("hold left (wall)");
            //this.velocity.x -= 10;
            //this.acceleration.y = 10;
            //this.velocity.y = 10;
        }
        //else if (FlxG.keys.pressed.X && this.isTouching(FlxObject.RIGHT)) 
        else if (FlxG.keys.pressed.X) 
        {
            this.acceleration.x = (this.facing == FlxObject.RIGHT) ? 1 : -1;
            //this.acceleration.x = 1;
            //trace("hold right (wall)");
            //this.velocity.x += 10;
            //this.acceleration.y = 10;
            //this.velocity.y = 10;
        }
    }
    
    override public function hurt(Damage:Float):Void 
    {
        //this.playDieing = (this.health <= Damage);
        
        //if (playDieing == false)
        if (this.health > Damage)
        {
            super.hurt(Damage);
            
            this.invincibleDuration = INVINCIBLE_DURATION;
            
            FlxFlicker.flicker(this, INVINCIBLE_DURATION);
            
            AudioManager.Get().PlaySound(AssetPaths.Hit_Hurt3__wav);
        }
        else if (this.playDieing == false)
        {
            this.animation.play("dead");
            
            this.playDieing  = true;
            this.invincibleDuration = 1000;
            
            var instance:Protagonist = this;
            new FlxTimer(2.0, function (timer:FlxTimer):Void 
            {
                instance.playDieing = false;
                instance.invincibleDuration = 0.0;
                
                //instance.hurt(Damage);
                instance.kill();
            });
        }
    }
    
    public function SetCheckPoint(point:FlxPoint):Void
    {
        checkPoint.x = point.x;
        checkPoint.y = point.y;
    }
    
    public function IsInvincible():Bool
    {
        return (this.invincibleDuration > 0.0);
    }
}