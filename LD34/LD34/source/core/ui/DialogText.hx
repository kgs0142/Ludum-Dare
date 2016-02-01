package core.ui;

import flixel.FlxG;
import flixel.addons.text.FlxTypeText;
import flixel.system.FlxSound;
import utils.AssetPaths;

/**
 * ...
 * @author Husky
 */
class DialogText extends FlxTypeText
{
    private static inline var DELAY:Float = 0.1;
    private static inline var ERASE_DELAY:Float = 0.2;
    private static inline var AUTO_ERASE:Bool = true;
    private static inline var SHOW_CURSOR:Bool = true;
    private static inline var CURSOR_BLINK_SPEED:Float = 1.0;
    private static inline var WAIT_TIME:Float = 2.0;
    
    
    public function new(X:Float, Y:Float, Width:Int, Text:String, Size:Int=8, EmbeddedFont:Bool=true) 
    {
        super(X, Y, Width, Text, Size, EmbeddedFont);
		
        this.prefix = "";
        this.delay = DELAY;
		this.eraseDelay = ERASE_DELAY;
		this.showCursor = SHOW_CURSOR;
		this.cursorBlinkSpeed = CURSOR_BLINK_SPEED;
		this.autoErase = AUTO_ERASE;
		this.waitTime = WAIT_TIME;
		this.setTypingVariation(0.75, true);
		this.color = 0x8811EE11;
		this.skipKeys = ["SPACE"];
        
        //The default sound, if we're porting to html5, we need to use ogg sound file, so I'm going to do this myself.
        this.useDefaultSound = false;
        this.UseDefaultSound();
    }
    
    public function UseDefaultSound()
    {
        var defualtTypeSnd:FlxSound;
        #if flash
        defualtTypeSnd = FlxG.sound.load(AssetPaths.defaultTypetext__wav);
        #else
        defualtTypeSnd = FlxG.sound.load(AssetPaths.defaultTypetext__ogg);
        #end
        
        this.setSound(defualtTypeSnd);
    }
}