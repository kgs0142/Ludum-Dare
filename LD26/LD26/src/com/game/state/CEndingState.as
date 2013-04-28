package com.game.state 
{
    import com.ai.CPlayer;
    import com.brompton.entity.BPEntityManager;
    import com.game.CFlxMyGroup;
    import com.game.CFlxMySprite;
    import com.game.CUIManager;
    import org.flixel.FlxBasic;
    import org.flixel.FlxG;
    import org.flixel.FlxPoint;
    import org.flixel.FlxText;
	/**
     * ...
     * @author Husky
     */
    public class CEndingState extends CBaseStageState 
    {
        override public function create():void 
        {
            super.create();
            
            FlxG.bgColor = 0XFF333333;
            
            this.m_sStageName = "Ending";
            
            var gWindow:CFlxMyGroup = new CFlxMyGroup(140, 50);
            gWindow.add(new CFlxMySprite(WINDOW_END, "window_end", 0));
            m_gPuzzleObjects.add(gWindow);
            
            //m_gDoor = new CFlxMyGroup(20, 100);
            //m_gDoor.bCanTakeIt = false;
            //m_gDoor.add(new CFlxMySprite(DOOR_BOARD_PIC, "door_board", 0));
            //m_gDoor.add(new CFlxMySprite(DOOR_HANDLE_PIC, "door_handle", 1));
            //m_gPuzzleObjects.add(m_gDoor);
            var bed:CFlxMyGroup = new CFlxMyGroup(20, 103);
            bed.add(new CFlxMySprite(BED_PIC, "bed", 0));
            m_gPuzzleObjects.add(bed);
            
            m_sprPlayer = new CPlayer(50, 110);
            m_sprPlayer.maxVelocity = new FlxPoint(0, 0);
            m_sprPlayer.loadGraphic(PRISONER_PIC, false, false, 16, 16);
            //m_sprPlayer.loadGraphic(PLAYER_PIC, false, false, 16, 16);
            m_gPuzzleObjects.add(m_sprPlayer);
            
            this.add(m_gPuzzleObjects);
            
            var bevel:SprBevelScreen = new SprBevelScreen();
            bevel.Create();
            this.add(bevel);
            
            //Need add UIManager
            this.add(CUIManager.Get());
            
            //Prologue
            var sFnName:String = this.m_sStageName + "_Prologue";
            m_cLuaMgr.cLuaAlchemy.callGlobal(sFnName);
            
            //var tf:FlxText = new FlxText(FlxG.width - 100, FlxG.height - 10, 100, "Press 'R' to reset.");
            //tf.alpha = 0.5;
            //this.add(tf);
            
            //FlxG.switchState(new CStage1());
        }
        
        override public function update():void 
        {
            //Don do the normal stage update
            //super.update();
            
            if (FlxG.keys.justPressed("R") == true)
            {
                FlxG.switchState(new CMenuState());
            }
            
            BPEntityManager.Get().Update();
            
            var basic:FlxBasic;
			var i:uint = 0;
			while(i < length)
			{
				basic = members[i++] as FlxBasic;
				if((basic != null) && basic.exists && basic.active)
				{
					basic.preUpdate();
					basic.update();
					basic.postUpdate();
				}
			}
        }
        
        public function CEndingState() 
        {
            
        }
    }
}