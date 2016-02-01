package game.module 
{
    import game.ai.Ball;
    import game.ai.BlackGuy;
    import game.ai.LittleBoy;
    import game.ai.Player;
    import game.scene.CSceneManager;
    import game.scene.MySaves;
    import game.scene.struct.CShapeData;
    import husky.flixel.MyModule;
    import husky.flixel.util.SprBevelScreen;
    import nc.component.system.script.NcLuaManager;
    import nc.system.NcSystems;
    import org.flixel.FlxButton;
    import org.flixel.FlxCamera;
    import org.flixel.FlxG;
    import org.flixel.FlxRect;
    import org.flixel.FlxSprite;
    import org.flixel.plugin.photonstorm.FlxControl;
	
	/**
     * ...
     * @author Husky
     */
    public class MenuModule extends BaseSceneModule 
    {
        [Embed(source="../../../assets/Title.png")]
        private static const TITLE_PIC:Class;
        
        [Embed(source="../../../assets/StuffSet.png")]
        private static const STUFF_PIC:Class;
        
        private var m_sprTitle:FlxSprite;
        
        private var m_btnNewGame:FlxButton;
        
        private var m_btnContinue:FlxButton;
        
        private var m_LittleBoy:LittleBoy;
        
        private var m_Enemy:BlackGuy;
        
        private var m_sprBall:FlxSprite;
        
        override public function create():void 
        {
            FlxG.mouse.show();
            
            FlxG.bgColor = 0XFF96AECE;
            
            m_LuaMgr = NcSystems.Get().GetComponent(NcLuaManager);
            
            CSceneManager.Get().Initial();
            CSceneManager.Get().CreateScene("Level_Menu_Stage", this.CreateSceneComplete);
        }
        
        override protected function AfterCreateScene() : void
        {
            var luaMgr:NcLuaManager = NcSystems.Get().GetComponent(NcLuaManager);
            luaMgr.SetGlobal("menuModule", this);
            
            m_sprTitle = new FlxSprite(20, 10, TITLE_PIC);
            m_sprTitle.scrollFactor.x = m_sprTitle.scrollFactor.y = 0;
            this.add(m_sprTitle);
            
            m_btnNewGame = new FlxButton(20, 85, "New Game", function () : void
            {
                MySaves.hasRecord = true;
                
                luaMgr.DoString("lua_play_menu_ingame()");
            });
            
            m_btnNewGame.scrollFactor.x = m_btnNewGame.scrollFactor.y = 0;
            this.add(m_btnNewGame);
            
            m_btnContinue = new FlxButton(20, 110, "Continue", function () : void
            {
                FlxG.fade(0XFF000000, 1, function () : void
                {
                   FlxG.switchState(new GamePlayModule()); 
                });
            });
            
            if (MySaves.hasRecord == false)
            {
                m_btnContinue.visible = false;
            }
            
            m_btnContinue.scrollFactor.x = m_btnContinue.scrollFactor.y = 0;
            this.add(m_btnContinue);
            
            var start:CShapeData = CSceneManager.Get().mapGuid["default_spawn_point"];
            
            m_Player = new Player();
            m_Player.x = start.x;
            m_Player.y = start.y;
            m_Player.visible = false;
            m_Player.bLockControl = true;
            FlxControl.player1.enabled = false;
            this.add(m_Player);
            
            var boySpawnPoint:CShapeData = CSceneManager.Get().mapGuid["little_boy_spawn_point"];
            m_LittleBoy = new LittleBoy();
            m_LittleBoy.x = boySpawnPoint.x;
            m_LittleBoy.y = boySpawnPoint.y;
            this.add(m_LittleBoy);
            
            m_sprBall = new FlxSprite()
            m_sprBall.x = boySpawnPoint.x + 13;
            m_sprBall.y = boySpawnPoint.y + 6;
            m_sprBall.loadGraphic(STUFF_PIC, false, false, 16, 16, false);
            m_sprBall.addAnimation("idle", [0], 0, false);
            m_sprBall.play("idle");
            m_sprBall.alpha = 0;
            this.add(m_sprBall);
            
            m_Enemy = new BlackGuy();
            m_Enemy.x = boySpawnPoint.x + 100;
            m_Enemy.y = boySpawnPoint.y;
            m_Enemy.visible = false;
            this.add(m_Enemy);
            
            var bevel:SprBevelScreen = new SprBevelScreen();
            bevel.Create();
            this.add(bevel);
            
            FlxG.camera.setBounds(CSceneManager.Get().pBoundsMin.x, 
                                  CSceneManager.Get().pBoundsMin.y,
                                  CSceneManager.Get().pBoundsMax.x,
                                  CSceneManager.Get().pBoundsMax.y);
            FlxG.camera.follow(m_Player, FlxCamera.STYLE_TOPDOWN);
            
            FlxG.worldBounds = new FlxRect(CSceneManager.Get().pBoundsMin.x, 
                                           CSceneManager.Get().pBoundsMin.y,
                                           CSceneManager.Get().pBoundsMax.x,
                                           CSceneManager.Get().pBoundsMax.y);
            
            FlxG.stopReplay();
            
            FlxG.playMusic(MusicMenu);
        }
        
        override public function update():void 
        {
            super.update();
            
            FlxG.collide(m_Player, m_gWall);
            
            FlxG.collide(m_LittleBoy, m_gWall);
            
            FlxG.collide(m_Enemy, m_gWall);
            
            //FlxG.collide(m_gBall, m_gWall);
            
            //
            //FlxG.collide(m_gEnemies, m_gEnemies);
            
            //FlxG.collide(m_gBall, CSceneManager.Get().gCollideLayer);
            
            FlxG.collide(m_Player, CSceneManager.Get().gCollideLayer);
            
            FlxG.collide(m_Enemy, CSceneManager.Get().gCollideLayer);
            
            FlxG.collide(m_LittleBoy, CSceneManager.Get().gCollideLayer);
        }
        
        public function get sprTitle():FlxSprite 
        {
            return m_sprTitle;
        }
        
        public function get btnNewGame():FlxButton 
        {
            return m_btnNewGame;
        }
        
        public function get btnContinue():FlxButton 
        {
            return m_btnContinue;
        }
        
        public function get littleBoy():LittleBoy 
        {
            return m_LittleBoy;
        }
        
        public function get sprBall():FlxSprite 
        {
            return m_sprBall;
        }
        
        public function get enemy():BlackGuy 
        {
            return m_Enemy;
        }
    }
}