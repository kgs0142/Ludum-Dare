package game.module 
{
    import adobe.utils.CustomActions;
    import game.ai.Ball;
    import game.ai.BlackGuy;
    import game.ai.LittleBoy;
    import game.ai.Player;
    import game.ai.Trigger;
    import game.scene.CBaseScene;
    import game.scene.CSceneManager;
    import game.scene.MySaves;
    import game.scene.struct.CShapeData;
    import game.ui.HUD;
    import husky.flixel.MyGroup;
    import husky.flixel.MyModule;
    import husky.flixel.MySprite;
    import husky.flixel.util.SprBevelScreen;
    import nc.component.system.NcLoader;
    import nc.component.system.script.NcLuaManager;
    import nc.entity.NcEntityManager;
    import nc.system.NcSystems;
    import org.flixel.FlxCamera;
    import org.flixel.FlxG;
    import org.flixel.FlxObject;
    import org.flixel.FlxPath;
    import org.flixel.FlxPoint;
    import org.flixel.FlxRect;
    import org.flixel.FlxSprite;
    import org.flixel.FlxTileblock;
    import org.flixel.plugin.photonstorm.FlxControl;
    import org.flixel.plugin.photonstorm.FlxControlHandler;
    import org.flixel.system.input.Mouse;
	/**
     * ...
     * @author Husky
     */
    public class GamePlayModule extends BaseSceneModule
    {
        private var m_gBall:MyGroup;
        
        private var m_chaseTargetToDie:FlxSprite;
        
        private var m_chaseTargetDieCallback:Function;
        
        override public function create():void 
        {
            super.create();
            
            FlxG.mouse.show();
        }
        
        protected override function AfterCreateScene():void 
        {
            FlxG.bgColor = 0xFF0DD0;
            
            m_gEnemies = new MyGroup();
            
            var sSpawnID:String = MySaves.checkPoint;
            var spawnPoint:CShapeData = CSceneManager.Get().mapGuid[sSpawnID];
            m_Player = new Player();
            m_Player.x = spawnPoint.x;
            m_Player.y = spawnPoint.y;
           
            m_HUD = new HUD(m_Player);
            
            m_gBall = new MyGroup();
            var ball:Ball = new Ball();
            ball.x = m_Player.x;
            ball.y = m_Player.y - 50;
            m_gBall.add(ball);
            
            this.add(m_HUD);
            
            this.add(m_gEnemies);
            
            this.add(m_gBall);
            
            this.add(m_Player);
            
            var bevel:SprBevelScreen = new SprBevelScreen();
            bevel.Create();
            this.add(bevel);
            
            FlxG.camera.setBounds(CSceneManager.Get().pBoundsMin.x, 
                                  CSceneManager.Get().pBoundsMin.y,
                                  CSceneManager.Get().pBoundsMax.x,
                                  CSceneManager.Get().pBoundsMax.y - CSceneManager.Get().pBoundsMin.y);
            FlxG.camera.follow(m_Player, FlxCamera.STYLE_LOCKON);
            
            FlxG.worldBounds = new FlxRect(CSceneManager.Get().pBoundsMin.x, 
                                           CSceneManager.Get().pBoundsMin.y,
                                           CSceneManager.Get().pBoundsMax.x,
                                           CSceneManager.Get().pBoundsMax.y);
                                           
                                           
            var luaMgr:NcLuaManager = NcSystems.Get().GetComponent(NcLuaManager);
            luaMgr.SetGlobal("gamePlayModule", this);
            
            FlxG.pauseSounds();
            FlxG.play(MusicGame);
        }
        
        override public function update():void 
        {
            super.update();
            
            if (m_chaseTargetToDie != null && m_chaseTargetToDie.health <= 0)
            {
                m_chaseTargetDieCallback();
                
                m_chaseTargetToDie = null;
            }
            
            FlxG.collide(m_Player, m_gWall);
            
            FlxG.collide(m_gBall, m_gWall);
            
            //
            FlxG.collide(m_gEnemies, m_gEnemies);
            
            FlxG.collide(m_gBall, CSceneManager.Get().gCollideLayer);
            
            FlxG.collide(m_Player, CSceneManager.Get().gCollideLayer);
            
            //var vKill:Vector.<FlxSprite> = Vector.<FlxSprite>([]);
            //FlxG.overlap(m_gBall, m_gEnemies, function (ball:Ball, enemy:FlxSprite) : void
            //{
                //trace("kill");
                //ball.stopFollowingPath(true);
                //
                //ball.velocity.x = -ball.velocity.x/2;
                //ball.velocity.y = -50;
                //
                //enemy.kill();
            //});
            
            //if (FlxG.mouse.justPressed(Mouse.LEFT))
            //{
                //var ball:Ball = new Ball();
                //ball.x = m_Player.x;
                //ball.y = m_Player.y;
                //ball.followPath(new FlxPath([new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)]), 200);
                //m_gBall.add(ball);
            //}
        }
        
        public function PlayBossMusic() : void
        {
            FlxG.pauseSounds();
            FlxG.playMusic(MusicBoss);
        }
        
        public function CameraFlash(uiColor:uint, nTime:Number, callback:Function) : void
        {
            FlxG.camera.flash(uiColor, nTime, callback);
        }
        
        public function SetChaseTargetToDie(flxSpr:FlxSprite, callbackDie:Function) : void
        {
            m_chaseTargetToDie = flxSpr;
            m_chaseTargetDieCallback = callbackDie;
        }
    }
}
