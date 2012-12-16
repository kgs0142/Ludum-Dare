package com.system 
{
    import adobe.utils.CustomActions;
    import com.ai.CBaseAI;
    import com.ai.CPlayer;
    import com.game.CBaseScene;
    import com.global.CDefine;
    import com.global.CQTEQuest;
    import com.ui.CMouseUI;
    import com.ui.flash.CWheelUI;
    import flash.events.MouseEvent;
    import flash.geom.Matrix;
    import org.flixel.FlxBasic;
    import org.flixel.FlxG;
    import org.flixel.FlxPoint;
    import org.flixel.FlxText;
    import org.flixel.plugin.photonstorm.FlxControl;
	/**
     * QTE...
     * @author Husky
     */
    public class QTEManager extends FlxBasic
    {
        private static const WAVE_LATENCY:Number = 0.3;
        
        private var m_ftTipMsg:FlxText;
        
        //Left down, Left press, Left Up
        //Right down, Right press, Right Up
        //Middle down, Middle press, Middle Up
        // => PRESS and CLICK, (WAVE?)
        
        //Left and Right mouse pressed and hold
        private var m_bLeftPress:Boolean;
        private var m_bRightPress:Boolean;
        
        private var m_nWaveLatency:Number;
        
        private var m_fpLastMouse:FlxPoint;
        
        //player and target QTE ai
        private var m_cPlayer:CPlayer;
        private var m_aiTarget:CBaseAI;
        
        //QTE QUests
        private var m_arrQTEQuest:Vector.<CQTEUnit>;
        
        //private var m_cTimerUI:CWheelUI;
        private var m_cMouseUI:CMouseUI;
        
        private var m_fnUnitOK:Function;
        private var m_fnUnitFail:Function
        private var m_fnComplete:Function;
        private var m_fnFail:Function
        
        private var m_bActive:Boolean;
        
        private static var ms_Instance:QTEManager;
        
        private function Initial() : void
        {
            m_fnUnitOK = CDefine.FN_EMPTY;
            m_fnUnitFail = CDefine.FN_EMPTY;
            m_fnComplete = CDefine.FN_EMPTY;
            m_fnFail = CDefine.FN_EMPTY;
        
            m_arrQTEQuest = Vector.<CQTEUnit>([]);
            
            CLuaManager.Get().cLuaAlchemy.setGlobal("QTEMgr", this);
        }
        
        public function Deactive() : void
        {
            m_arrQTEQuest.splice(0, m_arrQTEQuest.length);
        }
        
        //active to QTE
        public function Active(cPlayer:CPlayer, cBaseAI:CBaseAI, 
                               onUnitOK:Function, onUnitFail:Function,
                               onComplete:Function = null,
                               onFail:Function = null) : void
        {
            //initial at first
            Initial();
            
            m_cPlayer = cPlayer;
            m_aiTarget = cBaseAI;
            m_fnUnitOK = onUnitOK;
            m_fnUnitFail = onUnitFail;
            m_fnComplete = (onComplete == null) ? CDefine.FN_EMPTY : onComplete;
            m_fnFail = (onFail == null) ? CDefine.FN_EMPTY : onFail;
            
            //stop normal control
            cPlayer.velocity.x = 0;
            cPlayer.velocity.y = 0;
            cPlayer.acceleration.x = 0;
            cPlayer.acceleration.y = 0;
            cBaseAI.velocity.x = 0;
            cBaseAI.velocity.y = 0;
            cBaseAI.acceleration.x = 0;
            cBaseAI.acceleration.y = 0;
            
            FlxControl.stop();
            cBaseAI.bPauseUpdate = true;
            
            //execute the aiTarget's QTE fn
            var arrObj:Array = CLuaManager.Get().cLuaAlchemy.callGlobal(cBaseAI.sQTEFn);
            
            var uiLength:uint = arrObj[1].length;
            for (var ui:uint = 0; ui < uiLength; ui++)
            {
                var obj:Object = arrObj[1][ui];
                var cQTEUnit:CQTEUnit;
                cQTEUnit = new CQTEUnit(obj["action"], obj["times"], obj["counting"],
                                        obj["playerDialog"], obj["enemyDialog"]);
                m_arrQTEQuest.push(cQTEUnit);
            }
            
            m_bActive = true;
        }
        
        private function MouseLeftPressHD(e:MouseEvent) : void
        {
            if (m_bActive == false)
            {
                return;
            }
            
            if (e.type != MouseEvent.MOUSE_DOWN)
            {
                m_bLeftPress = false;
                return;
            }
            
            m_bLeftPress = true;
        }
        
        private function MouseRightPressHD(e:MouseEvent) : void
        {
            if (m_bActive == false)
            {
                return;
            }
            
            if (e.type != MouseEvent.RIGHT_MOUSE_DOWN)
            {
                m_bRightPress = false;
                return;
            }
            
            m_bRightPress = true;
        }
        
        private function MouseClickHD(e:MouseEvent) : void
        {
            if (m_bActive == false)
            {
                return;
            }
            
            if (e.type == MouseEvent.CLICK)
            {
                m_arrQTEQuest[0].Update(CDefine.LEFT_CLICK);
            }
            else if (e.type == MouseEvent.RIGHT_CLICK)
            {
                m_arrQTEQuest[0].Update(CDefine.RIGHT_CLICK);
            }
        }
        
        public override function update() : void
        {
            if (m_bActive == false)
            {
                return;
            }
            
            //the text position
            var cBaseScene:CBaseScene = FlxG.state as CBaseScene;
            m_ftTipMsg.x = cBaseScene.currentLevel.boundsMin.x + FlxG.width/2 - 50; 
            m_ftTipMsg.y = cBaseScene.currentLevel.boundsMin.y + FlxG.height - 25;

            //QTEUnit over------------------------
            if (m_arrQTEQuest.length == 0)
            {
                m_fnComplete();
                
                m_ftTipMsg.text = "";
                this.m_bActive = false;
                FlxControl.start();
                m_aiTarget.bPauseUpdate = false;
                m_cPlayer.ftDialog.text = "";
                m_aiTarget.ftDialog.text = "";
                return;
            }
            
            //Wave mouse--------------------------------------------------------------------
            m_nWaveLatency = (m_nWaveLatency <= 0.0) ? 0.0 : m_nWaveLatency - FlxG.elapsed;
            
            if (Math.abs(m_fpLastMouse.x - FlxG.mouse.screenX) > 2 &&
                Math.abs(m_fpLastMouse.y - FlxG.mouse.screenY) > 2 &&
                m_nWaveLatency <= 0.0)
            {
                //trace("mouse wave");
                m_nWaveLatency = WAVE_LATENCY;
                m_arrQTEQuest[0].Update(CDefine.MOUSE_MOVE);
            }
            
            m_fpLastMouse = FlxG.mouse.getScreenPosition();
            
            //Judge QTE---------------------------------------------------------------------
            
            //Dialog
            m_cPlayer.ftDialog.text = m_arrQTEQuest[0].sPlayerDialog;
            m_aiTarget.ftDialog.text = m_arrQTEQuest[0].sEnemyDialog;
            
            //FIXME here
            m_cMouseUI.Play(m_arrQTEQuest[0].sAction);
            m_cMouseUI.Update();
            
            m_ftTipMsg.text = m_arrQTEQuest[0].sAction + ", times: " +
                              String(m_arrQTEQuest[0].uiAccuNum) + "/" + 
                              String(m_arrQTEQuest[0].uiTimes) + ", " +
                              String(m_arrQTEQuest[0].nAccuTime.toExponential(1)) + "/" + 
                              String(m_arrQTEQuest[0].nCounting);
            
            m_arrQTEQuest[0].nAccuTime += FlxG.elapsed;
            
            if (m_arrQTEQuest[0].IsComplete() == true)
            {
                m_fnUnitOK();
                m_arrQTEQuest.shift();
                CAudioManager.Get().PlaySnd("PlayerHit", 0.5);
            }
            //if IsComplete is false AND accuTime is > Counting time : FAIL
            else if (m_arrQTEQuest[0].IsComplete() == false &&
                     m_arrQTEQuest[0].nAccuTime > m_arrQTEQuest[0].nCounting)
            {
                if (m_fnUnitFail != null)
                {   
                    m_fnUnitFail();
                }
                
                m_arrQTEQuest.shift();
                CAudioManager.Get().PlaySnd("PlayerHurt", 0.5);
            }
        }
        
        public override function draw():void 
        {
            if (m_bActive == false || m_arrQTEQuest.length == 0)
            {
                return;
            }
            
            super.draw();
            
            var uiArcs:uint = (m_arrQTEQuest[0].nCounting - 
                               m_arrQTEQuest[0].nAccuTime)/m_arrQTEQuest[0].nCounting*10;
            
            //m_cTimerUI.Render(uiArcs);
            //
            //var m:Matrix = new Matrix();
            //m.scale(0.5, 0.5);
            //m.translate(FlxG.width/2 - 50, FlxG.height - 25);
            //FlxG.camera.buffer.draw(m_cTimerUI, m);
            
            m_cMouseUI.Render(uiArcs);
            
            CONFIG::debug
            {
                m_ftTipMsg.draw();
            }
        }
        
        public function QTEManager(proxy:CSSingletonProxy)
        {
            if (proxy == null) 
            {
                throw new Error("Singleton create error.");
            }
            
            CQTEQuest.QUEST;
            m_bActive = false;
            m_bLeftPress = false;
            m_bRightPress = false;
            m_nWaveLatency = 0.0;
            
            m_fpLastMouse = new FlxPoint();
            
            m_arrQTEQuest = Vector.<CQTEUnit>([]);
            
            //m_cTimerUI = new CWheelUI();
            //m_cTimerUI.Create(10);
            m_cMouseUI = new CMouseUI();
            m_cMouseUI.Create();
            
            m_ftTipMsg = new FlxText(FlxG.width/2 - 50, FlxG.height - 25, 200, "Press Q T E");
            //m_ftTipMsg.color = 0XFF000000; 
            
            FlxG.stage.addEventListener(MouseEvent.MOUSE_DOWN, MouseLeftPressHD);
            FlxG.stage.addEventListener(MouseEvent.MOUSE_UP, MouseLeftPressHD);
            
            FlxG.stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, MouseRightPressHD);
            FlxG.stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, MouseRightPressHD);
            
            FlxG.stage.addEventListener(MouseEvent.CLICK, MouseClickHD);
            FlxG.stage.addEventListener(MouseEvent.RIGHT_CLICK, MouseClickHD);
            
            CLuaManager.Get().cLuaAlchemy.setGlobal("QTEMgr", this);
        }
        
        public static function Get() : QTEManager
        {
            if (!ms_Instance)
            {
                ms_Instance = new QTEManager(new CSSingletonProxy());
            }
            
            return ms_Instance;
        }
        
        public function get bLeftPress():Boolean 
        {
            return m_bLeftPress;
        }
        
        public function get bRightPress():Boolean 
        {
            return m_bRightPress;
        }
        
        public function get cMouseUI():CMouseUI 
        {
            return m_cMouseUI;
        }
    }
}

