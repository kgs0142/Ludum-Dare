package com.game 
{
	import org.flixel.FlxGroup;
	
	/**
     * ...
     * @author Husky
     */
    public class CEffectManager extends FlxGroup 
    {
        private static var ms_Instance:CEffectManager;
        
        public static function Get() : CEffectManager
        {
            if (ms_Instance == null)
            {
                ms_Instance = new CEffectManager(new CSingletonProxy());
            }
            return ms_Instance;
        }
        
        public function CEffectManager(proxy:CSingletonProxy) 
        { 
            if (proxy == null)
            {
                throw "Dont new singleton";
            }
        }
    }
}

class CSingletonProxy{}