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
    public class CStage8 extends CBaseStageState 
    {
        
        override public function create():void 
        {
           FlxG.bgColor = 0XFFF9A545;
            
            super.create();
            
            m_sStageName = "Stage8";
            
            var gDoor:CFlxMyGroup = new CFlxMyGroup(10, 100);
            gDoor.bCanTakeIt = false;
            gDoor.add(new CFlxMySprite(DOOR_HANDLE_PIC, "door_handle", 2));
            gDoor.add(new CFlxMySprite(DOOR_BOARD_PIC, "door_board", 0));
            gDoor.add(new CFlxMySprite(DOOR_HINT_1030_PIC, "door_clock", 3));
            m_gPuzzleObjects.add(gDoor);
            
            var group:CFlxMyGroup = new CFlxMyGroup(50, 100);
            //m_gPuzzleBox.add(new CFlxMySprite(TWELVE_FIFTEEN_PIC, "tweleve_fifteen", 6));
            group.add(new CFlxMySprite(CLOCK_BOARD_PIC, "clock_board", 4));
            m_gPuzzleObjects.add(group);
            
            //var group:CFlxMyGroup = new CFlxMyGroup(80, 100);
            //group.add(new CFlxMySprite(WRONG_NEEDLE_2_PIC, "wrong_needle2", 7));
            //m_gPuzzleObjects.add(group);
            
            //group = new CFlxMyGroup(105, 100);
            //group.add(new CFlxMySprite(WRONG_NEEDLE_1_PIC, "wrong_needle1", 11));
            //m_gPuzzleObjects.add(group);
            
            //group = new CFlxMyGroup(130, 100);
            //group.add(new CFlxMySprite(WRONG_NEEDLE_3_PIC, "wrong_needle3", 8));
            //m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(155, 100);
            group.add(new CFlxMySprite(WRONG_NEEDLE_1_PIC, "ten_thirty", 10));
            m_gPuzzleObjects.add(group);
            
            //group = new CFlxMyGroup(180, 100);
            //group.add(new CFlxMySprite(TWELVE_FIFTEEN_PIC, "tweleve_fifteen", 6));
            //m_gPuzzleObjects.add(group);
            
            this.add(m_gPuzzleObjects);
            
            m_sprPlayer = new CPlayer(100, 110);
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
                FlxG.switchState(new CStage9());
            });
        }
        
        public function CStage8() { }
    }
}