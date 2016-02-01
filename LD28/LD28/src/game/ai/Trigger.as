package game.ai 
{
    import com.greensock.TweenLite;
    import game.module.BaseSceneModule;
    import game.scene.CSceneManager;
    import game.scene.struct.CShapeData;
    import nc.component.system.script.NcLuaManager;
    import nc.system.NcSystems;
    import org.flixel.FlxG;
    import org.flixel.FlxObject;
    import org.flixel.FlxSprite;
    import org.flixel.FlxTileblock;
	
	public class Trigger extends FlxSprite
	{
        ///trigger for once?, default is true
        private var m_bOnce:Boolean;
        
        ///mask enemy? defalut is true
        private var m_bMaskEnemy:Boolean;
        
        ///wait for player key "W", default false
        //private var m_bWaitForKey:Boolean;
        
        /// has complete its job
        private var m_bDone:Boolean;
        
        //for lua lock the overlap event, avoid the multi trigger
        private var m_bLockOverlap:Boolean;
        
        private var m_sEvent:String;
        
        /// effect target
        private var m_sTargetGUID:String;
        //-------------------------------------------------------------------
		//public var target:String = "";
		public var targetObject:Object = null;
		//public var moveDir:uint = FlxObject.NONE;
		
        //arrOverlap: [{obj, bEnter, bStay, bExit}..]
        //check the bExit at update()
        
		public function Trigger(nX:Number, nY:Number, nWidth:uint, nHeight:uint) 
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
            
            //For nor to collide
            //this.allowCollisions = FlxObject.NONE;
            //----------------------------------------------------
            
            this.m_bDone = false;
            this.m_bOnce = true;
            //this.m_bWaitForKey = false;
            this.m_bMaskEnemy = true;
            
            m_sTargetGUID = "";
		}
        
        public function OnOverlap(aiOverlap:FlxObject) : void
        {
            if (m_bDone)
            {
                return;
            }
            
            if (m_bLockOverlap)
            {
                return;
            }
            
            if (m_bMaskEnemy == true && aiOverlap is BlackGuy)
            {
                return;
            }
            
            //if has assign the guid to match the CIAobject
            //if (m_sTargetGUID != "")
            //{
                //var scene:CBaseScene = FlxG.state as CBaseScene;
                //m_cAITarget = cBaseScene.ids[m_sTargetGUID] as CBaseAI;
            //}
            
            //********if this need to wait for player input------------- 
            var luaMgr:NcLuaManager = NcSystems.Get().GetComponent(NcLuaManager);
            //if (m_bWaitForKey == true)
            //{
                //if (FlxG.keys.justPressed("W"))
                //{
                    //luaMgr.SetGlobal("trigger", this);
                    //luaMgr.DoString("lua_" + m_sEvent + "()");
                //}
                //
                //tween
                //var instance:Trigger = this;
                //TweenLite.killTweensOf(m_ftDialog);
                //TweenLite.to(m_ftDialog, 0.5,
                //{
                    //alpha: 1,
                    //onComplete:function () : void
                    //{
                        //TweenLite.to(m_ftDialog, 0.3,
                        //{
                            //alpha: 0,
                            //onComplete: function () : void
                            //{
                                //instance.bLockOverlap = false;
                            //}
                        //});
                    //}
                //});
                //
                //return;
            //}
            
            m_bDone = m_bOnce;
            
            luaMgr.SetGlobal("trigger", this);
            //remember the "()"
            luaMgr.DoString("lua_" + m_sEvent + "()");
            //var arr:Array = CLuaManager.Get().cLuaAlchemy.callGlobal("playerEnemyRandomQte", [0, 0])
        }
        
		public function ParseProperties(arrParam:Vector.<Object>) : void
		{
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
                    //m_bWaitForKey = (arrParam[ui].value == "true");
                }
            }
		}
        
        //把敵人加在target的位置
        public function AddEnemyOnTargetLoc(flxSpr:FlxSprite, nOffSetX:Number = 0.0, nOffSetY:Number = 0.0) : void
        {
            var target:CShapeData = CSceneManager.Get().mapGuid[m_sTargetGUID];
            flxSpr.x = target.x + nOffSetX;
            flxSpr.y = target.y + nOffSetY;
            
            (FlxG.state as BaseSceneModule).gEnemies.add(flxSpr);
        }
        
        //亂來Function
        public function AddWallOnLoc() : void
        {
            var target:CShapeData = CSceneManager.Get().mapGuid[m_sTargetGUID];
            var ceiling:FlxTileblock = new FlxTileblock(target.x, target.y, 500, 10);
            
            (FlxG.state as BaseSceneModule).gWall.add(ceiling);
        }
		
        override public function update():void 
        {
            super.update();
        }
        
        override public function draw():void 
        {
            super.draw();
        }
        
		public function AddLinkTo(obj:Object):void { targetObject = obj; }
        
        public function get bLockOverlap():Boolean { return m_bLockOverlap; }
        public function set bLockOverlap(value:Boolean):void  { m_bLockOverlap = value; }
	}
}