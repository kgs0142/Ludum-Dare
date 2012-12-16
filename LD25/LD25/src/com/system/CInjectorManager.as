package com.system
{
    import org.swiftsuspenders.Injector;
    
    public class CInjectorManager extends Injector
    {
        private static var ms_Instance:CInjectorManager;
        
        public static function Get() : CInjectorManager
        {
            if (!ms_Instance)
            {
                ms_Instance = new CInjectorManager(new CSSingletonProxy());
            }
            
            return ms_Instance;
        }
        
        public function CInjectorManager(proxy:CSSingletonProxy) 
        {
            super();
            
            if (proxy == null) 
            {
                throw new Error("Singleton create error.");
            }
        }
    }
}

class CSSingletonProxy { }