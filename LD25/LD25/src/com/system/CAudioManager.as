package com.system 
{
    import org.flixel.FlxG;
    import org.flixel.FlxSound;
	/**
     * ...
     * @author Husky
     */
    public class CAudioManager 
    {
        private static var ms_Instance:CAudioManager;
        private var m_objMapping:Object;
        
        public function PlaySnd(sName:String, nVolume:Number = 1.0) : void
        {
            if (m_objMapping.hasOwnProperty(sName) == false)
            {
                return;
            }
            
            FlxG.play(m_objMapping[sName], nVolume);
        }
        
        public function PlayMusic(sName:String, nVolume:Number = 1.0) : void
        {
            if (m_objMapping.hasOwnProperty(sName) == false)
            {
                return;
            }
            
            FlxG.playMusic(m_objMapping[sName], nVolume);
        }
        
        public function stopMusic() : void
        {
            if (FlxG.music)
                FlxG.music.stop();
        }
        
        public function Create() : void
        {
            CLuaManager.Get().cLuaAlchemy.setGlobal("audioMgr", this);
            
            m_objMapping = 
            {
                "TitleMusic": TitleMusic,
                "Music001" : Music001,
                "Music002" : Music002,
                "Music003" : Music003,
                "Dialog" : Dialog,
                "DoorOpen" : DoorOpen,
                "EarthQuake" : EarthQuake,
                "HitSound" : HitSound,
                "Laugh" : Laugh,
                "Laugh2" : Laugh,
                "PlayerHit" : PlayerHit,
                "PlayerHurt" : PlayerHurt,
                "SanityEffect" : SanityEffect,
                "SanityEffect2" : SanityEffect2,
                "SanityEffect3" : SanityEffect3,
                "SanityEffect4" : SanityEffect4,
                "TitleSelect" : TitleSelect,
                "W" : W
            };
        }
        
        public function CAudioManager(proxy:CSSingletonProxy)
        {
            if (proxy == null) 
            {
                throw new Error("Singleton create error.");
            }
        }
        
        public static function Get() : CAudioManager
        {
            if (!ms_Instance)
            {
                ms_Instance = new CAudioManager(new CSSingletonProxy());
            }
            
            return ms_Instance;
        }
    }
}

class CSSingletonProxy { }