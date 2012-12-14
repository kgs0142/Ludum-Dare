package com.game.module
{
    import org.flixel.FlxG;
    import org.flixel.FlxState;
    import org.flixel.plugin.photonstorm.FlxControl;
    
    import system.CAssetLoader;
    import system.CLuaManager;
    import system.CResourceManager;
    import system.CTimer;
    
    public class CCreateModule extends FlxState
    {
        public override function create() : void
        {
            Initial();
        }
        
        //初始化必須的資源
        private function Initial() : void
        {
            if (FlxG.getPlugin(FlxControl) == null)
            {
                FlxG.addPlugin(new FlxControl());
            }
            
            //AssetLoader有使用到CTimer，所以要先建構，之後看有沒有比較好的方法吧
            CTimer.Get().start();
            
            //先Load必須的Asset
            CAssetLoader.Get().loadAsset(this.CreateSystem);
        }
        
        //注意建構順序，目前沒有需要Create Queue的情況，之後有需要再加
        private function CreateSystem() : void
        {
            CResourceManager.Get().Create();
            
            CLuaManager.Get().Create();
            
            //Game Start
            this.GameStart();
        }
        
        private function GameStart() : void
        {
            FlxG.switchState(new CGamePlayModule());
        }
    }
}