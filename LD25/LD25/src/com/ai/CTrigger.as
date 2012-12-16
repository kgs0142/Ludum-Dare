package com.ai 
{
    import com.game.CBaseScene;
    import com.greensock.TweenLite;
    import com.system.CLuaManager;
    import com.system.CSceneManager;
    import org.flixel.FlxCamera;
    import org.flixel.FlxBasic;
    import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	public class CTrigger extends CBaseAI
	{
        ///trigger for once?, default is true
        private var m_bOnce:Boolean;
        
        ///mask enemy? defalut is true
        private var m_bMaskEnemy:Boolean;
        
        ///wait for player key "W", default false
        private var m_bWaitForKey:Boolean;
        
        /// has complete its job
        private var m_bDone:Boolean;
        
        //for lua lock the overlap event, avoid the multi trigger
        private var m_bLockOverlap:Boolean;
        
        private var m_sEvent:String;
        
        /// effect target
        private var m_sTargetGUID:String;
        private var m_cAITarget:CBaseAI;
        //-------------------------------------------------------------------
		//public var target:String = "";
		public var targetObject:Object = null;
		//public var moveDir:uint = FlxObject.NONE;
		
        //arrOverlap: [{obj, bEnter, bStay, bExit}..]
        //check the bExit at update()
        
		public function CTrigger(nX:Number, nY:Number, nWidth:uint, nHeight:uint) 
		{
            this.x = nX;
            this.y = nY;
			this.width = nWidth;
			this.height = nHeight;
			
            //this.visible = false; I wanna render fxtext, if visible is false, cant work
            //it's really a bad idea, nut no time.
            //this.alpha = 0;
            //render in its update, also a suck idea
            //this.visible = false;
            //update render cant work...
            this.alpha = 0;
            //----------------------------------------------------
            
            this.m_bDone = false;
            this.m_bOnce = true;
            this.m_bWaitForKey = false;
            this.m_bMaskEnemy = true;
            
            m_ftDialog.width = 50;
            m_ftDialog.text = "Press W";
            m_ftDialog.alpha = 0;
            
            m_sTargetGUID = "";
		}
        
        public override function OnOverlap(aiOverlap:CBaseAI) : void
        {
            super.OnOverlap(aiOverlap);
            
            //trace("Trigger overlap something, OnEnter, OnStay, or OnExit");
            
            if (m_bDone)
            {
                return;
            }
            
            if (m_bLockOverlap)
            {
                return;
            }
            
            if (m_bMaskEnemy == true && aiOverlap is CEnemy)
            {
                return;
            }
            
            //if has assign the guid to match the CIAobject
            if (m_sTargetGUID != "")
            {
                var cBaseScene:CBaseScene = FlxG.state as CBaseScene;
                m_cAITarget = cBaseScene.ids[m_sTargetGUID] as CBaseAI;
            }
            
            //********if this need to wait for player input------------- 
            if (m_bWaitForKey == true)
            {
                if (FlxG.keys.justPressed("W"))
                {
                    CLuaManager.Get().cLuaAlchemy.setGlobal("trigger", this);
                    CLuaManager.Get().cLuaAlchemy.doString("lua_" + m_sEvent + "()");
                }
                
                //tween
                TweenLite.killTweensOf(m_ftDialog);
                TweenLite.to(m_ftDialog, 0.5,
                {
                    alpha: 1,
                    onComplete:function () : void
                    {
                        TweenLite.to(m_ftDialog, 0.3,
                        {
                            alpha: 0
                        });
                    }
                });
                
                return;
            }
            
            m_bDone = m_bOnce;
            
            CLuaManager.Get().cLuaAlchemy.setGlobal("trigger", this);
            //remember the "()"
            CLuaManager.Get().cLuaAlchemy.doString("lua_" + m_sEvent + "()");
            //var arr:Array = CLuaManager.Get().cLuaAlchemy.callGlobal("playerEnemyRandomQte", [0, 0])
        }
        
		public override function ParseProperties(arrParam:Array) : void
		{
            super.ParseProperties(arrParam);
            
			if (arrParam == null)
            {
                return;
            }
            
            var uiLength:uint = arrParam.length;
            for (var ui:uint = 0; ui < uiLength; ui++)
            {
                // assign the CIAObject target
                if (arrParam[ui].name == "target")
                {
                    //target = arrParam[ui].value;
                    m_sTargetGUID = arrParam[ui].value;
                }
                else if (arrParam[ui].name == "event")
                {
                    m_sEvent = arrParam[ui].value;
                }
                else if (arrParam[ui].name == "once")
                {
                    //it's not bool....
                    m_bOnce = (arrParam[ui].value == "true");
                }
                else if (arrParam[ui].name == "waitInput")
                {
                    m_bWaitForKey = (arrParam[ui].value == "true");
                }
            }
		}
		
        override public function update():void 
        {
            super.update();
            
            m_ftDialog.x = this.x - this.width/2 - m_ftDialog.width/2;
            m_ftDialog.y = this.y - 20;

        }
        
        override public function draw():void 
        {
            super.draw();
            
            m_ftDialog.draw();
        }
        
		public function AddLinkTo(obj:Object):void { targetObject = obj; }
        
        public function get bLockOverlap():Boolean { return m_bLockOverlap; }
        public function set bLockOverlap(value:Boolean):void  { m_bLockOverlap = value; }
        
        public function get cAITarget():CBaseAI {return m_cAITarget;}
	}
}