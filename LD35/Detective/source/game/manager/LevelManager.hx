package game.manager;

/**
 * Lazy level manager
 * @author Husky
 */
class LevelManager
{
    private static var ms_Instance:LevelManager;

    private var levelScripts:Array<String> = [AssetPaths.level_1st__hs, AssetPaths.level_2nd__hs,
                                              AssetPaths.level_3rd__hs, AssetPaths.level_4th__hs];
    private var cutsceneScripts:Array<String> = [AssetPaths.cutscene_1st__hs, AssetPaths.cutscene_2nd__hs, 
                                                 AssetPaths.cutscene_3rd__hs, AssetPaths.cutscene_4th__hs,
                                                 AssetPaths.cutscene_end__hs];
    
    public var currentLevelIndex:Int = 0;
    
    private var wentThrough:Bool = false;
    
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
        
        if (currentLevelIndex >= levelScripts.length)
        {
            wentThrough = true;
        }
    }
    
    public function IsGameComplete():Bool
    {
        return this.wentThrough;
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