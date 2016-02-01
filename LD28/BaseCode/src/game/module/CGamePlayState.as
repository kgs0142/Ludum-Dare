package game.module 
{
	import org.flixel.FlxState;
	
	/**
     * ...
     * @author Husky
     */
    public class CGamePlayState extends FlxState 
    {
        //FlxGroup of GameObject and UI (For separating trigger the postEffect)
        private var m_gGO:FlxGroup;
        private var m_gUI:FlxGroup;
        
        public function CGamePlayState() 
        {
            
        }
        
        override public function update():void 
        {
            super.update();
            
            BPEntityManager.Get().Update();
            
            FlxG.collide(m_sprPlayer, CSceneManager.Get().m_gSolidTilemaps);
        }
    }

}