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
    public class CStage6 extends CBaseStageState 
    {
        
        override public function create():void 
        {
            FlxG.bgColor = 0XFF29E8EF;
            
            super.create();
            
            m_sStageName = "Stage6";
            
            var gDoor:CFlxMyGroup = new CFlxMyGroup(10, 100);
            gDoor.bCanTakeIt = false;
            gDoor.add(new CFlxMySprite(DOOR_HANDLE_PIC, "door_handle", 1));
            gDoor.add(new CFlxMySprite(DOOR_BOARD_PIC, "door_board", 0));
            m_gPuzzleObjects.add(gDoor);
            
            //var group:CFlxMyGroup = new CFlxMyGroup(50, 100);
            //m_gPuzzleObjects.add(group);
            
            var group:CFlxMyGroup = new CFlxMyGroup(75, 100);
            group.add(new CFlxMySprite(DOG_HEAD, "dog_head", 6));
            group.add(new CFlxMySprite(DOG_BODY, "dog_body", 5));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(100, 100);
            group.add(new CFlxMySprite(DOG_HEAD, "dog_head", 6));
            group.add(new CFlxMySprite(DOG_BODY, "dog_body", 5));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(125, 100);
            group.add(new CFlxMySprite(CAT_PIC, "cat", 3));
            group.add(new CFlxMySprite(CAT_BODY, "cat_body", 4));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(150, 100);
            group.add(new CFlxMySprite(CAT_PIC, "cat", 3));
            group.add(new CFlxMySprite(CAT_BODY, "cat_body", 4));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(195, 100);
            group.add(new CFlxMySprite(DOG_HEAD, "dog_head", 6));
            group.add(new CFlxMySprite(DOG_BODY, "dog_body", 5));
            group.add(new CFlxMySprite(KEY_PIC, "key", 2));
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
            
            //Rest Stage Lua flags
            m_cLuaMgr.cLuaAlchemy.callGlobal("Lua_ResetAllFlag");
        }
        
        public function CStage6() {}
        
        protected override function GoToNextState() : void
        {
            this.SetStopUpdate(true);
            
            FlxG.fade(0xFF000000, 1.0,
            function () : void
            {
                FlxG.switchState(new CStage7());
            });
        }
    }

}