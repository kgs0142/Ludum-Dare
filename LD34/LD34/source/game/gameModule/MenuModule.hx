package game.gameModule;

import core.system.AudioManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import utils.AssetPaths;
import utils.Fonts;

/**
 * ...
 * @author Husky
 */
class MenuModule extends FlxState
{
    private var _flxText:FlxText; 
    
    private var _zSprite:FlxSprite;
    private var _xSprite:FlxSprite;
    
    private var _update:Bool = true;
    
    /**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
        
        FlxG.state.bgColor = FlxColor.SALMON;
        
        AudioManager.Get().PlayMusic(AssetPaths.Title__wav);
        
        //Embed text
        _flxText = new FlxText(FlxG.width/4, FlxG.height/3, 450, "", 48, true);
        _flxText.font = Fonts.Get().TestZhFont_PATH;
        _flxText.text = "Zyx's Adventure";
        this.add(_flxText);
        
        _zSprite = new FlxSprite(FlxG.width/2 - 50, FlxG.height/2 + 50);
        _zSprite.loadGraphic(AssetPaths.test__png, false, 32, 32);
        _zSprite.scale.set(2, 2);
        _zSprite.animation.add("default", [32], 1, false);
        _zSprite.animation.add("pressed", [24], 1, false);
        _zSprite.animation.play("default");
        this.add(_zSprite);
        
        _xSprite = new FlxSprite(FlxG.width/2 + 10, FlxG.height/2 + 50);
        _xSprite.scale.set(2, 2);
        _xSprite.loadGraphic(AssetPaths.test__png, false, 32, 32);
        _xSprite.animation.add("default", [33], 1, false);
        _xSprite.animation.add("pressed", [25], 1, false);
        _xSprite.animation.play("default");
        this.add(_xSprite);
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
        
        if (_update == false)
        {
            return;
        }
        
        _zSprite.animation.play("default");
        _xSprite.animation.play("default");
        
        if (FlxG.keys.anyPressed(["Z"]) && FlxG.keys.anyJustPressed(["X"]))
        {
            _zSprite.animation.play("pressed", true);
            _xSprite.animation.play("pressed", true);
            
            _update = false;
            
            new FlxTimer(1.5, function (timer:FlxTimer):Void 
            {
                FlxG.switchState(new PlayModule());
            });
        }
        else if (FlxG.keys.anyJustPressed(["Z"]) && FlxG.keys.anyPressed(["X"]))
        {
            _zSprite.animation.play("pressed", true);
            _xSprite.animation.play("pressed", true);
            
            _update = false;
            
            new FlxTimer(1.5, function (timer:FlxTimer):Void 
            {
                FlxG.switchState(new PlayModule());
            });
        }
        else if (FlxG.keys.pressed.Z)
        {
            _zSprite.animation.play("pressed", true);
        }
        else if (FlxG.keys.pressed.X)
        {
            _xSprite.animation.play("pressed", true);
        }
	}
}