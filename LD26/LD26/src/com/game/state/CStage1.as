package com.game.state 
{
    import com.ai.CPlayer;
    import com.game.CFlxMyGroup;
    import com.game.CFlxMySprite;
    import com.game.CUIManager;
    import com.greensock.TweenLite;
    import org.flixel.FlxBasic;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxPath;
    import org.flixel.FlxPoint;
    import org.flixel.system.input.Mouse;
	
	/**
     * ...
     * @author Husky
     */
    public class CStage1 extends CBaseStageState 
    {
        override public function create():void 
        {
            FlxG.bgColor = 0XFF29E8EF;
            
            super.create(); 
            
            m_sStageName = "Stage1";
            
            var gDoor:CFlxMyGroup = new CFlxMyGroup(10, 100);
            gDoor.bCanTakeIt = false;
            gDoor.add(new CFlxMySprite(DOOR_HANDLE_PIC, "door_handle", 2));
            gDoor.add(new CFlxMySprite(DOOR_BOARD_PIC, "door_board", 0));
            m_gPuzzleObjects.add(gDoor);
            
            //Cube + Key
            m_gPuzzleBox = new CFlxMyGroup(50 ,100);
            m_gPuzzleBox.add(new CFlxMySprite(KEY_PIC, "key", 3));
            m_gPuzzleBox.add(new CFlxMySprite(CUBE_PIC, "cube", 4));
            m_gPuzzleObjects.add(m_gPuzzleBox);
            
            var gCube:CFlxMyGroup = new CFlxMyGroup(100, 100);
            gCube.add(new CFlxMySprite(CUBE_PIC, "cube", 4));
            m_gPuzzleObjects.add(gCube);
            
            //test
            //var clockBoard:CFlxMyGroup = new CFlxMyGroup(70, 100);
            //clockBoard.add(new CFlxMySprite(CLOCK_BOARD_PIC, "clock_board", 5));
            //m_gPuzzleObjects.add(clockBoard);
            
            
            this.add(m_gPuzzleObjects);
            
            m_sprPlayer = new CPlayer(150, 100);
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
        
        override public function update():void 
        {
            super.update();
            
            //if (IsProcessSolvingPuzzle)
            //{
                //return
            //}
        }
        
        public function CStage1() { }
    }

}



