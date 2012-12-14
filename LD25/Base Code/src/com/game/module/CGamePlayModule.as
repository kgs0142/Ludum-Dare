package com.game.module
{
    import ai.CPlayer;
    import com.game.CBaseScene;
    import event.CAssetEvent;
    import system.CResourceManager;
    
    import flash.events.Event;
    
    import global.CAssetDefine;
    
    import org.flixel.FlxButton;
    import org.flixel.FlxG;
    import org.flixel.FlxState;
    
    import system.CAssetLoader;
    import system.CLuaManager;

    public class CGamePlayModule extends CBaseScene
    {
        private var m_player:CPlayer;
        
        public override function create():void
        {
            this.Initial();
            
            CLuaManager.Get().cLuaAlchemy.doString("create()");
            
            //reload lua file btn
            this.add(new FlxButton(0, 0, "Reload Lua", ReloadLua));
        }
        
        private function Initial() : void
        {
            m_player = new CPlayer();
            
            CLuaManager.Get().cLuaAlchemy.setGlobal("player", m_player);
            CLuaManager.Get().cLuaAlchemy.setGlobal("this", this);
            CLuaManager.Get().cLuaAlchemy.setGlobal("camera", FlxG.camera);
        }
        
        private function ReloadLua() : void
        {
            //add ASSET_LOAD_COMPLETE Event
            CAssetLoader.Get().addEventListener(CAssetEvent.ASSET_LOAD_COMPLETE, 
                                                this.LoadCompleteHD);
            
            CAssetLoader.Get().LoadLua(CAssetDefine.GAME_PLAY_LUA_NAME,
                                       CAssetDefine.GAME_PLAY_LUA_PATH);
            CAssetLoader.Get().LoadLua(CAssetDefine.PLAYER_AI_LUA_NAME,
                                       CAssetDefine.PLAYER_AI_LUA_PATH);
        }
        
        private function LoadCompleteHD(e:Event) : void
        {
            CAssetLoader.Get().removeEventListener(CAssetEvent.ASSET_LOAD_COMPLETE, 
                                                   this.LoadCompleteHD);
                                                   
            CLuaManager.Get().DoLuaString(CAssetDefine.GAME_PLAY_LUA_NAME);
            CLuaManager.Get().DoLuaString(CAssetDefine.PLAYER_AI_LUA_NAME);
                                                   
            FlxG.switchState(new CGamePlayModule());
        }
        
        public override function update():void
        {
            this.beforeUpdate();
                  
            super.update();
            
            this.afterUpdate();
        }
        
        private function beforeUpdate():void
        {
            CLuaManager.Get().cLuaAlchemy.doString("beforeUpdate()");
        }
            
        private function afterUpdate():void
        {
            CLuaManager.Get().cLuaAlchemy.doString("afterUpdate()");
        }
    }
}
