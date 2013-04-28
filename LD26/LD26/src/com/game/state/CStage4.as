package com.game.state 
{
    import com.ai.CPlayer;
    import com.game.CFlxMyGroup;
    import com.game.CFlxMySprite;
    import com.game.CUIManager;
    import flash.utils.Dictionary;
    import org.flixel.FlxG;
	/**
     * ...
     * @author Husky
     */
    public class CStage4 extends CBaseStageState
    {
        private var map:Dictionary;
        
        public function CStage4() 
        { 
            map = new Dictionary();
            map[DOOR_HANDLE_PIC] = {"name": "door_handle", "depth": 1};
            map[DOOR_BOARD_PIC] = {"name": "door_board", "depth": 0};
            map[DOLL_WRONG_EMO_PIC] = {"name": "doll_wrong_emo", "depth": 16};
            map[DOLL_RIGHT_EMO_PIC] = {"name": "doll_right_emo", "depth": 15};
            map[DOLL_HEAD_PIC] = {"name": "doll_head", "depth": 14};
            map[DOLL_WRONG_HAIR_PIC] = {"name": "doll_wrong_hair", "depth": 13};
            map[DOLL_RIGHT_HAIR_PIC] = {"name": "doll_right_hair", "depth": 12};
            map[DOLL_BODY_PIC] = {"name": "doll_body", "depth": 11};
            map[DOLL_LEFT_HAND_PIC] = {"name": "doll_left_hand", "depth": 8};
            map[DOLL_RIGHT_HAND_PIC] = {"name": "doll_right_hand", "depth": 7};
            map[DOLL_LEFT_LEG_PIC] = {"name": "doll_left_leg", "depth": 6};
            map[DOLL_RIGHT_LEG_PIC] = {"name": "doll_right_leg", "depth": 5};
            map[DOLL_SPIDER_LEFT_LEG_PIC] = {"name": "doll_spider_left_leg", "depth": 4};
            map[DOLL_SPIDER_RIGHT_LEG_PIC] = {"name": "doll_spider_right_leg", "depth": 3};
            
            map[CAT_BODY] = {"name": "cat_body", "depth": 10};
            map[CAT_PIC] = {"name": "cat_head", "depth": 9};
            
            map[CUBE_PIC] = {"name": "cube", "depth": 17};
        }
        
        override public function create():void 
        {
            FlxG.bgColor = 0XFFB598C9;

            super.create();
            
            m_sStageName = "Stage4";
            
            var gDoor:CFlxMyGroup = new CFlxMyGroup(10, 100);
            gDoor.bCanTakeIt = false;
            gDoor.add(new CFlxMySprite(DOOR_HANDLE_PIC, map[DOOR_HANDLE_PIC].name, 
                                       map[DOOR_HANDLE_PIC].depth));
            gDoor.add(new CFlxMySprite(DOOR_BOARD_PIC, map[DOOR_BOARD_PIC].name, 
                                       map[DOOR_BOARD_PIC].depth));
            m_gPuzzleObjects.add(gDoor);
            
            group = new CFlxMyGroup(50, 100);
            group.add(new CFlxMySprite(DOLL_HEAD_PIC, map[DOLL_HEAD_PIC].name, 
                                       map[DOLL_HEAD_PIC].depth));
            group.add(new CFlxMySprite(DOLL_BODY_PIC, map[DOLL_BODY_PIC].name, 
                                       map[DOLL_BODY_PIC].depth));
            group.add(new CFlxMySprite(DOLL_SPIDER_LEFT_LEG_PIC, map[DOLL_SPIDER_LEFT_LEG_PIC].name, 
                                       map[DOLL_SPIDER_LEFT_LEG_PIC].depth));
            group.add(new CFlxMySprite(DOLL_SPIDER_RIGHT_LEG_PIC, map[DOLL_SPIDER_RIGHT_LEG_PIC].name, 
                                       map[DOLL_SPIDER_RIGHT_LEG_PIC].depth));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(75, 100);
            group.add(new CFlxMySprite(DOLL_WRONG_EMO_PIC, map[DOLL_WRONG_EMO_PIC].name, 
                                       map[DOLL_WRONG_EMO_PIC].depth));
            group.add(new CFlxMySprite(DOLL_BODY_PIC, map[DOLL_BODY_PIC].name, 
                                       map[DOLL_BODY_PIC].depth));
            m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(100, 100);
            group.add(new CFlxMySprite(CAT_PIC, map[CAT_PIC].name, 
            map[CAT_PIC].depth));
            group.add(new CFlxMySprite(CAT_BODY, map[CAT_BODY].name, 
            map[CAT_BODY].depth));
            group.add(new CFlxMySprite(DOLL_SPIDER_LEFT_LEG_PIC, map[DOLL_SPIDER_LEFT_LEG_PIC].name, 
            map[DOLL_SPIDER_LEFT_LEG_PIC].depth));
            group.add(new CFlxMySprite(DOLL_SPIDER_RIGHT_LEG_PIC, map[DOLL_SPIDER_RIGHT_LEG_PIC].name, 
            map[DOLL_SPIDER_RIGHT_LEG_PIC].depth));
            m_gPuzzleObjects.add(group);
            
            //group = new CFlxMyGroup(100, 100);
            //group.add(new CFlxMySprite(, map[].name, 
                               //map[].depth));
            //m_gPuzzleObjects.add(group);
            
            group = new CFlxMyGroup(125, 100);
            group.add(new CFlxMySprite(DOLL_WRONG_HAIR_PIC, map[DOLL_WRONG_HAIR_PIC].name, 
                                       map[DOLL_WRONG_HAIR_PIC].depth));
            group.add(new CFlxMySprite(DOLL_WRONG_EMO_PIC, map[DOLL_WRONG_EMO_PIC].name, 
                                       map[DOLL_WRONG_EMO_PIC].depth));
            group.add(new CFlxMySprite(DOLL_HEAD_PIC, map[DOLL_HEAD_PIC].name, 
                                       map[DOLL_HEAD_PIC].depth));
                                       
            group.add(new CFlxMySprite(DOLL_RIGHT_HAIR_PIC, map[DOLL_RIGHT_HAIR_PIC].name, 
                                       map[DOLL_RIGHT_HAIR_PIC].depth));
                                       
            group.add(new CFlxMySprite(DOLL_LEFT_HAND_PIC, map[DOLL_LEFT_HAND_PIC].name, 
                                       map[DOLL_LEFT_HAND_PIC].depth));
            group.add(new CFlxMySprite(DOLL_RIGHT_HAND_PIC, map[DOLL_RIGHT_HAND_PIC].name, 
                                       map[DOLL_RIGHT_HAND_PIC].depth));   
            group.add(new CFlxMySprite(CUBE_PIC, map[CUBE_PIC].name, 
                                       map[CUBE_PIC].depth));                       
            m_gPuzzleObjects.add(group);
            
            var group:CFlxMyGroup = new CFlxMyGroup(150, 100);
            group.add(new CFlxMySprite(DOLL_RIGHT_EMO_PIC, map[DOLL_RIGHT_EMO_PIC].name, 
                                       map[DOLL_RIGHT_EMO_PIC].depth));
            group.add(new CFlxMySprite(DOLL_HEAD_PIC, map[DOLL_HEAD_PIC].name, 
                                       map[DOLL_HEAD_PIC].depth));

            //group.add(new CFlxMySprite(DOLL_BODY_PIC, map[DOLL_BODY_PIC].name, 
                                       //map[DOLL_BODY_PIC].depth));

            group.add(new CFlxMySprite(DOLL_LEFT_LEG_PIC, map[DOLL_LEFT_LEG_PIC].name, 
                                       map[DOLL_LEFT_LEG_PIC].depth));
            group.add(new CFlxMySprite(DOLL_RIGHT_LEG_PIC, map[DOLL_RIGHT_LEG_PIC].name, 
                                       map[DOLL_RIGHT_LEG_PIC].depth));
                                       
                                       
            group.add(new CFlxMySprite(DOLL_WRONG_HAIR_PIC, map[DOLL_WRONG_HAIR_PIC].name, 
                                       map[DOLL_WRONG_HAIR_PIC].depth));
            //group.add(new CFlxMySprite(DOLL_WRONG_EMO_PIC, map[DOLL_WRONG_EMO_PIC].name, 
                                       //map[DOLL_WRONG_EMO_PIC].depth));
            group.add(new CFlxMySprite(DOLL_SPIDER_LEFT_LEG_PIC, map[DOLL_SPIDER_LEFT_LEG_PIC].name, 
                                       map[DOLL_SPIDER_LEFT_LEG_PIC].depth));
            group.add(new CFlxMySprite(DOLL_SPIDER_RIGHT_LEG_PIC, map[DOLL_SPIDER_RIGHT_LEG_PIC].name, 
                                       map[DOLL_SPIDER_RIGHT_LEG_PIC].depth));
            group.add(new CFlxMySprite(CUBE_PIC, map[CUBE_PIC].name, 
                                       map[CUBE_PIC].depth));
            m_gPuzzleObjects.add(group);
            
            this.add(m_gPuzzleObjects);
            
            m_sprPlayer = new CPlayer(60, 110);
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
                FlxG.switchState(new CStage5());
            });
        }
    }
}