package game.controller.enemy 
{
    import org.flixel.FlxG;
    import org.flixel.FlxObject;
	/**
     * ...
     * @author Husky
     */
    public class BossJumpAttackController extends EnemyBaseController 
    {
        private var m_nChangeDirection:Number;
        
        private var m_nAttackLatency:Number;
        
        public function BossJumpAttackController() 
        {
            m_nAttackLatency = 0.0;
            m_nChangeDirection = 0.0;
        }
        
        override public function update():void 
        {
            super.update();
            
            m_nAttackLatency -= FlxG.elapsed;
            m_nChangeDirection -= FlxG.elapsed;
            
            if (m_Instance.velocity.x > 0)
            {
                m_Instance.facing = FlxObject.RIGHT;
            }
            else
            {
                m_Instance.facing = FlxObject.LEFT;
            }
            
            if (m_nChangeDirection <= 0)
            {
                m_nChangeDirection = 1.0 + Math.random()*2;
                m_Instance.velocity.x = (Math.random() > 0.5) ? 50 : -50;
            }
            
            if (m_Instance.isTouching(FLOOR) && Math.random() < 0.05)
            {
                m_Instance.velocity.y = -100;
            }
            
            if (m_nAttackLatency <= 0.0)
            {
                if (FlxG.overlap(m_Instance, m_Player))
                {
                    m_Player.hurt(1);
                    m_nAttackLatency = 3.0;
                }
            }
        }
    }
}