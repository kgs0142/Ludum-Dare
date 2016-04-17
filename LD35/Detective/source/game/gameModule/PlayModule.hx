package game.gameModule;

import core.misc.CustomInterp;
import core.system.HScriptManager;
import flixel.addons.ui.FlxSlider;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import game.manager.AudioManager;
import game.manager.LevelManager;
import game.object.SpritePiece;
import haxe.Timer;

using core.util.CustomExtension;


/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayModule extends FlxState
{
    private static inline var SCALE_RANGE:Float = 0.05; 
    private static inline var ANGLE_RANGE:Float = 5; 
    
    private var interp:CustomInterp;
    
    private var spritePieceGroup:FlxSpriteGroup;
    private var spritePieceArray:Array<SpritePiece>;
    
    private var sliderScaleX:FlxSlider;
    private var sliderScaleY:FlxSlider;
    private var sliderAngle:FlxSlider;
    
    private var assignPuzzleScaleX:Float = 0;
    private var assignPuzzleScaleY:Float = 0;
    private var assignPuzzleAngle:Float = 0;
    
    private var puzzleScaleXFactor:Float = 0;
    private var puzzleScaleYFactor:Float = 0;
    private var puzzleAngleFactor:Float = 0;
    
    private var collideSprite:FlxSprite;
    
    private var mouseCursor:FlxSprite;
    
    //----------------------------------
    private var shadowSpr:FlxSprite;
    private var bgSpr:FlxSprite;
    //------------------------------
    private var doingLevelClearProcess:Bool= false;
    
    private var collisionPieceCount:Int = 0;
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
        
        var levelScriptName = LevelManager.Get().GetLevelScriptName();
        if (levelScriptName == "")
        {
            trace("game clear!");
            
            //switch to clear state.
            FlxG.switchState(new EndGameModule());
            
            return;
        }
        
        trace("level script: " + levelScriptName);
        
        this.spritePieceArray = new Array<SpritePiece>();
        this.spritePieceGroup = new FlxSpriteGroup();
        
        FlxG.watch.add(this, "assignPuzzleScaleX", "assignPuzzleScaleX:");
        FlxG.watch.add(this, "assignPuzzleScaleY", "assignPuzzleScaleY:");
        FlxG.watch.add(this, "assignPuzzleAngle", "assignPuzzleAngle:");
        FlxG.watch.add(this.spritePieceArray, "length", "TotalPieces:");
        FlxG.watch.add(this, "collisionPieceCount", "CollisionPieceCount:");
        //
        
        interp = new CustomInterp();
        interp.CommonInitial();
        
        interp.variables.set("SpritePiece", SpritePiece);
        interp.variables.set("FlxSlider", FlxSlider);
        
        interp.variables.set("this", this);
        interp.variables.set("UpdateFunction", function () : Void {});

        //--------------------------------------------------------------------------------------
        
        interp.execute(HScriptManager.Get().GetParsedScript(levelScriptName));
        
        interp.variables.get("CreateFunction")();
        
        this.collideSprite = new FlxSprite();
        this.collideSprite.setPosition(8*2, 8*2);
        this.collideSprite.makeGraphic(128, 128, FlxColor.BLACK);
        //this.add(collideSprite);
        
        sliderScaleX = new FlxSlider(this, "assignPuzzleScaleX", -8*1, 8*20, -2, 2, 8*6, 8*2);
        this.sliderScaleX.setTexts("X", false, "-", "+");
        this.add(sliderScaleX);

        sliderScaleY = new FlxSlider(this, "assignPuzzleScaleY", 8*6, 8*20, -2, 2, 8*6, 8*2);
        this.sliderScaleY.setTexts("Y", false, "-", "+");
        this.add(sliderScaleY);

        sliderAngle = new FlxSlider(this, "assignPuzzleAngle", 8*13, 8*20, 0, 360, 8*6, 8*2);
        this.sliderAngle.setTexts("R", false, "-", "+");
        this.add(sliderAngle);
        
        this.mouseCursor = new FlxSprite();
        this.mouseCursor.loadGraphic(AssetPaths.Hand__png, true, 8, 8);
        this.mouseCursor.animation.add("default", [0], 0, false);
        this.mouseCursor.animation.add("press", [1], 0, false);
        this.add(mouseCursor);
        
        FlxG.mouse.visible = false;
        
        AudioManager.Get().MusicFadeOutAndBGMFadeIn();
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
        
        interp = null;
        
        if (spritePieceArray != null)
        {
            spritePieceArray.splice(0, spritePieceArray.length - 1);
            spritePieceArray = null;
        }
	}

    private function CreatePuzzlePieces() : Void 
    {
        for (i in 0 ... this.spritePieceArray.length)
        {
            spritePieceArray[i].CreatePuzzlePieceProcess();
        }
    }
    
    private function AddPiecesToGroup() : Void
    {
        for (i in 0 ... this.spritePieceArray.length)
        {
            this.spritePieceGroup.add(spritePieceArray[i]);
        }
    }
    
    private function SetPuzzleValues(scaleX:Float, scaleY:Float, angle:Float):Void 
    {
        this.puzzleScaleXFactor = scaleX;
        this.puzzleScaleYFactor = scaleY;
        this.puzzleAngleFactor = angle;
        
        for (piece in spritePieceArray)
        {
            piece.puzzleScaleXFactor = scaleX;
            piece.puzzleScaleYFactor = scaleY;
            piece.puzzleAngleFactor = angle;
        }
    }
    
    //{ Set group functions
    private function AssignPuzzleValues():Void 
    {
        if (this.doingLevelClearProcess == true)
        {
            return;
        }
        
        for (piece in spritePieceArray)
        {
            piece.puzzleScaleX = sliderScaleX.value;
            piece.puzzleScaleY = sliderScaleY.value;
            piece.puzzleAngle = sliderAngle.value;
        }
    }
    
    //}    
    
    private function UpdateCursor():Void 
    {
        this.mouseCursor.setPosition(FlxG.mouse.x - 4, FlxG.mouse.y);
        
        if (FlxG.mouse.pressed == false)
        {
            this.mouseCursor.animation.play("default");
        }
        else 
        {
            this.mouseCursor.animation.play("press");
        }
    }
    
    private function CheckCollisionCount():Void 
    {
        this.collisionPieceCount = 0;
        for (piece in spritePieceArray)
        {
            if (FlxCollision.pixelPerfectCheck(piece, collideSprite, 50) == false)
            {
                continue;
            }
            
            collisionPieceCount++;
        }
    }
    
    private function CheckLevelClear() : Bool
    {
        if (this.spritePieceArray.length == 0)
        {
            return false;
        }
        
        if (this.doingLevelClearProcess == true)
        {
            return false;
        }
        
        //for (piece in spritePieceArray)
        //{
            //if (piece.scale.x > 1 + SCALE_RANGE || piece.scale.x < 1 - SCALE_RANGE)
            //{
                //return false;
            //}
            //
            //if (piece.scale.y > 1 + SCALE_RANGE || piece.scale.y < 1 - SCALE_RANGE)
            //{
                //return false;
            //}
            //
            //var angle = piece.angle%360;
            //angle = (angle + 360)%360;
            //if (angle > ANGLE_RANGE || angle < ANGLE_RANGE)
            //{
                //return false;
            //}
        //}
        
        if (Math.abs(puzzleScaleXFactor + assignPuzzleScaleX) > SCALE_RANGE)
        {
            return false;
        }
        
        if (Math.abs(puzzleScaleYFactor + assignPuzzleScaleY) > SCALE_RANGE)
        {
            return false;
        }
        
        var angle = (puzzleAngleFactor + assignPuzzleAngle)%360;
        if (Math.abs(angle) > ANGLE_RANGE)
        {
            return false;
        }
        
        return true;
    }
    
    private function DoLevelClearProcess() : Void 
    {
        if (doingLevelClearProcess == true)
        {
            return;
        }
        
        trace("DoLevelClearProcess");

        this.doingLevelClearProcess = true;

        this.sliderScaleX.active = false;
        this.sliderScaleY.active = false;
        this.sliderAngle.active = false;
        
        this.remove(sliderScaleX);
        this.remove(sliderScaleY);
        this.remove(sliderAngle);
        
        this.remove(shadowSpr);
        
        //
        for (piece in spritePieceArray)
        {
            piece.CreateSolvePieceProcess();
        }

        LevelManager.Get().LevelClear();
        AudioManager.Get().PlayHeartBeat();
        //
        FlxG.camera.flash(0xAAEEEEEE, 2, function ():Void 
        {
            var bag:FlxSprite = new FlxSprite(8*8, 8*22);
            bag.loadGraphic(AssetPaths.Briefcase__png);
            bag.scale.set(1.5, 1.5);
            bag.alpha = 0.0;
            FlxTween.tween(bag, {alpha: 1.0}, 0.5);
            this.add(bag);
            
            Timer.delay(function ():Void 
            {
                var stampSprite:FlxSprite = new FlxSprite();
                stampSprite.makeGraphic(128, 128, 0x00000000);
                
                for (i in 0 ... this.spritePieceArray.length)
                {
                    stampSprite.stamp(spritePieceArray[i]);
                }
                
                this.remove(bag);
                this.add(stampSprite);
                this.add(bag);
                
                this.remove(spritePieceGroup);
                
                var options:TweenOptions = { type: FlxTween.LOOPING};
                
                FlxTween.tween(stampSprite.scale, {x: 0.3, y: 0.3}, 1.0);
                
                //FlxTween.angle(stampSprite, 0, 360, 1, options);
                
                FlxTween.tween(stampSprite, {y: 200, x: 30}, 1.0);
                
                Timer.delay(function ():Void 
                {
                    FlxTween.tween(bag.scale, {x: 2.5, y: 2.5}, 0.1, {onComplete:function(tween:FlxTween):Void 
                    {
                        FlxTween.tween(bag.scale, {x: 1.5, y: 1.5}, 0.1);
                    }}); 
                }, 800);
                
                Timer.delay( function ():Void 
                {
                    FlxG.switchState(new CutsceneModule());
                }, 3000);
                
            }, 2000);
            

        });
        
    }
    
    /**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        
        #if debug
        if (FlxG.keys.justPressed.R)
        {
            HScriptManager.Get().Initial( function ():Void 
            {
                trace("Initial again done");
            });
        }
        
        if (FlxG.keys.justPressed.SPACE)
        {
            this.DoLevelClearProcess();
        }
        #end
        
        if (interp == null)
        {
            return;
        }
        
        //if (interp != null)
        //{
            //interp.variables.get("UpdateFunction")(elapsed);
        //}
        
        this.UpdateCursor();
        
        this.AssignPuzzleValues();

        //this.CheckCollisionCount();
        
        if (this.CheckLevelClear() == true)
        {
            this.DoLevelClearProcess();
        }
	}
    
    
    
    
    
    
    
    
    
    
    
    
    
}