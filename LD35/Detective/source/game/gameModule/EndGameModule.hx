package game.gameModule;

import flixel.addons.text.FlxTypeText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

/**
 * ...
 * @author Husky
 */
class EndGameModule extends FlxState
{
    //private var endGameSpr:FlxSprite;
    
	override public function create():Void
	{
		super.create();
        
        trace("End game module");
        
        //endGameSpr = new FlxSprite();
        //endGameSpr.setPosition(8*2, 8*2);
        //endGameSpr.loadGraphic(AssetPaths.PlayBG__png);
        
        //this.add(endGameSpr);
        
        var typeText:FlxTypeText = new FlxTypeText(8*3, 8*10, 200, "Thanks for playing! :)", 8);
        //typeText.useDefaultSound = true;
        typeText.start(0.05, false, false, null, function ():Void 
        {
            var twitter:FlxTypeText = new FlxTypeText(8*10, 8*20, 100, "@kgs0142", 8);
            twitter.start(0.05);
            this.add(twitter);
        });
        this.add(typeText);
        
        FlxG.mouse.visible = true;
    }
    
    override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);    
        
        if (FlxG.mouse.justPressed)
        {
            FlxG.switchState(new MenuModule());
        }
    }
}