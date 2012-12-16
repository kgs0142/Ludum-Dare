package com.system
{
    import event.CAssetEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    
    import com.global.CAssetDefine;
    import com.global.CDefine;
    
    import org.flixel.FlxG;
    import org.flixel.FlxTimer;
    import org.flixel.FlxU;
    
    public class CAssetLoader extends EventDispatcher
    {
        //Lua Asset
        private var m_objLuaAsset:Object;

        //累計已Load的Asset和總共多少Asset
        //private var m_uiCountAsset:uint;
        //private var m_uiTotalAsset:uint;
        
        ///確認有沒有Load過的Object表
        private var m_objLoadComplete:Object;
        
        ///只會執行一次的Complete Callback
        private var m_fnComplete:Function;
        
        //Load path的前綴路徑
        private var m_sPrefix:String;
        
        private static var ms_Instance:CAssetLoader;
        
        public function loadAsset(fnComplete:Function) : void
        {
            m_fnComplete = (fnComplete != null) ? fnComplete : CDefine.FN_EMPTY;
            
            //Loading 畫面
            
            //Security Domain
            
            //var sPrefix:String = (CONFIG::debug) ? "./" : "/beta/bin/";
            m_sPrefix = "../";
            
            m_objLuaAsset = new Object();
            
            //建構所有的屬性為Loader，Load完後再覆蓋為Asset
            //m_objLuaAsset[CAssetDefine.GAME_PLAY_LUA_NAME] = new URLLoader();
            
            //計算有幾個Asset要Load
            //CountAssetNum();
            
            //其實Load的部份可以再更漂亮一點，不過就先這樣了吧
            //迴圈，之後把資料寫到表裡面一次Load吧
            this.LoadLua(CAssetDefine.GAME_PLAY_LUA_NAME, 
                         CAssetDefine.GAME_PLAY_LUA_PATH);
            this.LoadLua(CAssetDefine.PLAYER_AI_LUA_NAME, 
                         CAssetDefine.PLAYER_AI_LUA_PATH);
            this.LoadLua(CAssetDefine.EVENT_LUA_NAME,
                         CAssetDefine.EVENT_LUA_PATH);
            this.LoadLua(CAssetDefine.QTE_LUA_NAME,
                         CAssetDefine.QTE_LUA_PATH);
        }
        
        //Load Lua 呼叫的
        public function LoadLua(sName:String, sPath:String) : void
        {
            var urlLoader:URLLoader;
            var urlRequest:URLRequest;
            
            m_objLuaAsset[sName] = null;
            
            m_objLuaAsset[sName] = new URLLoader();
            urlLoader = m_objLuaAsset[sName];
            urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
            urlLoader.addEventListener(Event.COMPLETE, this.LuaLoadCompleteHD);
			//urlLoader.addEventListener(IOErrorEvent.IO_ERROR, loadFailedIO,false,0,true);
			//urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadFailedSecurity, false, 0, true);
			//urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusUpdate, false, 0, true);
            urlRequest = new URLRequest(m_sPrefix + sPath);

            //註冊到Load Check Object Table中
            this.RegisterLoadTable(sName);
            
            //全部都要至少下個Frame開始Load，以防還在呼叫LoadLua的期間，已經有人呼叫完成了
            CTimer.Get().register(urlLoader, function() : void
            {
                urlLoader.load(urlRequest);
            }, 0, 1, 1);
        }
        
            //function httpStatusUpdate(e:HTTPStatusEvent):void
            //{
                //FlxG.log("HTTPStatus: " + event.status);
                //throw new Error("HTTPStatus: " + e.status);
            //}
            //
            //function loadFailedIO(e:IOErrorEvent ):void
            //{
                //FlxG.log("IO Error: Failed to load file: " + filename + " == " + event.text);
                //throw new Error ("IO Error: Failed to load file: " + e.text);
            //}
            //
            //function loadFailedSecurity(e:SecurityErrorEvent ):void
            //{
                //FlxG.log("Security Error: Failed to load file:"  + filename + " == " + event.text);
                //throw new Error("Security Error: Failed to load file:"  + e.text);
            //}
        
        //Lua Asset Load complete 呼叫的函式
        private function LuaLoadCompleteHD(e:Event) : void
        {
            var urlLoader:URLLoader = (e.currentTarget as URLLoader);
            urlLoader.removeEventListener(Event.COMPLETE, LuaLoadCompleteHD);
            urlLoader.close();
            
            var sName:String = this.GetName(urlLoader);
            m_objLuaAsset[sName] = urlLoader.data;
            
            urlLoader = null;
            
            //發出Lua Complete事件
            var eAsset:CAssetEvent = new CAssetEvent(CAssetEvent.LUA_LOAD_COMPLETE);
            eAsset.sName = sName;
            eAsset.sPath = "";
            this.dispatchEvent(eAsset);
            
            //m_uiCountAsset++;
            this.UnRegisterLoadTable(sName);
            
            this.LoadCompleteCheck();
        }
        
        //用objID抓出Asset的Parameter Name--------------------------
        private function GetName(objID:Object) : String
        {
            var arrAsset:Vector.<Object> = Vector.<Object>([m_objLuaAsset]);
            
            for (var ui:uint = 0; ui < arrAsset.length; ui++)
            {
                //sName => 屬性的名字
                for (var sName:String in arrAsset[ui])
                {
                    if (arrAsset[ui][sName] != objID)
                    {
                        continue;
                    }
                    
                    return sName;
                }
            }
            
            return "";
        }
        
        //檢查Load完了沒
        private function LoadCompleteCheck() : void
        {
            if (this.IsLoadComplete() == true)
            {
                m_fnComplete();
                m_fnComplete = CDefine.FN_EMPTY;
                
                //發出Asset Load Complete事件
                var eAsset:CAssetEvent = new CAssetEvent(CAssetEvent.ASSET_LOAD_COMPLETE);
                this.dispatchEvent(eAsset);
            }
        }
        
        //檢查Load完了沒
        private function IsLoadComplete() : Boolean
        {
            for each (var bComplete:Boolean in m_objLoadComplete)
            {
                if (bComplete == true)
                {
                    continue;
                }
                
                return false;
            }
            
            return true;
        }
        
        private function RegisterLoadTable(sName:String) : void
        {
            m_objLoadComplete[sName] = false;
        }
        
        private function UnRegisterLoadTable(sName:String) : void
        {
            m_objLoadComplete[sName] = true;
        }
        
        //計算要Load的Asset數量-----------------------------
//        private function CountAssetNum() : void
//        {
//            for (var obj:Object in m_objLuaAsset)
//            {
//                m_uiTotalAsset++;
//            }
//        }
        
        //Gettet / Setter---------------------------------------------------------------
        public function get objLuaAsset() : Object { return m_objLuaAsset; }
        
        //------------------------------------------------------------------------------
        
        public static function Get() : CAssetLoader
        {
            if (!ms_Instance)
            {
                ms_Instance = new CAssetLoader(new CSSingletonProxy());
            }
            
            return ms_Instance;
        }
        
        public function CAssetLoader(proxy:CSSingletonProxy) 
        {
            //m_uiCountAsset = 0;
            //m_uiTotalAsset = 0;
            
            //m_objLoadComplete = new Object();
            m_objLoadComplete = {};
            
            if (proxy == null) 
            {
                throw new Error("Singleton create error.");
            }
        }
    }
}

class CSSingletonProxy { }