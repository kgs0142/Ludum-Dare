package com.game 
{
    import org.flixel.FlxBasic;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxText;
    import org.flixel.plugin.photonstorm.FlxDelay;
	
	/**
     * ...
     * @author Husky
     */
    public class CUIManager extends FlxGroup 
    {
        private static const DIALOG_X:Number = 0.0;
        private static const DIALOG_Y:Number = 30.0;
        
        private static var ms_Instance:CUIManager;
        
        private var m_tfDialog:FlxText;
        
        private var m_bDoFadeIn:Boolean;
        private var m_bDoFadeOut:Boolean;
        
        private var m_nAccuFadeInTime:Number;
        private var m_nAccuFadeOutTime:Number;
        
        private var m_nMilliFadeInTime:Number;
        private var m_nMilliFadeOutTime:Number;
        
        private var m_fadeIn:FlxDelay;
        private var m_fadeOut:FlxDelay;
        private var m_delayShow:FlxDelay;
        private var m_delayDuration:FlxDelay;
        
        public function ClearAllOtherChild() : void
        {
            for each (var flxBasic:FlxBasic in this.members)
            {
                this.remove(flxBasic);
            }
            
            this.add(m_tfDialog);
        }
        
        public function ClearText() : void
        {
            m_tfDialog.text = "";
            m_fadeIn.abort();
            m_fadeOut.abort();
            m_delayShow.abort();
            m_delayDuration.abort();
            m_bDoFadeIn = false;
            m_bDoFadeOut = false;
            m_nAccuFadeInTime = 0.0;
            m_nAccuFadeOutTime = 0.0;
        }
        
        public function ShowText(sText:String, bFadeOut:Boolean, nDelayShow:Number = 0.0, 
                                 nFadeInTime:Number = 0.0,
                                 nFadeOutTime:Number = 0.0, nDuration:Number = 0.0, 
                                 fnStart:Function = null,
                                 fnComplete:Function = null) : void
        {
            m_nMilliFadeInTime = nFadeInTime*1000;
            m_nMilliFadeOutTime = nFadeOutTime*1000;
            var nDelayShowMilli:Number = nDelayShow*1000;
            var nDurationMilli:Number = nDuration*1000;
            
            m_delayShow.duration = nDelayShowMilli;
            m_delayShow.callback = function () : void
            {
                //do fade in
                m_tfDialog.text = sText;
                m_tfDialog.alpha = 0.0;
                m_tfDialog.centerOffsets(true);
                
                //Initial to fade in
                m_nAccuFadeInTime = 0.0;
                m_bDoFadeIn = true;
                
                m_fadeIn.duration = m_nMilliFadeInTime;
                m_fadeIn.callback = function () : void
                {
                    m_tfDialog.alpha = 1.0;
                    if (fnStart != null)
                    {
                        fnStart();
                    }
                    
                    m_delayDuration.duration = nDurationMilli;
                    m_delayDuration.callback = function () : void
                    {
                        //Don't need fadeout, do complete
                        if (bFadeOut == false)
                        {
                            if (fnComplete != null)
                            {
                                fnComplete();
                            }
                            return;
                        }
                        
                        //need fadeout, doing fadeout and doing complete
                        m_bDoFadeOut = true;
                        m_nAccuFadeOutTime = 0.0;
                        m_nMilliFadeOutTime = m_nMilliFadeOutTime;
                        
                        m_fadeOut.duration = m_nMilliFadeOutTime;
                        m_fadeOut.callback = function () : void
                        {
                            if (fnComplete != null)
                            {
                                fnComplete();
                            }
                        }
                        m_fadeOut.start();
                    }
                    m_delayDuration.start();
                }
                m_fadeIn.start();
            }
            m_delayShow.start();
        }
        
        override public function update():void 
        {
            super.update();
            
            //do fadein
            if (m_bDoFadeIn == true)
            {
                m_nAccuFadeInTime += FlxG.elapsed*1000;
                m_tfDialog.alpha = 1.0*m_nAccuFadeInTime/m_nMilliFadeInTime;
                
                if (m_nAccuFadeInTime > m_nMilliFadeInTime)
                {
                    m_bDoFadeIn = false;
                    m_nAccuFadeInTime = 0.0;
                    m_nMilliFadeInTime = 0.0;
                }
            }
            
            //do fadeout
            if (m_bDoFadeOut == true)
            {
                m_nAccuFadeOutTime += FlxG.elapsed*1000;
                m_tfDialog.alpha = 1.0 - 1.0*m_nAccuFadeOutTime/m_nMilliFadeOutTime;
                
                if (m_nAccuFadeOutTime > m_nMilliFadeOutTime)
                {
                    m_bDoFadeOut = false;
                    m_nAccuFadeOutTime = 0.0;
                    m_nMilliFadeOutTime = 0.0;
                }
            }
        }
        
        public function Initial() : void
        {
            m_bDoFadeIn = false;
            m_bDoFadeOut = false;
            m_fadeIn = new FlxDelay(0);
            m_fadeOut = new FlxDelay(0);
            m_delayShow = new FlxDelay(0);
            m_delayDuration = new FlxDelay(0);
            m_tfDialog = new FlxText(DIALOG_X, DIALOG_Y, FlxG.width);
            
            this.add(m_tfDialog);
        }
        
        public static function Get() : CUIManager
        {
            if (ms_Instance == null)
            {
                ms_Instance = new CUIManager(new CSingletonProxy());
            }
            return ms_Instance;
        }
        
        override public function destroy():void 
        {
            //dont destroy............
        }
        
        public function CUIManager(proxy:CSingletonProxy) 
        { 
            if (proxy == null)
            {
                throw "Dont new singleton";
            }
        }
    }
}

class CSingletonProxy{}