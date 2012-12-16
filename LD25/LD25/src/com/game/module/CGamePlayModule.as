package com.game.module
{
    import com.ai.CBaseAI;
    import com.game.CBaseScene;
    import com.greensock.TweenLite;
    import com.system.CAudioManager;
    import com.system.CSceneManager;
    import com.system.QTEManager;
    import event.CAssetEvent;
    import com.system.CResourceManager;
    import flash.display.Shader;
    import flash.filters.ShaderFilter;
    import org.dame.LevelData;
    import org.flixel.FlxCamera;
    import org.flixel.FlxSprite;
    import org.flixel.FlxTilemap;
    import org.flixel.plugin.photonstorm.FlxBar;
    import org.flixel.plugin.photonstorm.FlxControl;
    
    import flash.events.Event;
    
    import com.global.CAssetDefine;
    
    import org.flixel.FlxButton;
    import org.flixel.FlxG;
    import org.flixel.FlxState;
    
    import com.system.CAssetLoader;
    import com.system.CLuaManager;

    public class CGamePlayModule extends CBaseScene
    {
        private var m_fxHpBar:FlxBar;
        
        public override function create():void
        {
            super.create();
            
            this.Initial();
            
            //Scene part--------------------------------------------------
            this.add(layerStage);
            
            //load Level(scene) now
            this.isLoadingLevel = true;
            this.currentLevel = new LevelData();
            this.currentLevel.LoadMap(CSceneManager.Get().sCurScenePath, OnObjectAddedCallback,
                                      LevelLoadedComplete);
            
            FlxG.watch(CSceneManager.Get(), "iPlayerHP", "pyr hp");
        }
        
        private function Initial() : void
        {
            FlxG.mouse.show();
            
            CLuaManager.Get().cLuaAlchemy.setGlobal("scene", this);
            CLuaManager.Get().cLuaAlchemy.setGlobal("camera", FlxG.camera);
        }
        
        //override public function destroy():void 
        //{
            //this.remove(QTEManager.Get().cMouseUI.flxsMouse);
            //
            //TweenLite.killDelayedCallsTo(FlxG.camera);
            //
            //super.destroy();
        //}
        
        protected override function LevelLoadedComplete(level:LevelData):void 
        {
            FlxG.camera.setBounds(currentLevel.boundsMin.x + 1, 
                                  currentLevel.boundsMin.y + 1, 
                                  currentLevel.boundsMax.x - currentLevel.boundsMin.x, 
                                  currentLevel.boundsMax.y - currentLevel.boundsMin.y, true);
			layerStage.add(level);
            
            //Initial, Create after scene create complete---------------------------
            
            //hmm... I know it's weird... but the location need change here.
            
            CONFIG::debug
            {
                //reload lua file btn
                this.add(new FlxButton(currentLevel.boundsMin.x, 
                                       currentLevel.boundsMin.y, "Reload Lua", ReloadLua));
            }
            
            //QTEManager
            this.add(QTEManager.Get());
           
            //this.add(QTEManager.Get().cMouseUI.flxsMouse);
            
            //player hp bar
            m_fxHpBar = new FlxBar(currentLevel.boundsMin.x + 10, 
                                   currentLevel.boundsMin.y + 20, 
                                   FlxBar.FILL_BOTTOM_TO_TOP, 10, 40, null, "", 0, 13);
            m_fxHpBar.setRange(0, 13);
            m_fxHpBar.percent = 100;
            this.add(m_fxHpBar);
            
            //var m_cHPBar:FlxBar;
            //m_cHPBar = new FlxBar(10, 10, FlxBar.FILL_TOP_TO_BOTTOM, 10, 50, m_player, "iHP");
            //m_cHPBar.trackParent(0, -5);
            //m_cHPBar.health = m_player.iHP;
            //this.add(m_cHPBar);
            
            // Lua After Initial
            CLuaManager.Get().cLuaAlchemy.setGlobal("player", m_player);
            
            // Player Initial
            FlxG.camera.follow(m_player, FlxCamera.STYLE_TOPDOWN);
            
            //	Stop the player running off the edge of the screen and falling into nothing
			//FlxControl.player1.setBounds(currentLevel.boundsMax.x, 
                                         //currentLevel.boundsMin.y, 
                                         //currentLevel.boundsMax.x - currentLevel.boundsMin.x - 1, 
                                         //currentLevel.boundsMax.y - currentLevel.boundsMin.y - 1);

            //remove bound now
            FlxControl.player1.removeBounds();
            
            //test
            if (FlxG.keys.pressed("F"))
            {
                FlxG.flash(0XEEEEEE, 0.3);
            }
                        
            FlxG.camera.alpha = 0;
            
            var obj:Object = {"alpha": 0}
            TweenLite.to(obj, 1.5,
            {
                alpha: 1,
                onUpdate: function () : void
                {
                    FlxG.camera.alpha = obj["alpha"];
                }
            });

			isLoadingLevel = false;
        }
        
        public override function update():void
        {
            if (isLoadingLevel == true)
            {
                return;
            }
            
            super.update();
			
            //HP bar
            m_fxHpBar.currentValue = CSceneManager.Get().iPlayerHP;
            
            // map collisions			
            FlxG.collide(m_player, currentLevel.collideGroup);
            FlxG.collide(currentLevel.collidingSpritesGroup, currentLevel.collideGroup);
            
            FlxG.collide(currentLevel.otherOverlapGroup, currentLevel.collideGroup);
            //overlap: Player and Enemy, Enemy and Overlap layer, Player and Overlap layer 
            
            //player-object collisions
            FlxG.overlap(m_player, currentLevel.overlapGroup, OnOverlap);
            
            FlxG.overlap(m_player, currentLevel.otherOverlapGroup, OnOverlap);
            
			if (FlxG.keys.pressed("ESCAPE"))
			{
				// Restart
				FlxG.switchState( new CGamePlayModule() );
			}
        }
        
        private function OnOverlap(flxsA:FlxSprite, flxsB:FlxSprite) : void
        {
            if (flxsA is CBaseAI)
            {
                (flxsA as CBaseAI).OnOverlap(flxsB as CBaseAI);
            }
            
            if (flxsB is CBaseAI)
            {
                (flxsB as CBaseAI).OnOverlap(flxsA as CBaseAI);
            }
        }
       
    }
}
