package game.test;

import core.system.AudioManager;
import flixel.addons.text.FlxTypeText;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import game.gameState.BaseGameState;
import utils.AssetPaths;
import utils.Fonts;

/**
 * A FlxState which can be used for the game's menu.
 */
class TestModule extends FlxState
{
    private var _sprGroup:FlxSpriteGroup;
    
    private var _sprRotated:FlxSprite;
    
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
        
        _sprGroup = new FlxSpriteGroup();
        _sprGroup.setPosition(100, 100);
        
        //Non-embed text
        this.add(new FlxText(10, 80, 250, "abc嗯嗯哈哈你好嗎科科xyz", 16));
        
        this.add(_sprGroup);
        
        //test rotated sprite
        _sprRotated = new FlxSprite(300, 300);
        //_sprRotated.offset.x = 50;
        _sprRotated.scale.x = 5;
        //_sprRotated.centerOrigin();
        this.add(_sprRotated);
        
        //debug msg
        trace(Fonts.Get().TestZhFont_PATH);
        FlxG.log.add(Fonts.Get().TestZhFont_PATH);
        
        //Play music
        AudioManager.Get().PlayMusic(AssetPaths.LD26_Music__mp3, 1, true);
        
        //Test set substate
        this.openSubState(new BaseGameState());
        this.persistentUpdate = true;
        //---------------------------------------------------------------------------------------
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
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        
        if (FlxG.keys.pressed.A)
        {
            this._sprGroup.x -= 1;
        }
        if (FlxG.keys.pressed.S)
        {
            this._sprGroup.y += 1;
        }
        if (FlxG.keys.pressed.W)
        {
            this._sprGroup.y -= 1;
        }
        if (FlxG.keys.pressed.D)
        {
            this._sprGroup.x += 1;
        }
        
        if (FlxG.keys.pressed.Z)
        {
            this._sprRotated.angle += 0.5;
        }
        if (FlxG.keys.pressed.X)
        {
            this._sprRotated.angle -= 0.5;
        }
	}
}