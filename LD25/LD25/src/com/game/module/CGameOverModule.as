package com.game.module 
{
    import adobe.utils.CustomActions;
    import com.greensock.TweenLite;
    import com.system.CSceneManager;
    import com.util.CBitFlag;
    import org.flixel.FlxG;
    import org.flixel.FlxPoint;
	import org.flixel.FlxState;
    import org.flixel.FlxText;
	
	/**
     * ...
     * @author Husky
     */
    public class CGameOverModule extends FlxState 
    {
        private var m_ftTitle:FlxText;
        
        public function CGameOverModule() 
        {
            m_ftTitle = new FlxText(FlxG.width/2 + 70, 
                                    FlxG.height/2 - 10, 200);
            this.add(m_ftTitle);
            
            m_ftTitle.scale = new FlxPoint(2, 2);
            
            m_ftTitle.text = "YOU";
            
            TweenLite.delayedCall(0.5, Ingame000);
            
            CSceneManager.Get().cTriggerFlag = new CBitFlag(4);
        }
        
        private function Ingame000() : void
        {
            m_ftTitle.text = "Are";
            
            TweenLite.delayedCall(0.5, Ingame001);
        }
        
        private function Ingame001() : void
        {
            m_ftTitle.x = FlxG.width/2 + 40;
            
            m_ftTitle.text = "The Villan.";
            
            TweenLite.delayedCall(0.5, Ingame002);
        }
         
        private function Ingame002() : void
        {
            m_ftTitle.x = FlxG.width/2 - 40;
            m_ftTitle.text = "Thanks for your playing :) \n         "
                              + "               (the end...?)";
        }
        
        override public function update():void 
        {
            super.update();
            
            if (FlxG.keys.ESCAPE)
            {
                FlxG.switchState(new CTitleModule());
            }
        }
    }
}