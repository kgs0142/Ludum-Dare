package core.system;

import flixel.FlxG;
import flixel.system.FlxSound;

/**
 * ...
 * @author Husky
 */
class AudioManager
{
    private static var Instance:AudioManager;
    
    public function new() 
    {
        
    }
    
    public function Initial():Void
    {
    }
    
    ///I can only do some trick on the string Id. and I only care about "*.ogg" and "*.mp3".
    public function PlayMusic(music:Dynamic, volume:Float = 1, looped:Bool = true):Void 
    {
        var isStrId:Bool = Std.is(music, String);
        var strId:String = "";
        
        if (isStrId == true)
        {
            strId = cast(music, String);
            strId = this.SimpleReplaceId(strId);
        }
        
        if (isStrId == true)
        {
            FlxG.sound.playMusic(strId, volume, looped);
        }
        else 
        {
            FlxG.sound.playMusic(music, volume, looped);
        }
    }
    
    public function StopMusic():Void 
    {
        if (FlxG.sound.music == null)
        {
            return;
        }
        
        FlxG.sound.music.stop();
    }
    
    public function PauseMusic():Void 
    {
        if (FlxG.sound.music == null)
        {
            return;
        }
        
        FlxG.sound.music.pause();
    }
    
    public function ResumeMusic():Void 
    {
        if (FlxG.sound.music == null)
        {
            return;
        }
        
        FlxG.sound.music.resume();
    }
    
    public function ReviveMusic():Void 
    {
        if (FlxG.sound.music == null)
        {
            return;
        }
        
        FlxG.sound.music.revive();
    }
    
    ///I can only do some trick on the string Id. and I only care about "*.ogg" and "*.mp3".
    public function PlaySound(embeddedSound:String, volume:Float = 1, looped:Bool = false, autoDestroy:Bool = true, 
                              ?onComplete:Void->Void):FlxSound
    {
        var strId:String = this.SimpleReplaceId(embeddedSound);
        
        return FlxG.sound.play(embeddedSound, volume, looped, autoDestroy, onComplete);
    }
    
    private function SimpleReplaceId(source:String) : String
    {
        #if flash
        source = StringTools.replace(source, ".ogg", ".mp3");
        #else
        source = StringTools.replace(source, ".mp3", ".ogg");
        #end
        
        return source;
    }
    
    public static function Get():AudioManager
    {
        if (Instance == null)
        {
            Instance = new AudioManager();
        }
        
        return Instance;
    }
}