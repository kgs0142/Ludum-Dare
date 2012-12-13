package com.ui.flash 
{
    import com.ai.CPlayer;
    import com.greensock.TweenLite;
    import com.greensock.TweenMax;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import gtlib.gtai.model.LivingFurniture;
    import gtlib.system.CSResourceManager;
    
	/**
     * 
     * @author Husky
     */
    public class CPlayerInfoUI extends Sprite
    {
        private var m_lfAttach:LivingFurniture;
        
        //家具屬性提示UI------------------------------------------------------------
        private var m_sprFntTab:Sprite;
        private var m_mcTabIcon:MovieClip;
        
        //能量累計UI----------------------------------------------------------------
        private var m_cWheelUI:CSWheelUI;
        
        public function CPlayerInfoUI(lfAttach:CPlayer) 
        {
            m_lfAttach = lfAttach;
            
            this.visible = false;
            
            this.mouseEnabled = false;
            this.mouseChildren = false;
            
            m_sprFntTab = new Sprite();
            
            m_cWheelUI = new CSWheelUI();
        }
        
        public function create() : void
        {
            m_lfAttach.unRotatableObject.addChild(this);
            
            //1.能量累計UI
            m_cWheelUI.create(m_lfAttach.uiMaxNutrient);
            this.addChild(m_cWheelUI);
            
            //2.家具屬性UI
            m_sprFntTab.graphics.beginFill(0xFFFDFF, 1);
            m_sprFntTab.graphics.lineStyle(1.5, 0X00FFC4);
            m_sprFntTab.graphics.drawCircle(0, 0, 20);
            m_sprFntTab.graphics.endFill();
            
            var sTabClass:String = "mcShopTab_" + String(m_lfAttach.fntTabType);
            var cls:Class = CSResourceManager.getInstance().assetUI.getAssetByName(sTabClass) as Class;

            m_mcTabIcon = new cls() as MovieClip;
            m_mcTabIcon.y = 22.5;
            m_mcTabIcon.gotoAndStop(0);
            m_mcTabIcon.cacheAsBitmap = true;
            m_mcTabIcon.mouseEnabled = false;
            m_mcTabIcon.mouseChildren = false;
            
            m_sprFntTab.addChild(m_mcTabIcon);
            
            this.addChild(m_sprFntTab);
        }
        
        public function release() : void
        {
            
        }
        
        public function show() : void
        {
            //讓家具不斷閃爍
            TweenMax.to(m_lfAttach.mc, 0.5, 
            {
                yoyo: true,
                repeat: -1,
                repeatDelay: 0,
                colorTransform:
                {
                    tint:0xffffff, 
                    tintAmount:0.5, 
                    exposure:2, 
                    brightness:2, 
                    redMultiplier:1
                }
            });
            
            //如果滑鼠在上頭，才真的show
            if (m_lfAttach.container.hitTestPoint(Main.rootStage.mouseX, Main.rootStage.mouseY))
            {
                this.render();
                
                this.visible = true;
                
                m_lfAttach.container.removeEventListener(MouseEvent.MOUSE_MOVE, moveByMouse);
                m_lfAttach.container.addEventListener(MouseEvent.MOUSE_MOVE, moveByMouse);
            }
        }
        
        public function hide() : void
        {
            this.visible = false;
            
            TweenLite.to(m_lfAttach.mc, 0, {colorTransform:{tint:0xffffff, tintAmount:0}});
            
            m_lfAttach.container.removeEventListener(MouseEvent.MOUSE_MOVE, moveByMouse);
        }
        
        public function render() : void
        {
            m_cWheelUI.render(m_lfAttach.uiNutrient);
        }
        
        private function moveByMouse(e:MouseEvent) : void
        {
            //要考慮鏡像的問題
            this.x = e.localX*m_lfAttach.container.scaleX;
            this.y = e.localY - 40;
        }
    }
}