package com.game.module 
{
    import com.system.CAudioManager;
    import org.flixel.FlxG;
	import org.flixel.FlxState;
    import org.flixel.FlxText;
	
	/**
     * ...
     * @author Husky
     */
    public class CTitleModule extends FlxState 
    {
        private var m_ftTitle:FlxText;
        
        private var m_ftText:FlxText;
        
        override public function create():void 
        {
            m_ftTitle = new FlxText(FlxG.width/2 - 60, 
                                    FlxG.height/2 - 30, 200, 
                                    "YOU are the Villain.");
            this.add(m_ftTitle);
            
            m_ftText = new FlxText(FlxG.width/2 - 30, 
                                   FlxG.height/2 + 25, 
                                   100, "Press W");
            this.add(m_ftText);  
            
            CAudioManager.Get().stopMusic();
            CAudioManager.Get().PlayMusic("Music001", 0.5);
            //CAudioManager.Get().PlayMusic("TitleMusic", 0.5);
        }
        
        override public function update():void 
        {
            super.update();
            
            if (FlxG.keys.justPressed("W"))
            {
                CAudioManager.Get().stopMusic();
                CAudioManager.Get().PlaySnd("TitleSelect");
                FlxG.switchState(new CGamePlayModule());
            }
        }
        
        public function CTitleModule() 
        {
            
        }
    }
}