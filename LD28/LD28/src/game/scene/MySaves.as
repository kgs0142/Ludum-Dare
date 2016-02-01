package game.scene 
{
    import org.flixel.FlxSave;
	/**
     * ...
     * @author Husky
     */
    public class MySaves 
    {
        private static var m_Save:FlxSave;
        
        public function MySaves() 
        {
            
        }
        
        public static function set hasRecord(bHasRecord:Boolean) : void
        {
            m_Save.data["hasRecord"] = bHasRecord;
        }
        
        public static function get hasRecord() : Boolean
        {
            return m_Save.data.hasOwnProperty("hasRecord") ? m_Save.data["hasRecord"] : false;
        }
        
        public static function set levels(sLevelName:String) : void
        {
            m_Save.data["levels"] = sLevelName;
        }
        
        public static function get levels() : String
        {
            return m_Save.data.hasOwnProperty("levels") ? m_Save.data["levels"] : "Level_First_Stage";
        }
        
        public static function set checkPoint(sCheckPoint:String) : void
        {
            m_Save.data["checkPoint"] = sCheckPoint;
        }
        
        public static function get checkPoint() : String
        {
            return m_Save.data.hasOwnProperty("checkPoint") ? m_Save.data["checkPoint"] : "default_spawn_point";
        }
        
        public static function Load() : void
        {
            m_Save = new FlxSave();
            m_Save.bind("doki_doggie_save");
        }
        
        public static function Save() : void
        {
            m_Save.flush();
        }
    }
}