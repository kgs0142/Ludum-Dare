package com.system 
{
    import com.greensock.TweenLite;
    import com.util.CBitFlag;
    import flash.display.Shader;
    import flash.filters.ShaderFilter;
    import org.flixel.FlxEmitter;
    import org.flixel.FlxG;
	/**
     * Manage all the scenes
     * @author Husky
     */
    public class CSceneManager 
    {
        private var m_iPlayerHP:int;
        private var m_cTriggerFlag:CBitFlag;
        //default scene
        private var m_sCurScenePath:String = "Scene/Level_First.xml";
        
        private static var ms_Instance:CSceneManager;
        
        //particle emitter
        //private var m_emitter:FlxEmitter;
        
        public function Create() : void
        {
            //m_emitter = new FlxEmitter(0, 0, 20);
            //m_emitter.
        }

        public function CSceneManager(proxy:CSSingletonProxy)
        {
            if (proxy == null) 
            {
                throw new Error("Singleton create error.");
            }
            
            m_iPlayerHP = 13;
            m_cTriggerFlag = new CBitFlag(4);
            CLuaManager.Get().cLuaAlchemy.setGlobal("sceneMgr", this);
        }
        
        public static function Get() : CSceneManager
        {
            if (!ms_Instance)
            {
                ms_Instance = new CSceneManager(new CSSingletonProxy());
            }
            
            return ms_Instance;
        }
        
         [Embed(source="../../../assets/shader/TvScreen.pbj", 
          mimeType="application/octet-stream")]
        private static const TvShaderData:Class;
        
        public function ShowTvShader() : void
        {
            FlxG.camera.getContainerSprite().filters = 
            [new ShaderFilter(new Shader(new TvShaderData()))];
        }
        
        public function ShowNormalShader() : void
        {
            FlxG.camera.getContainerSprite().filters = [];
        }
        
        public function get sCurScenePath() : String { return m_sCurScenePath; }
        public function set sCurScenePath(value:String) : void { m_sCurScenePath = value; }
        
        public function get iPlayerHP() : int { return m_iPlayerHP; }
        public function set iPlayerHP(value:int) : void 
        { 
            m_iPlayerHP = value; 
            
            //DEAD
            if (m_iPlayerHP <= 0)
            {
                QTEManager.Get().Deactive();
                m_iPlayerHP = 13;
                FlxG.resetState();
            }
        }
        
        public function get cTriggerFlag() : CBitFlag { return m_cTriggerFlag; }
        
        public function set cTriggerFlag(value:CBitFlag) : void { m_cTriggerFlag = value; }
    }
}

class CSSingletonProxy { }