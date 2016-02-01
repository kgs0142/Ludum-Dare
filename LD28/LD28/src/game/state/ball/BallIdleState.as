package game.state.ball 
{
    import game.ai.Ball;
    import game.ai.Player;
    import game.module.BaseSceneModule;
    import game.scene.CBaseScene;
    import org.flixel.FlxG;
    import org.flixel.FlxObject;
	/**
     * 球撞擊過物體後的State，等著玩家把它撿起來
     * @author Husky
     */
    public class BallIdleState extends BaseBallState 
    {
        private var m_Player:Player;
        
        private var m_Scene:CBaseScene;
        
        private var m_SndTimes:int = 10;
        
        public function BallIdleState(instance:Ball) 
        {
            super(instance);
        }
        
        override public function DoFirstRun():void 
        {
            super.DoFirstRun();
            
            //如果Combo到8以上，變保齡球
            if ((FlxG.state as BaseSceneModule).Hud.comboUI.uiCombo >= 5)
            {
               m_Instance.play("bowling");
            }
            else
            {
               m_Instance.play("normal");
            }
            
            m_Instance.maxVelocity.x = 200;
            
            m_Instance.acceleration.y = 100;
            
            m_Player = (FlxG.state as BaseSceneModule).player;
        }
        
        override public function DoRun():void 
        {
            super.DoRun();
            
            //如果回到IDLE沒有接到球而落地（沒有COMBO）
            if (m_Instance.isTouching(FlxObject.FLOOR) == true ||
                m_Instance.isTouching(FlxObject.CEILING) == true ||
                m_Instance.isTouching(FlxObject.LEFT) == true ||
                m_Instance.isTouching(FlxObject.RIGHT) == true)
            {
                trace("Miss combo");
                m_Instance.play("normal");
                (FlxG.state as BaseSceneModule).Hud.comboUI.ClearCombo();
                
                m_SndTimes--;
                if (m_SndTimes > 0)
                {
                    FlxG.play(SndFloor);
                }
            }
            
            if (FlxG.overlap(m_Player, m_Instance) == true)
            {
                m_Instance.SetState(new BallEquipState(m_Instance));
            }
        }
        
        override public function DoLastRun():void 
        {
            super.DoLastRun();
            
            m_Player = null;
        }
    }
}