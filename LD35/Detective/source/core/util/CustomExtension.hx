package core.util;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import hscript.Interp;
import openfl.display.BlendMode;

/**
 * ...
 * @author User
 */
class CustomExtension
{
    public static function CommonInitial(interp:Interp) 
    {
        interp.variables.set("FlxG", FlxG);
        interp.variables.set("Math", Math);
        interp.variables.set("FlxMath", FlxMath);
        interp.variables.set("FlxTween", FlxTween);
        interp.variables.set("FlxSprite", FlxSprite);
        interp.variables.set("AssetPaths", AssetPaths);
    }
}