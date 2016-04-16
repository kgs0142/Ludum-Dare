package core.util;

import openfl.Assets;

#if flash
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

#elseif (cpp || neko)
import sys.io.File;

#end

/**
 * Load script files (hscript, xml...) as dynamically as possible.
 * @author User
 */
class ScriptLoader
{
    private static var ms_Instance:ScriptLoader;
    
    private var m_scriptMap:Map<String, String>;
    
    public function new() 
    {
        this.m_scriptMap = new Map<String, String>();
    }

    public function Destory():Void 
    {
        this.m_scriptMap = null;
    }

    public function LoadScript(pathId:String, callback:String->Void, force:Bool = false) : Void
    {
        if (force == false && this.m_scriptMap.exists(pathId))
        {
            callback(this.m_scriptMap.get(pathId));
            return;
        }
        
        //{ Do loading scripts }
        
        //local callback
        var LoadScriptComplete:String->Void = function (script:String) : Void
        {
            //trace("script: " + script);
            
            this.m_scriptMap.set(pathId, script);
            
            callback(script);
        }
        
        #if flash
            #if WIP
            //We need this reference, this is a trick way I learned from AS3.
            var OnScriptLoadComplete:Event->Void = function (e:Event) : Void {};
            OnScriptLoadComplete = function (e:Event) : Void
            {
                var urlLoader:URLLoader = e.target;
                //trace("Has Event.Complete ? :" + urlLoader.hasEventListener(Event.COMPLETE));
                urlLoader.removeEventListener(Event.COMPLETE, OnScriptLoadComplete);
                //trace("Has Event.Complete ? :" + urlLoader.hasEventListener(Event.COMPLETE));
                
                var script:String = cast(urlLoader.data, String);
                
                //trace("script: " + script);
            
                this.m_scriptMap.set(pathId, script);
                
                callback(script);
            }
        
            var prefix:String = "../../../";
            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, OnScriptLoadComplete);
            urlLoader.load(new URLRequest(prefix + pathId));
            
            #else
            //Load embeded asset (flash)
            Assets.loadText(pathId, LoadScriptComplete);
            
            #end
        
		#elseif (cpp || neko)
            var prefix:String = "";
            
            #if WIP
            prefix = "../../../../";
            #end
        
            var script:String = File.getContent(prefix + pathId);
            LoadScriptComplete(script);
        
        #else
            //Load embeded asset (flash)
            Assets.loadText(pathId, LoadScriptComplete);
            
		#end
        
        //} endregion
        
    }
    
    
    public static function Get() : ScriptLoader
    {
        if (ms_Instance == null)
        {
            ms_Instance = new ScriptLoader();
        }
        
        return ms_Instance;
    }
}