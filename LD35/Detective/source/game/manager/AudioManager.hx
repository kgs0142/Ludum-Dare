package game.manager;

import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.system.FlxSoundGroup;
import flixel.tweens.FlxTween;
import haxe.Timer;

/**
 * ...
 * @author Husky
 */
class AudioManager
{
    private static var Instance:AudioManager;
    
    private var bgmMusic:FlxSound;
    
    public function new() 
    {
        
    }
    
    public function Initial():Void
    {
        FlxG.sound.playMusic(SimpleReplaceId("assets/music/Miami_Prose.mp3") , 0.0, true);
        
        //bgmMusic = FlxG.sound.play(AssetPaths.Guerrilla_Illusions__mp3, 0.0, true, null, false);
        bgmMusic = new FlxSound();
        bgmMusic.loadEmbedded(SimpleReplaceId("assets/music/Guerrilla_Illusions.mp3"), true);
        bgmMusic.volume = 0.0;
		bgmMusic.persist = true;
		bgmMusic.group = new FlxSoundGroup();
		bgmMusic.play();
    }

    public function MusicFadeOutAndBGMFadeIn():Void 
    {
        FlxTween.tween(FlxG.sound.music, {volume: 0.0}, 1.0);
        FlxTween.tween(bgmMusic, {volume: 1.0}, 1.0);
    }
    
    public function MusicFadeInAndBGMFadeOut():Void 
    {
        FlxTween.tween(FlxG.sound.music, {volume: 1.0}, 1.0);
        FlxTween.tween(bgmMusic, {volume: 0.0}, 1.0);
    }
    
    public function PlayHeartBeat():Void 
    {
        FlxG.sound.play(SimpleReplaceId(AssetPaths.step01__wav), 1, false, null, true, function ():Void 
        {
            Timer.delay(function ():Void 
            {
                FlxG.sound.play(SimpleReplaceId(AssetPaths.step02__wav), 1, false, null, true, function ():Void 
                {
                
                });
            }, 500);
        });
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
        source = StringTools.replace(source, ".wav", ".ogg");
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