package game.controller.enemy 
{
    import flash.geom.Point;
	import husky.flixel.controller.BaseController;
    import org.flixel.FlxObject;
    import org.flixel.FlxPoint;
	
	/**
     * ...
     * @author Husky
     */
    public class ChasePlayerController extends EnemyBaseController 
    {
        
        public function ChasePlayerController() 
        {
            
        }
        
        override public function update():void 
        {
            super.update();
            
            m_Instance.facing = (m_Instance.velocity.x > 0) ? FlxObject.RIGHT : FlxObject.LEFT;
            
            if (m_Instance.isTouching(FlxObject.FLOOR) && Math.random() < 0.01)
            {
                m_Instance.velocity.y = - 50;
            }
            
            if (m_Player.x > m_Instance.x)
            {
                m_Instance.velocity.x = 30;
            }
            else
            {
                m_Instance.velocity.x = -30;
            }
        }
    }
}