package game.module 
{
    import com.greensock.TweenLite;
    import flash.display.BlendMode;
    import game.ai.BlackGuy;
    import game.ai.LittleBoy;
    import game.controller.Controllers;
    import game.scene.CBaseScene;
    import game.scene.CSceneManager;
    import game.scene.MySaves;
    import husky.flixel.MyModule;
    import husky.flixel.util.SprBevelScreen;
    import nc.component.system.NcLoader;
    import nc.component.system.script.NcLuaManager;
    import nc.entity.NcEntityManager;
    import nc.system.NcSystems;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
	import org.flixel.FlxState;
    import org.flixel.FlxText;
    import org.flixel.plugin.photonstorm.FlxControl;
    import org.flixel.plugin.photonstorm.FlxDelay;
	
	/**
     * ...
     * @author Husky
     */
    public class CreateModule extends MyModule
    {
        [Embed(source="../../../assets.zip", mimeType="application/octet-stream")]
        private static const EMBED_ZIP_ASSET:Class;
        
        public override function create():void 
        {
            FlxG.bgColor = 0XFF222222;
            
            FlxG.addPlugin(new FlxControl());
            
            this.ImportClass();
            
            //Load save file
            MySaves.Load();
            
            NcEntityManager.Get().Create();
            
            NcSystems.Get().AddComponents
            (
                new NcLoader(),
                new NcLuaManager()
            );

            var loader:NcLoader = NcSystems.Get().GetComponent(NcLoader);
            
            CONFIG::debug
            {
                loader.PushAssetToLoad("assets/lua/UI.lua");
                loader.PushAssetToLoad("assets/lua/Event.lua");
                loader.PushAssetToLoad("assets/lua/Stage.lua");
                
                loader.PushAssetToLoad("assets/scene/Level_Menu_Stage.xml");
                loader.PushAssetToLoad("assets/scene/mapCSV_Menu_Stage_BG.csv");
                loader.PushAssetToLoad("assets/scene/mapCSV_Menu_Stage_Cloud(2).csv");
                loader.PushAssetToLoad("assets/scene/mapCSV_Menu_Stage_Cloud.csv");
                loader.PushAssetToLoad("assets/scene/mapCSV_Menu_Stage_Main.csv");
                
                loader.PushAssetToLoad("assets/scene/Level_First_Stage.xml");
                loader.PushAssetToLoad("assets/scene/mapCSV_First_Stage_BG.csv");
                loader.PushAssetToLoad("assets/scene/mapCSV_First_Stage_Main.csv");
                loader.PushAssetToLoad("assets/scene/mapCSV_First_Stage_Cloud.csv");
                loader.PushAssetToLoad("assets/scene/mapCSV_First_Stage_Stuff.csv");
                
                loader.PushAssetToLoad("assets/scene/Level_Second_Stage.xml");
                loader.PushAssetToLoad("assets/scene/mapCSV_Second_Stage_BG.csv");
                loader.PushAssetToLoad("assets/scene/mapCSV_Second_Stage_Cloud(2).csv");
                loader.PushAssetToLoad("assets/scene/mapCSV_Second_Stage_Cloud.csv");
                loader.PushAssetToLoad("assets/scene/mapCSV_Second_Stage_Main.csv");
                loader.PushAssetToLoad("assets/scene/mapCSV_Second_Stage_Stuff.csv");
                
                loader.PushAssetToLoad("assets/scene/Level_Third_Stage.xml");
                loader.PushAssetToLoad("assets/scene/mapCSV_Third_Stage_BG.csv");
                loader.PushAssetToLoad("assets/scene/mapCSV_Third_Stage_Main.csv");
                
                loader.PushAssetToLoad("assets/StuffSet.png");
                
                loader.PushAssetToLoad("assets/tileset/Tileset001.png");
                loader.PushAssetToLoad("assets/tileset/Tileset_Cloud.png");
            }
            
            CONFIG::release
            {
                loader.SetEmbedZipClassToLoad(EMBED_ZIP_ASSET);
            }
                
            loader.StartLoad(this.LoadAllAssetComplete);
        }
        
        //Go to next state
        private function LoadAllAssetComplete() : void
        {
            //Lua Script
            var loader:NcLoader = NcSystems.Get().GetComponent(NcLoader);
            var luaMgr:NcLuaManager = NcSystems.Get().GetComponent(NcLuaManager);
            luaMgr.Initial();
            
            var sScript:String = loader.GetAsset("Stage") as String;
            luaMgr.DoString(sScript);
            
            sScript = loader.GetAsset("Event") as String;
            luaMgr.DoString(sScript);
            
            sScript = loader.GetAsset("UI") as String;
            luaMgr.DoString(sScript);
            
            //還少了menu
            //FlxG.switchState(new GamePlayModule());
            FlxG.switchState(new MenuModule());
        }
        
        private function ImportClass() : void
        {
            TweenLite;
            BlackGuy;
            Controllers;
            LittleBoy;
            GamePlayModule;
            FlxControl;
            EndModule;
        }
    }
}