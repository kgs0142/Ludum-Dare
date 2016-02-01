package game.state.ball 
{
    import game.ai.Ball;
    import game.ai.Player;
    import game.module.BaseSceneModule;
    import org.flixel.FlxG;
    import org.flixel.system.input.Mouse;
	/**
     * ...
     * @author Husky
     */
    public class BallEquipState extends BaseBallState 
    {
        private var m_Player:Player;
        
        public function BallEquipState(instance:Ball) 
        {
            super(instance);
        }
        
        override public function DoFirstRun():void 
        {
            super.DoFirstRun();
            
            m_Player = (FlxG.state as BaseSceneModule).player;
            
            //如果Combo到8以上，變保齡球
            if ((FlxG.state as BaseSceneModule).Hud.comboUI.uiCombo >= 5)
            {
               m_Instance.play("bowling");
            }
            else
            {
               m_Instance.play("normal");
            }
            
            m_Instance.angle = 0.0;
            
            m_Instance.angularAcceleration = 0;
            m_Instance.angularVelocity = 0;
            
            m_Instance.acceleration.y = 0;
            
            FlxG.play(SndAdd);
        }
        
        override public function DoRun():void 
        {
            super.DoRun();
            
            m_Instance.x = m_Player.x;
            m_Instance.y = m_Player.y - m_Player.height;
            
            if (FlxG.mouse.justPressed(Mouse.LEFT))
            {
                //如果Combo到8以上，變保齡球攻擊
                if ((FlxG.state as BaseSceneModule).Hud.comboUI.uiCombo >= 5)
                {
                   m_Instance.SetState(new BallSmashFlyAttackState(m_Instance));
                }
                else
                {
                   m_Instance.SetState(new BallFlyAttackState(m_Instance));
                }
            }
        }
        
        override public function DoLastRun():void 
        {
            super.DoLastRun();
            
            m_Player = null;
        }
    }
}