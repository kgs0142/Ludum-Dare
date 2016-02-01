package game.test;

import core.system.AudioManager;
import core.ui.DialogText;
import flixel.addons.text.FlxTypeText;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxPoint;
import game.gameState.BaseGameState;
import game.test.TestCard;
import utils.AssetPaths;
import utils.Fonts;

/**
 * A FlxState which can be used for the game's menu.
 */
class TestModule extends FlxState
{
    private var _flxText:DialogText; 
    private var _statusText:DialogText; 
    
    private var _sprGroup:FlxSpriteGroup;
    
    private var _2ndCamera:FlxCamera;
    
    private var _sprRotated:FlxSprite;
    
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
        
        //Embed text
        _flxText = new DialogText(10, 10, 450, "", 16, true);
        _flxText.font = Fonts.Get().TestZhFont_PATH;
        //flxText.text = "abc嗯嗯哈哈你好嗎科科xyz";
        _flxText.resetText("abcABC基本的嗯嗯哈哈你好嗎科科, 拉丁語系和符號等等的字xyz");
        this.add(_flxText);

        //Status text
        _statusText = new DialogText(10, 50, 200, "None", 16, true);
        _statusText.color = 0x8800AA00;
        _statusText.showCursor = false;
		_statusText.prefix = "Status: ";
        this.add(_statusText);
        
        _sprGroup = new FlxSpriteGroup();
        _sprGroup.setPosition(100, 100);
        
        var spr:FlxSprite = new TestCard(50, 0, false);
        spr.scale.y = 2;
        _sprGroup.add(spr);
        
        spr = new TestCard(0, 50, false);
        spr.scale.x = 2;
        _sprGroup.add(spr);
        
        spr = new TestCard(50, 50, false);
        spr.scale.set(2, 2);
        _sprGroup.add(spr);
        
        //Non-embed text
        this.add(new FlxText(10, 80, 250, "abc嗯嗯哈哈你好嗎科科xyz", 16));
        
        //test cards with mouse events
        this.add(new TestCard(50, 100));
        this.add(new TestCard(100, 100));
        this.add(new TestCard(150, 100));
        this.add(new TestCard(200, 100));
        
        this.add(new TestCard(50, 250));
        this.add(new TestCard(200, 250));
        this.add(new TestCard(350, 250));
        this.add(new TestCard(500, 250));
        
        //Buttons
        this.add(new FlxButton(20, FlxG.height - 60, "Start", StartCallback));
		this.add(new FlxButton(120, FlxG.height - 60, "Pause", PauseCallback));
		this.add(new FlxButton(220, FlxG.height - 60, "Erase", EraseCallback));
		this.add(new FlxButton(20, FlxG.height - 30, "Force Start", ForceStartCallback));
		this.add(new FlxButton(120, FlxG.height - 30, "Cursor", CursorCallback));
		this.add(new FlxButton(220, FlxG.height - 30, "Force Erase", ForceEraseCallback));
        
        this.add(_sprGroup);
        
        //test 2nd camera
        _2ndCamera = new FlxCamera(300, 50, 200, 30);
		_2ndCamera.setBounds(0, 0, FlxG.width, FlxG.height);
		_2ndCamera.bgColor = 0xFFFFCCCC;
        _2ndCamera.follow(_statusText);
        
		FlxG.cameras.add(_2ndCamera);
        
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
	override public function update():Void
	{
		super.update();
        
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
    
    private function StartCallback():Void
	{
		_flxText.start(0.02, false, false, null, null, OnTypeTextComplete, ["Fully typed"]);
	}
	
	private function PauseCallback():Void
	{
		_flxText.paused = !_flxText.paused;
	}
	
	private function EraseCallback():Void
	{
		_flxText.erase(0.01, false, null, null, OnTypeTextComplete, ["Fully erased"]);
	}
	
	private function ForceStartCallback():Void
	{
		_flxText.start(0.03, true, true, null, null, OnTypeTextComplete, ["Typed, erasing..."]);
	}
	
	private function CursorCallback():Void
	{
		if (_flxText.cursorCharacter == "|")
		{
			_flxText.cursorCharacter = "#";
		}
        else if (_flxText.cursorCharacter == "#")
        {
            _flxText.cursorCharacter = "";
        }
        else
		{
            _flxText.cursorCharacter = "|";
		}
	}
	
	private function ForceEraseCallback():Void
	{
		_flxText.erase(0.02, true, null, null, OnTypeTextComplete, ["Erased"]);
	}
    
    private function OnTypeTextComplete(Text:String):Void
	{
		_statusText.resetText(Text);
		_statusText.start(null, true);
	}
}