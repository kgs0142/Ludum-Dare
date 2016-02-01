package game.state.ball 
{
    import flash.geom.Point;
    import game.ai.Ball;
    import game.ai.Player;
    import game.module.BaseSceneModule;
    import game.scene.CBaseScene;
    import husky.flixel.MyGroup;
    import org.flixel.FlxG;
    import org.flixel.FlxObject;
    import org.flixel.FlxSprite;
	/**
     * ...
     * @author Husky
     */
    public class BallSmashFlyAttackState extends BaseBallState 
    {
        private var m_Player:Player;
        
        private var m_gEnemies:MyGroup;
        
        private var m_Scene:CBaseScene;
        
        public function BallSmashFlyAttackState(ball:Ball) 
        {
            super(ball);
        }
        
        override public function DoFirstRun():void 
        {
            super.DoFirstRun();
            
            m_Player = (FlxG.state as BaseSceneModule).player;
            m_gEnemies = (FlxG.state as BaseSceneModule).gEnemies;
            m_Scene = (FlxG.state as BaseSceneModule).scene;
            
            var dirFly:Point = new Point(FlxG.mouse.x - m_Instance.x - m_Instance.width/2, 
                                         FlxG.mouse.y - m_Instance.y - m_Instance.height/2);
            dirFly.normalize(800);
            m_Instance.velocity.x = dirFly.x;
            m_Instance.velocity.y = dirFly.y;
            
            //球的參數
            m_Instance.elasticity = 0.1;
            
            m_Instance.maxVelocity.x = 800;
            
            m_Instance.angularAcceleration = 30;
            m_Instance.angularVelocity = 30;
            
            m_Instance.acceleration.y = 50;
            
            m_Instance.PlayBlurEffect();
            
            FlxG.play(SndThrowBall);
        }
        
        override public function DoRun():void 
        {
            super.DoRun();
            
            if (m_Instance.isTouching(FlxObject.FLOOR) == true ||
                m_Instance.isTouching(FlxObject.CEILING) == true ||
                m_Instance.isTouching(FlxObject.LEFT) == true ||
                m_Instance.isTouching(FlxObject.RIGHT) == true)
            {
                m_Instance.SetState(new BallIdleState(m_Instance));
                return;
            }
            
            //這邊不要這樣寫，之後改掉
            if (FlxG.overlap(m_Instance, m_gEnemies, function (ball:Ball, enemy:FlxSprite) : void
                {
                    trace("黑衣人扣血");
                    enemy.hurt(10);
                    enemy.flicker(0.5);
                    
                    FlxG.score += 500;
                    
                    //ball.velocity.x = -ball.velocity.x/2;
                    //ball.velocity.y = -50;
                    
                    var uiCombo:uint = (FlxG.state as BaseSceneModule).Hud.comboUI.uiCombo + 1;
                    (FlxG.state as BaseSceneModule).Hud.comboUI.SetCombo(uiCombo);
                    
                }) == true)
            {
                //m_Instance.SetState(new BallIdleState(m_Instance));
                return;
            }
            
            //留意其他情況
        }
        
        override public function DoLastRun():void 
        {
            m_Instance.RemoveBlurEffect();

            super.DoLastRun();
            
            m_Player = null;
            m_gEnemies = null;
        }
    }
}