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
    public class CStage9 extends CBaseStageState 
    {
        
        override public function create():void 
        {
            FlxG.bgColor = 0XFFF9A545;
            
            super.create();
            
            m_sStageName = "Stage9";
            
            var gDoor:CFlxMyGroup = new CFlxMyGroup(10, 100);
            gDoor.bCanTakeIt = false;
            gDoor.add(new CFlxMySprite(DOOR_HANDLE_PIC, "door_handle", 2));
            gDoor.add(new CFlxMySprite(DOOR_BOARD_PIC, "door_board", 0));
            gDoor.add(new CFlxMySprite(DOOR_HINT_CAT_PIC, "door_clock", 3));
            m_gPuzzleObjects.add(gDoor);
            
            var group:CFlxMyGroup = new CFlxMyGroup(50, 100);
            group.add(new CFlxMySprite(DOG_HEAD, "dog_head", 7));
            group.add(new CFlxMySprite(CAT_BODY, "cat_body", 5));
            m_gPuzzleObjects.add(group);
            
            //group = new CFlxMyGroup(75, 100);
            //group.add(new CFlxMySprite(UMBRELLA_PART, "umbrella_part", 9));
            //group.add(new CFlxMySprite(DRILL_PIC, "driller", 6));
            //m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(100, 100);
            group.add(new CFlxMySprite(CAT_PIC, "cat_head", 4));
            group.add(new CFlxMySprite(DOG_BODY, "dog_body", 6));
            m_gPuzzleObjects.add(group);
            
            //group = new CFlxMyGroup(125, 100);
            //group.add(new CFlxMySprite(DOOR_BOARD_PIC, "door_board", 1));
            //group.add(new CFlxMySprite(CAT_PIC, "cat", 7));
            //group.add(new CFlxMySprite(CAT_BODY, "catbody", 8));
            //m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(150, 100);
            group.add(new CFlxMySprite(DOG_HEAD, "dog_head", 7));
            group.add(new CFlxMySprite(DOG_BODY, "dog_body", 6));
            m_gPuzzleObjects.add(group);
            
            //group = new CFlxMyGroup(175, 100);
            //group.add(new CFlxMySprite(RHIZOME_PIC, "rhizome", 2));
            //group.add(new CFlxMySprite(FLOWER_PIC, "flower", 3));
            //m_gPuzzleObjects.add(group);
            
            this.add(m_gPuzzleObjects);
            
            m_sprPlayer = new CPlayer(75, 110);
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
                FlxG.switchState(new CStage2());
            });
        }
        
        public function CStage9() {}
    }
}