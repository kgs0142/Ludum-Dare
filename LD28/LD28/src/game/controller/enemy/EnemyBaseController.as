package game.controller.enemy 
{
    import game.ai.BlackGuy;
    import game.ai.Player;
    import game.module.BaseSceneModule;
	import husky.flixel.controller.BaseController;
    import husky.flixel.MySprite;
    import org.flixel.FlxG;
	
	/**
     * ...
     * @author Husky
     */
    public class EnemyBaseController extends BaseController 
    {
        protected var m_Instance:BlackGuy;
        
        protected var m_Player:Player;
            
        public function EnemyBaseController() 
        {
            
        }
        
        override public function Initial(obj:MySprite):void 
        {
            super.Initial(obj);
            
            m_Instance = obj as BlackGuy;
            
            m_Player = (FlxG.state as BaseSceneModule).player;
        }
        
        override public function destroy():void 
        {
            super.destroy();
            
            m_Instance = null;
            
            m_Player = null;
        }
    }
}