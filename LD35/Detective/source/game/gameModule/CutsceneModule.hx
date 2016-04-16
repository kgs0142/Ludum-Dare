package game.gameModule;

import core.misc.CustomInterp;
import core.system.HScriptManager;
import flixel.addons.display.FlxSpriteAniRot;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxTween;
import game.manager.LevelManager;
import haxe.Timer;

using core.util.CustomExtension;

/**
 * ...
 * @author Husky
 */
class CutsceneModule extends FlxState
{
    private var interp:CustomInterp;
    
    private var cutScenes:Array<FlxSprite>;

    private var currentCutscene:FlxSprite;

    private var currentIndex = 0;
    
    private var clickSkipAble = false;
    
    private var delayTween:FlxTween;
    
	override public function create():Void
	{
		super.create();
        
        var scriptName = LevelManager.Get().GetCutSceneScriptName();
        if (scriptName == "")
        {
            trace("game clear!");
            
            //switch to clear state.
            FlxG.switchState(new EndGameModule());
            return;
        }
        
        cutScenes = new Array<FlxSprite>();
        
        interp = new CustomInterp();
        interp.CommonInitial();
        
        interp.variables.set("this", this);

        //--------------------------------------------------------------------------------------
        
        interp.execute(HScriptManager.Get().GetParsedScript(scriptName));
        
        //--------------------------------------------------------------------------------------
        
        Timer.delay(function ():Void 
        {
            clickSkipAble = true;
        }, 1000);
        
        this.PopCutscene();
    }
    
    override public function destroy():Void
	{
		super.destroy();
	}

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
        #end
        
        if (clickSkipAble == false)
        {
            return;
        }
        
        if (FlxG.mouse.justPressed)
        {
            if (delayTween != null)
            {
                delayTween.cancel();
                delayTween.destroy();
                delayTween = null;
            }
            
            this.PopCutscene();
        }
    }
    
    private function PopCutscene() : Void 
    {
        if (currentCutscene != null)
        {
            clickSkipAble = false;
            
            this.DoFadeOut(currentCutscene, function ():Void 
            {
                this.remove(currentCutscene);
                
                currentCutscene = null;
                
                this.PopCutscene();
            });
            return;
        }
        
        if (currentIndex >= cutScenes.length)
        {
            //go to play module
            FlxG.switchState(new PlayModule());
            return;
        }
        
        currentCutscene = cutScenes[currentIndex];
        currentIndex++;
        
        currentCutscene.alpha = 0;
        currentCutscene.setPosition(8*2, 8*2);
        this.add(currentCutscene);
        
        this.DoFadeOut(currentCutscene, function ():Void 
        {
            clickSkipAble = true;

            delayTween = FlxTween.angle(new FlxSprite(), 0, 360, 2, {onComplete: function (tween:FlxTween):Void 
            {
                this.PopCutscene();
            }});
        });
    }
    
    private function DoFadeIn(spr:FlxSprite, callback:Void->Void):Void 
    {
        FlxTween.tween(spr, {alpha: 0}, 0.5, {onComplete : function (tween:FlxTween):Void 
        {
            callback();
        }});
    }
    
    private function DoFadeOut(spr:FlxSprite, callback:Void->Void):Void 
    {
        FlxTween.tween(spr, {alpha: 1}, 0.5, {onComplete : function (tween:FlxTween):Void 
        {
            callback();
        }});
    }
}