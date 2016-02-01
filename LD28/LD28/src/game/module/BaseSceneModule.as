package game.module 
{
    import game.ai.Player;
    import game.ai.Trigger;
    import game.scene.CBaseScene;
    import game.scene.CSceneManager;
    import game.scene.MySaves;
    import game.ui.HUD;
    import husky.flixel.MyGroup;
	import husky.flixel.MyModule;
    import nc.component.system.NcLoader;
    import nc.component.system.script.NcLuaManager;
    import nc.entity.NcEntityManager;
    import nc.system.NcSystems;
    import org.flixel.FlxG;
    import org.flixel.FlxTileblock;
	
	/**
     * ...
     * @author Husky
     */
    public class BaseSceneModule extends MyModule 
    {
        protected var m_HUD:HUD;
        
        protected var m_Scene:CBaseScene;
        
        protected var m_gWall:MyGroup;
        
        protected var m_LuaMgr:NcLuaManager;
        
        protected var m_Player:Player;
        
        protected var m_gEnemies:MyGroup;
        
        override public function create():void 
        {
            super.create();
            
            FlxG.pauseSounds();
            
            m_LuaMgr = NcSystems.Get().GetComponent(NcLuaManager);
            
            CSceneManager.Get().Initial();
            CSceneManager.Get().CreateScene(MySaves.levels, this.CreateSceneComplete);
        }
        
        protected function CreateSceneComplete(cScene:CBaseScene) : void
        {
            trace("Create scene complete");
            
            m_Scene = cScene;
            
            m_gWall = new MyGroup();
            m_gWall.add(new FlxTileblock(CSceneManager.Get().pBoundsMin.x, 
                                         CSceneManager.Get().pBoundsMin.y, 
                                         CSceneManager.Get().pBoundsMax.x, 5));
            m_gWall.add(new FlxTileblock(CSceneManager.Get().pBoundsMin.x, 
                                         CSceneManager.Get().pBoundsMin.y, 
                                         5, 
                                         CSceneManager.Get().pBoundsMax.y));
            m_gWall.add(new FlxTileblock(CSceneManager.Get().pBoundsMin.x, 
                                         CSceneManager.Get().pBoundsMax.y - 5, 
                                         CSceneManager.Get().pBoundsMax.x, 
                                         5));
            m_gWall.add(new FlxTileblock(CSceneManager.Get().pBoundsMax.x - 5, 
                                         CSceneManager.Get().pBoundsMin.y,
                                         5, 
                                         CSceneManager.Get().pBoundsMax.y));
            
            this.add(m_gWall);
                                         
            this.add(m_Scene);
            
            this.AfterCreateScene();
        }
        
        override public function update():void 
        {
            super.update();
            
            FlxG.collide(m_gEnemies, m_Scene);
            
            FlxG.collide(m_gEnemies, m_gWall);
            
            if (FlxG.keys.justPressed("R"))
            {
                CONFIG::debug
                {
                    var loader:NcLoader = NcSystems.Get().GetComponent(NcLoader);

                    var fnComplete:Function = function () : void
                    {
                        //Lua Script reset
                        var luaMgr:NcLuaManager = NcSystems.Get().GetComponent(NcLuaManager);
                        var sScript:String = loader.GetAsset("Stage") as String;
                        luaMgr.DoString(sScript);
                        
                        sScript = loader.GetAsset("Event") as String;
                        luaMgr.DoString(sScript);
                        
                        sScript = loader.GetAsset("UI") as String;
                        luaMgr.DoString(sScript);
                        
                        FlxG.resetState();
                    };
                    
                    loader.PushAssetToLoad("assets/lua/UI.lua");
                    loader.PushAssetToLoad("assets/lua/Event.lua");
                    loader.PushAssetToLoad("assets/lua/Stage.lua");
                    
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
                    
                    loader.StartLoad(fnComplete);
                }
                
                CONFIG::release
                {
                    FlxG.resetState();
                }
            }
            
            CONFIG::debug
            {
                if (FlxG.keys.justPressed("N"))
                {
                    MySaves.levels = "Level_First_Stage";
                    MySaves.checkPoint = "default_spawn_point";
                    FlxG.resetState();
                }
            }
            
            //Trigger
            FlxG.overlap(m_Player, CSceneManager.Get().gOverlapLayer, PlayerOverlapTriggers);
        }
        
        private function PlayerOverlapTriggers(player:Player, trigger:Trigger):void 
        {
            trigger.OnOverlap(player);
        }
        
        override public function destroy():void 
        {
            super.destroy();
            
            m_LuaMgr = null;
            
            m_Scene = null;
        }
        
        protected function AfterCreateScene() : void
        {
            
        }
        
        public function get player():Player 
        {
            return m_Player;
        }
        
        public function get gEnemies():MyGroup 
        {
            return m_gEnemies;
        }
        
        public function get scene():CBaseScene 
        {
            return m_Scene;
        }
        
        public function get Hud():HUD 
        {
            return m_HUD;
        }
        
        public function get gWall():MyGroup 
        {
            return m_gWall;
        }
    }
}