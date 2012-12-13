package system
{
    import global.CAssetDefine;
    import global.CDefine;
    
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;
    import org.flixel.FlxTilemap;
    import org.flixel.FlxU;
    
    import script.CLuaAlchemy;

    public class CLuaManager
    {
        //sName and Lua mapping Object Table
        //private static var m_objNameLua:Object;
        
        private var m_cLuaAlchemy:CLuaAlchemy;
        
        private static var ms_Instance:CLuaManager;
        
        public function Create() : void
        {
            Initial();
            
            //do lua fils
            this.DoLuaString(CAssetDefine.GAME_PLAY_LUA_NAME);
            this.DoLuaString(CAssetDefine.PLAYER_AI_LUA_NAME);
        }
        
        ///用Lua Script Name來Create CLuaAlchemy
        public function DoLuaString(sName:String) : CLuaAlchemy
        {
            var sScript:String = null;
            
            var sLuaScript:String = CResourceManager.Get().GetLuaAsset(sName);
            m_cLuaAlchemy.doString(sLuaScript);
            
            return m_cLuaAlchemy;
        }
//        private function CreateLua(sName:String) : void
//        {
//            var sLuaScript:String = CResourceManager.Get().GetLuaAsset(sName);
//            var cLuaAlchemy:CLuaAlchemy = new CLuaAlchemy();
//            
//            cLuaAlchemy.doString(sLuaScript);
//            
//            //1. Cant use this way, no use, as3 reference sucks
//            //m_objNameLua[sName] = cLuaAlchemy;
//            
//            //2. use Injector?
//            //Looks ok...
//            CInjectorManager.Get().map(CLuaAlchemy, sName).toValue(cLuaAlchemy);
//            CInjectorManager.Get().injectInto(this);
//            CInjectorManager.Get().unmap(CLuaAlchemy, sName);
//        }
        
//        private function InitialNameTable() : void
//        {
//            m_objNameLua[CAssetDefine.GAME_PLAY_LUA_NAME] = m_cGamePlayLua;
//        }
        
        //初始化Lua會使用到的Class
        private function Initial() : void
        {
            FlxState;
            FlxTilemap;
            FlxSprite;
            FlxGroup;
            FlxText;
            FlxG;
            FlxU;
            
            //lua global variable
            m_cLuaAlchemy.setGlobal("keys", FlxG.keys);
            m_cLuaAlchemy.setGlobal("mouse", FlxG.mouse);
        }
        
        //Gettet / Setter---------------------------------------------------------------
//        [Inject(name="GamePlayModule")]
//        public function set cGamePlayLua(cLua:CLuaAlchemy) : void 
//        {
//            if (m_cGamePlayLua != null && m_cGamePlayLua != cLua)
//            {
//                m_cGamePlayLua.close();
//                m_cGamePlayLua = null;
//            }
//            
//            m_cGamePlayLua = cLua; 
//        }
//        public function get cGamePlayLua() : CLuaAlchemy { return m_cGamePlayLua; }
        
        public function get cLuaAlchemy() : CLuaAlchemy { return m_cLuaAlchemy; }
        //------------------------------------------------------------------------------
        
        public static function Get() : CLuaManager
        {
            if (!ms_Instance)
            {
                ms_Instance = new CLuaManager(new CSSingletonProxy());
            }
            
            return ms_Instance;
        }
        
        public function CLuaManager(proxy:CSSingletonProxy) 
        {
            m_cLuaAlchemy = new CLuaAlchemy();
            
            if (proxy == null) 
            {
                throw new Error("Singleton create error.");
            }
        }
    }
}

class CSSingletonProxy { }