package com.game.state 
{
    import com.ai.CPlayer;
    import com.game.CFlxMyGroup;
    import com.game.CFlxMySprite;
    import com.game.CUIManager;
    import org.flixel.FlxG;
    
	/**
     * ...
     * @author Husky
     */
    public class CStage7 extends CBaseStageState 
    {
 
        override public function create():void 
        {
            FlxG.bgColor = 0XFF29E8EF;
            
            super.create();
            
            m_sStageName = "Stage7";
            
            var gDoor:CFlxMyGroup = new CFlxMyGroup(10, 100);
            gDoor.bCanTakeIt = false;
            gDoor.add(new CFlxMySprite(DOOR_HANDLE_PIC, "door_handle", 1));
            gDoor.add(new CFlxMySprite(DOOR_BOARD_PIC, "door_board", 0));
            //m_gPuzzleObjects.add(gDoor);
            
            //var group:CFlxMyGroup = new CFlxMyGroup(50, 100);
            //m_gPuzzleObjects.add(group);
            
            //var group:CFlxMyGroup = new CFlxMyGroup(10, 100);
            gDoor.add(new CFlxMySprite(CLOCK_COVER_PIC, "clock_cover", 6));
            //m_gPuzzleObjects.add(group);
            
            //var group:CFlxMyGroup = new CFlxMyGroup(10, 100);
            gDoor.add(new CFlxMySprite(DRILL_PIC, "drill", 4));
            //m_gPuzzleObjects.add(group);
            
            //var group:CFlxMyGroup = new CFlxMyGroup(10, 100);
            gDoor.add(new CFlxMySprite(UMBRELLA_PART, "umrealla_part", 5));
            gDoor.add(new CFlxMySprite(CAT_PIC, "cat", 3));
            //m_gPuzzleObjects.add(group);
            
            //var group:CFlxMyGroup = new CFlxMyGroup(10, 100);
            gDoor.add(new CFlxMySprite(WINDMILL_HEAD_PIC, "wind_mill", 10));
            gDoor.add(new CFlxMySprite(RHIZOME_PIC, "rhizome", 9));
            m_gPuzzleObjects.add(gDoor);
            //----------------------------------------------------------------
            var group:CFlxMyGroup = new CFlxMyGroup(75, 100);
            group.add(new CFlxMySprite(KEY_PIC, "key", 20));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(100, 100);
            group.add(new CFlxMySprite(CLOCK_COVER_PIC, "clock_cover", 6));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(125, 100);
            group.add(new CFlxMySprite(UMBRELLA_PART, "umrealla_part", 5));
            group.add(new CFlxMySprite(DRILL_PIC, "drill", 4));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(150, 100);
            group.add(new CFlxMySprite(WINDMILL_HEAD_PIC, "wind_mill", 10));
            group.add(new CFlxMySprite(RHIZOME_PIC, "rhizome", 9));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(175, 100);
            group.add(new CFlxMySprite(CAT_PIC, "cat", 7));
            group.add(new CFlxMySprite(CAT_BODY, "cat_Body", 8));
            m_gPuzzleObjects.add(group);
            
            this.add(m_gPuzzleObjects);
            
            m_sprPlayer = new CPlayer(50, 110);
            m_sprPlayer.loadGraphic(PLAYER_PIC, false, false, 16, 16);
            this.add(m_sprPlayer);
            
            var bevel:SprBevelScreen = new SprBevelScreen();
            bevel.Create();
            this.add(bevel);
            
            //Need add UIManager
            this.add(CUIManager.Get());
            
            //Prologue
            var sFnName:String = this.m_sStageName + "_Prologue";
            m_cLuaMgr.cLuaAlchemy.callGlobal(sFnName);
        }
        
        protected override function GoToNextState() : void
        {
            this.SetStopUpdate(true);
            
            FlxG.fade(0xFF000000, 1.0,
            function () : void
            {
                FlxG.switchState(new CStage8());
            });
        }
        
        
        public function CStage7() { }
    }
}