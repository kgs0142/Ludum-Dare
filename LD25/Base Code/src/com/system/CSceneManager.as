package com.system 
{
	/**
     * Manage all the scenes
     * @author Husky
     */
    public class CSceneManager 
    {
        private static var ms_Instance:CSceneManager;
        
        public function CSceneManager(proxy:CSSingletonProxy)
        {
            if (proxy == null) 
            {
                throw new Error("Singleton create error.");
            }
        }
        
        public static function Get() : CSceneManager
        {
            if (!ms_Instance)
            {
                ms_Instance = new CSceneManager(new CSSingletonProxy());
            }
            
            return ms_Instance;
        }
    }
}

class CSSingletonProxy { }