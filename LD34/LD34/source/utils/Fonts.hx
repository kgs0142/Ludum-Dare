package utils;

import flixel.FlxG;
import flixel.system.scaleModes.StageSizeScaleMode;
import openfl.display.Loader;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.display.LoaderInfo;
import openfl.Assets;

import openfl.text.Font;


//This is one way usful, but I don't know why it's not working on Html5
@:font("assets/fonts/OutputFont.ttf") 
class SourceHanSansTC_Medium extends Font { }

//class TestZhFont extends flash.text.Font {}
//class TestZhFont extends Font {}

/**
 * ...
 * @author Husky
 */
class Fonts
{
    //public var MSJH_PATH:String;
    //public var TestZhFont_PATH:String;
    public var TestZhFont_PATH:String = "OutputFont_ttf";
    
    private static var Instance:Fonts;

    private var loader:Loader;
    
    private function new() 
    {
        //-------------------------------------------------------------------------------------------------
        //trace("Path: " + AssetPaths.testZhFont__swf);
        //trace(Assets.getBytes(AssetPaths.testZhFont__swf));
        //trace(Assets.getBytes(AssetPaths.testZhFont__swf).length);
        //
        //var byte:ByteArray = Assets.getBytes(AssetPaths.testZhFont__swf);
        //loader = new Loader();
        //loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadedComplete);
        //loader.loadBytes(byte);
        //-------------------------------------------------------------------------------------------------
        
        //trace("loader.contentLoaderInfo.bytesLoaded: " + loader.contentLoaderInfo.bytesLoaded);
        
        //Assets.loadLibrary(AssetPaths.testZhFont__swf, onSwfLoaded);
        //Assets.loadLibrary("testZhFont", onSwfLoaded);
    }
    
    //private function onLoadedComplete(e:Event):Void 
    //{
        //trace("load complete");
        //
        //trace("e.currentTarget == loader: " + (e.currentTarget == loader));
        //
        //trace("loader.contentLoaderInfo.bytesLoaded: " + loader.contentLoaderInfo.bytesLoaded);
        //
        ////trace(loader.contentLoaderInfo.applicationDomain.hasDefinition("XXX"));
        //trace(loader.contentLoaderInfo.applicationDomain.hasDefinition("TestMC"));
        //trace(loader.contentLoaderInfo.applicationDomain.hasDefinition("TestZhFont"));
        //
        //trace(loader.contentLoaderInfo.applicationDomain.getDefinition("TestMC"));
        //trace(loader.contentLoaderInfo.applicationDomain.getDefinition("TestZhFont"));
        //
        //var clz:Class<Dynamic> = cast (loader.contentLoaderInfo.applicationDomain.getDefinition("TestMC"), Class<Dynamic>);
        //var mc:MovieClip = cast (Type.createEmptyInstance(clz), MovieClip);
        ////trace(mc);
        ////trace(mc.name);
        //
        //clz = cast (loader.contentLoaderInfo.applicationDomain.getDefinition("TestZhFont"), Class<Dynamic>);
        //var font:Font = cast (Type.createEmptyInstance(clz), Font);
        //trace(font);
        //trace(font.fontName);
//
        //TestZhFont_PATH = font.fontName;
//
        ////Font.registerFont(clzFont);
        //Font.registerFont(cast clz);
        //
        //var c:Array<Font> = Font.enumerateFonts();
        ////var i:Iterator<Font> = c.iterator;
        //for (f in c)
        //{
            //trace(f.fontName);
        //}
        //
        ////
        //trace("Has font: " + Assets.cache.hasFont(font.fontName));
        //trace("Set font. ");
        //Assets.cache.setFont(font.fontName, font);
        //trace("Has font: " + Assets.cache.hasFont(font.fontName));
    //}
    
    //private function onSwfLoaded(lib:lime.Assets.AssetLibrary):Void
	//{
        //trace(Assets.getMovieClip("testZhFont:TestMC"));
        ////trace(lib.getFont("testZhFont:TestZhFont"));
        //
        //trace(Assets.getFont("testZhFont:TestZhFont").fontName);
        //
        ////trace(lib.getFont("TestZhFont"));
        //
        //trace(Assets.getFont("TestZhFont").fontName);
	//}
    
    public function Initial():Void
    {
        //SourceHanSansTC_Medium font
        var font:Font = new SourceHanSansTC_Medium();
        Font.registerFont(SourceHanSansTC_Medium);
        Assets.cache.setFont(font.fontName, font);
        if (font.fontName != null) 
        {
            TestZhFont_PATH = font.fontName;
        }
        
        //
        
        //FlxG.log.add("TestZhFont_PATH: " + TestZhFont_PATH);
        //FlxG.log.add("font: " + font);
        //FlxG.log.add(font.fontName);
        //FlxG.log.add(font.fontStyle);
        //FlxG.log.add(font.fontType);
        
        //trace(font.fontName);
        //trace(font.fontStyle);
        //trace(font.fontType);
    }
    
    public static function Get() : Fonts
    {
        if (Instance == null)
        {
            Instance = new Fonts();
        }
        
        return Instance;
    }
    
}