import com.global.CDefine;
import com.system.QTEManager;
import org.flixel.FlxG;

class CQTEUnit
{
    public var nAccuTime:Number;
    public var uiAccuNum:uint;
    
    public var sAction:String;
    public var uiTimes:uint;
    public var nCounting:Number;
    public var sPlayerDialog:String;
    public var sEnemyDialog:String;
    
    public function IsComplete() : Boolean
    {
        var mgr:QTEManager = QTEManager.Get();
        
        var bResult:Boolean;
        if (this.sAction == CDefine.LEFT_PRESS)
        {
            bResult = mgr.bLeftPress; 
            //must press pass the counting time (minus a range)
            if (nAccuTime > nCounting - 0.1)
            {
                //FIXME show OK UI
                if (bResult == true)
                {
                    
                }
                
                return bResult
            }
        }
        else if (this.sAction == CDefine.RIGHT_PRESS)
        {
            bResult = mgr.bRightPress; 
            //must press pass the counting time (minus a range)
            if (nAccuTime > nCounting - 0.1)
            {
                //FIXME show OK UI
                if (bResult == true)
                {
                    
                }
                
                return bResult;
            }
        }
        //if Accu click times or wave times has been greater
        else
        {
            if (uiAccuNum >= uiTimes)
            {
                //FlxG.log(this.sAction + ": true");
                return true;
            }
        }
        
        //FlxG.log(this.sAction + ": false");
        return false
    }
    
    public function Update(sAction:String) : void
    {
        if (this.sAction != sAction)
        {
            return;
        }
        
        uiAccuNum++;
        
        //FIXME show OK UI
    }
    
    public function CQTEUnit(sAction:String, uiTimes:uint, nCounting:Number, 
                             sPlayerDialog:String, sEnemyDialog:String) : void
    {
        //accu time for counting time
        this.nAccuTime = 0.0;
        //accu num for counting action times
        this.uiAccuNum = 0;
        
        this.sAction = sAction;
        this.uiTimes = uiTimes;
        this.nCounting = nCounting;
        this.sPlayerDialog = sPlayerDialog;
        this.sEnemyDialog = sEnemyDialog;
    }
};

class CSSingletonProxy { }
