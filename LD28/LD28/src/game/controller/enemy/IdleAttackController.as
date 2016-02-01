package game.controller.enemy 
{
    import husky.flixel.MySprite;
    import org.flixel.FlxG;
	/**
     * ...
     * @author Husky
     */
    public class IdleAttackController extends EnemyBaseController 
    {
        private static const ATTACK_LATENCY:Number = 5.0;
        
        private var m_nAttackLatency:Number;
        
        public function IdleAttackController() 
        {
            m_nAttackLatency = 0.0;
        }
        
        override public function Initial(obj:MySprite):void 
        {
            super.Initial(obj);
            
            //初始動畫
            m_Instance.play("idle_weapon");
        }
        
        override public function update():void 
        {
            super.update();
            
            m_nAttackLatency -= FlxG.elapsed;
            if (m_nAttackLatency >= 0.0)
            {
                return;
            }
            
            var nXX:Number = m_Instance.x - m_Player.x;
            var nYY:Number = m_Instance.y - m_Player.y;
            var distance:Number = Math.sqrt(nXX*nXX + nYY*nYY);
            
            if (distance <= 3.0)
            {
                m_nAttackLatency = ATTACK_LATENCY;
                m_Instance.play("attack");
                m_Player.hurt(1);
            }
        }
    }

}