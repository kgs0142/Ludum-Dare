package game.manager;

/**
 * Lazy level manager
 * @author Husky
 */
class LevelManager
{
    private static var ms_Instance:LevelManager;

    private var levelScripts:Array<String> = [AssetPaths.levelTest__hs];
    private var cutsceneScripts:Array<String> = [AssetPaths.cutsceneTest__hs, AssetPaths.cutSceneEnd__hs];
    
    private var currentLevelIndex:Int = 0;
    
    private function new() 
    {
        this.currentLevelIndex = 0;
    }
    
    public function GetLevelScriptName() : String
    {
        if (currentLevelIndex >= levelScripts.length)
        {
            //levels all clear
            return "";
        }
        
        return levelScripts[currentLevelIndex];
    }
    
    public function GetCutSceneScriptName():String 
    {
        if (currentLevelIndex >= cutsceneScripts.length)
        {
            //levels all clear
            return "";
        }
        
        return cutsceneScripts[currentLevelIndex];
    }
    
    public function LevelClear():Void 
    {
        currentLevelIndex++;
    }
    
    public static function Get() : LevelManager
    {
        if (ms_Instance == null)
        {
            ms_Instance = new LevelManager();
        }
        
        return ms_Instance;
    }
}