package system
{
    public class CResourceManager
    {
        private static var ms_Instance:CResourceManager;
        
        public function Create() : void
        {
            
        }
        
        //Lua Asset不需要作任何處理，直接RETURN Lua Script
        public function GetLuaAsset(sName:String) : String
        {
            var objLuaAsset:Object = CAssetLoader.Get().objLuaAsset;
            
            if (objLuaAsset.hasOwnProperty(sName) == false)
            {
                return null;
            }
            
            return objLuaAsset[sName];
        }
        
        public static function Get() : CResourceManager
        {
            if (!ms_Instance)
            {
                ms_Instance = new CResourceManager(new CSSingletonProxy());
            }
            
            return ms_Instance;
        }
        
        public function CResourceManager(proxy:CSSingletonProxy) 
        {
            if (proxy == null) 
            {
                throw new Error("Singleton create error.");
            }
        }
    }
}

class CSSingletonProxy { }