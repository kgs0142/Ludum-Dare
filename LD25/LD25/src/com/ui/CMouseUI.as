package com.ui 
{
    import com.game.CBaseScene;
    import com.global.CDefine;
    import com.ui.flash.CWheelUI;
    import flash.geom.Matrix;
    import org.flixel.FlxG;
	import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;
    import org.flixel.FlxSprite;
	
	/**
     * ...
     * @author Husky
     */
    public class CMouseUI
    {
        [Embed(source="../../../assets/mouseAnim.PNG")]
        private static const MOUSE_PIC:Class;
        
        //if I have more time, add one more mouse
        
        private var m_flxsMouse:FlxSprite;
        private var m_cTimerUI:CWheelUI;
        
        public function Create() : void
        {
            m_cTimerUI = new CWheelUI();
            m_cTimerUI.Create(10);
            
            m_flxsMouse = new FlxSprite(100, 100);
            m_flxsMouse.loadGraphic(MOUSE_PIC, true, false, 40, 40);
            m_flxsMouse.addAnimation("idle", [6]);
            m_flxsMouse.addAnimation(CDefine.LEFT_CLICK, [5, 6], 10)
            m_flxsMouse.addAnimation(CDefine.RIGHT_CLICK, [2, 6], 10)
            m_flxsMouse.addAnimation(CDefine.LEFT_PRESS, [4], 1, false)
            m_flxsMouse.addAnimation(CDefine.RIGHT_PRESS, [3], 1, false)
            m_flxsMouse.addAnimation(CDefine.MOUSE_MOVE, [0, 1], 10)
            
            m_flxsMouse.play("idle");
            m_flxsMouse.x = FlxG.width/2 - m_flxsMouse.width/2;
            m_flxsMouse.y = FlxG.height + m_flxsMouse.height*3;
            //m_flxsMouse.offset = new FlxPoint(0, 0);
        }
     
        public function Play(sLabel:String) : void
        {
            m_flxsMouse.play(sLabel)
        }        
        
        public function Update() : void
        {
            var cBaseScene:CBaseScene = FlxG.state as CBaseScene;
            
            m_flxsMouse.x = cBaseScene.currentLevel.boundsMin.x + 
                            FlxG.width/2 - m_flxsMouse.width/2;
            m_flxsMouse.y = cBaseScene.currentLevel.boundsMin.y + 
                            m_flxsMouse.height*3;
                            
            m_flxsMouse.postUpdate();
        }
        
        public function Render(uiArcs:uint) : void
        {  
            var m:Matrix = new Matrix();
            m.scale(0.5, 0.5);
            m.translate(FlxG.width/2 - 50, FlxG.height - 25);
            m_cTimerUI.Render(uiArcs);
            FlxG.camera.buffer.draw(m_cTimerUI, m);
            
            m_flxsMouse.draw();
        }
        
        public function CMouseUI() 
        {
            
        }
        
        public function get flxsMouse():FlxSprite { return m_flxsMouse; }
    }
}