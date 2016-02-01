package game.gameState;

import flixel.addons.plugin.control.FlxControl;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTileblock;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import game.gameModule.MenuModule;
import game.gameObjects.ai.Boss;
import game.gameObjects.ai.Protagonist;
import game.gameObjects.BaseGameObject;
import game.gameObjects.scene.TiledLevel;
import utils.AssetPaths;
import utils.Fonts;

/**
 * ...
 * @author Husky
 */
class GamePlayState extends BaseGameState
{
	public var level:TiledLevel;
    
    public var player:Protagonist;
    
    public var boss:Boss;
    
    private var _flxText:FlxText; 
    
    private var _zSprite:FlxSprite;
    private var _xSprite:FlxSprite;
    
    private var _gameClear:Bool = false;
    
    /**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
        
        //player = new Protagonist(2*32, 96*32);
        
        //Play music
        //AudioManager.Get().PlayMusic(AssetPaths.LD26_Music__mp3, 1, true);
        
        // Load the level's tilemaps
		level = new TiledLevel("assets/data/test.tmx");
		
        // Add background tiles after adding level objects, so these tiles render on top of player
		this.add(level.backgroundTiles);
        
		// Add tilemaps
		this.add(level.foregroundTiles);
        
        this.add(level.collidableObjects);
        
        //These are most interactive go.
        this.add(level.overlapableObjects);
        
        // Load player objects
		level.loadObjects(this);
		
        //this.add(player);

        //FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
        FlxG.camera.fade(FlxColor.BLACK, 0.5, true);
	}
    
    public function GameClearHandler():Void 
    {
        _gameClear = true;
        
        //Embed text
        _flxText = new FlxText(FlxG.width/3 - 15, FlxG.height/3, 450, "", 48, true);
        _flxText.scrollFactor.set(0, 0);
        _flxText.color = FlxColor.FOREST_GREEN;
        _flxText.font = Fonts.Get().TestZhFont_PATH;
        _flxText.text = "Game Clear!";
        this.add(_flxText);
        
        _zSprite = new FlxSprite(FlxG.width/2 - 50, FlxG.height/2 + 50);
        _zSprite.scrollFactor.set(0, 0);
        _zSprite.loadGraphic(AssetPaths.test__png, false, 32, 32);
        _zSprite.scale.set(2, 2);
        _zSprite.animation.add("default", [32], 1, false);
        _zSprite.animation.add("pressed", [24], 1, false);
        _zSprite.animation.play("default");
        this.add(_zSprite);
        
        _xSprite = new FlxSprite(FlxG.width/2 + 10, FlxG.height/2 + 50);
        _xSprite.scrollFactor.set(0, 0);
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
        
        //FlxG.collide(player, testBlockGroup);
        
		level.collideWithLevel(player);
        
		level.OverlapWithObjects(player, OverlapHandler);
        
		level.CollideWithObjects(player, OverlapHandler);
        
        //After gameclear
        if (_gameClear == false)
        {
            return;
        }
        
        _zSprite.animation.play("default");
        _xSprite.animation.play("default");
        
        if (FlxG.keys.anyPressed(["Z"]) && FlxG.keys.anyJustPressed(["X"]))
        {
            _zSprite.animation.play("pressed", true);
            _xSprite.animation.play("pressed", true);
            
            _gameClear = false;
            
            FlxG.camera.fade(FlxColor.BLACK, 1.5, false, function ():Void 
            {
                FlxG.switchState(new MenuModule());
            });
        }
        else if (FlxG.keys.anyJustPressed(["Z"]) && FlxG.keys.anyPressed(["X"]))
        {
            _zSprite.animation.play("pressed", true);
            _xSprite.animation.play("pressed", true);
            
            _gameClear = false;
            
            FlxG.camera.fade(FlxColor.BLACK, 1.5, false, function ():Void 
            {
                FlxG.switchState(new MenuModule());
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
    
    private function OverlapHandler(obj:FlxObject, Player:FlxObject):Void 
    {
        //trace("overlap!");
        var go:BaseGameObject = cast(obj, BaseGameObject);
        go.OverlapPlayerHandler(player);
    }
}