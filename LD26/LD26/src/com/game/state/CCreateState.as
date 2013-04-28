package com.game.state 
{
    import com.brompton.component.system.BPLoader;
    import com.brompton.component.system.script.BPLuaManager;
    import com.brompton.entity.BPEntityManager;
    import com.brompton.system.CEntitySystem;
    import com.game.CUIManager;
    import com.greensock.TweenLite;
    import org.flixel.FlxG;
    import org.flixel.FlxState;
	
	/**
     * ...
     * @author Husky
     */
    public class CCreateState extends FlxState 
    {
        [Embed(source="../../../../assets_lua.zip", mimeType="application/octet-stream")]
        private static const EMBED_ZIP_ASSET:Class;
        
        public function CCreateState() 
        {
            
        }
        
        public override function create():void 
        {
            FlxG.mouse.show();
            
            ImportClass();
            
            CUIManager.Get().Initial();
            
            BPEntityManager.Get().Create();
            
            CEntitySystem.Get().AddComponents
            (
                new BPLoader(),
                new BPLuaManager()
            );
            
            var loader:BPLoader = CEntitySystem.Get().GetComponent(BPLoader) as BPLoader;
            
            CONFIG::debug
            {
                loader.PushAssetToLoad("assets/lua/Stage.lua");
                loader.PushAssetToLoad("assets/lua/Text.lua");
            }
            
            CONFIG::release
            {
                loader.SetEmbedZipClassToLoad(EMBED_ZIP_ASSET);
            }
                
            loader.StartLoad(this.LoadAllAssetComplete);
        }
        
        private function LoadAllAssetComplete() : void
        {
            //CSceneManager.Get().Initial();
            //CSceneManager.Get().CreateScene("Level_First", this.CreateSceneComplete);
            
            //Initial LuaManager
            var loader:BPLoader = CEntitySystem.Get().GetComponent(BPLoader) as BPLoader;
            var luaMgr:BPLuaManager = CEntitySystem.Get().GetComponent(BPLuaManager) as BPLuaManager;
            luaMgr.Initial();
            
            var sScript:String = loader.GetAsset("Stage") as String;
            luaMgr.DoString(sScript);
            
            sScript = loader.GetAsset("Text") as String;
            luaMgr.DoString(sScript);
            
            //Create Complete, goto CMenuState
            FlxG.switchState(new CMenuState());
        }
        
        private function ImportClass() : void
        {
            TweenLite;
        }
        
        override public function update():void 
        {
            super.update();
            
            BPEntityManager.Get().Update();
        }
    }
}