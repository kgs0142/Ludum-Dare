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
    public class CStage5 extends CBaseStageState 
    {
        override public function create():void 
        {
            FlxG.bgColor = 0XFF96AECE;
            
            super.create();
            
            m_sStageName = "Stage5";
            
            var gDoor:CFlxMyGroup = new CFlxMyGroup(10, 100);
            gDoor.bCanTakeIt = false;
            gDoor.add(new CFlxMySprite(DOOR_HANDLE_PIC, "door_handle", 1));
            gDoor.add(new CFlxMySprite(DOOR_BOARD_PIC, "door_board", 0));
            m_gPuzzleObjects.add(gDoor);
            
            //var group:CFlxMyGroup = new CFlxMyGroup(50, 100);
            //m_gPuzzleObjects.add(group);
            
            var group:CFlxMyGroup = new CFlxMyGroup(65, 105);
            group.add(new CFlxMySprite(HEART_CONTAINER, "heart_container", 2));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(100, 115);
            group.add(new CFlxMySprite(HEART_PIECE_4, "heart_piece_4", 3));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(125, 100);
            group.add(new CFlxMySprite(HEART_PIECE_1, "heart_piece_1", 4));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(150, 115);
            group.add(new CFlxMySprite(HEART_PIECE_3, "heart_Piece_3", 5));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(185, 115);
            group.add(new CFlxMySprite(HEART_PIECE_2, "heart_piece_2", 6));
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
                FlxG.switchState(new CEndingState());
            });
        }
        
        public function CStage5() { }
    }
}