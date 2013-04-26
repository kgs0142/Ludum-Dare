package com.game.module 
{
	import org.flixel.FlxState;
	
	/**
     * ...
     * @author Husky
     */
    public class CCreateState extends FlxState 
    {
        
        public function CCreateState() 
        {
            
        }
        
        public override function create():void 
        {
            FlxG.bgColor = 0XFF222222;
            
            BPEntityManager.Get().Create();
            
            CEntitySystem.Get().AddComponents
            (
                new BPLoader(),
                new BPLuaManager()
            );
            
            var loader:BPLoader = CEntitySystem.Get().GetComponent(BPLoader) as BPLoader;
            loader.PushAssetToLoad("assets/lua/Monster.lua");
            
            loader.PushAssetToLoad("assets/scene/Level_First.xml");
            loader.PushAssetToLoad("assets/scene/mapCSV_First_Backgrpund.csv");
            loader.PushAssetToLoad("assets/scene/mapCSV_First_Main.csv");
            loader.PushAssetToLoad("assets/TileTest002.png");
            loader.PushAssetToLoad("assets/TileSet003.png");
            
            loader.StartLoad(this.LoadAllAssetComplete);
        }
        
        private function LoadAllAssetComplete() : void
        {
            CSceneManager.Get().Initial();
            CSceneManager.Get().CreateScene("Level_First", this.CreateSceneComplete);
        }
        
        private function CreateSceneComplete(cScene:CBaseScene) : void
        {
            trace("Create scene complete");
            
            this.add(cScene);
            
            this.add(m_sprPlayer);
        }
        
        override public function update():void 
        {
            super.update();
            
            BPEntityManager.Get().Update();
        }
    }

}