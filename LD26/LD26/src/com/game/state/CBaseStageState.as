package com.game.state 
{
    import com.ai.CPlayer;
    import com.brompton.component.system.BPLoader;
    import com.brompton.component.system.script.BPLuaManager;
    import com.brompton.entity.BPEntityManager;
    import com.brompton.system.CEntitySystem;
    import com.game.CFlxMyGroup;
    import com.game.CUIManager;
    import com.greensock.TweenLite;
    import org.flixel.FlxBasic;
    import org.flixel.FlxButton;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxObject;
    import org.flixel.FlxPath;
    import org.flixel.FlxPoint;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxTileblock;
    import org.flixel.system.input.Mouse;
	
	/**
     * ...
     * @author Husky
     */
    public class CBaseStageState extends FlxState 
    {
        [Embed(source="../../../../assets/Player.png")]
        public static const PLAYER_PIC:Class;
        [Embed(source="../../../../assets/Cube.png")]
        protected const CUBE_PIC:Class;
        [Embed(source="../../../../assets/door/Door_Board_Dotted_Line.png")]
        protected const DOOR_BOARD_DOTTED_LINE_PIC:Class;
        [Embed(source="../../../../assets/door/DoorBoard.png")]
        protected const DOOR_BOARD_PIC:Class;
        [Embed(source="../../../../assets/door/DoorHandle.png")]
        protected const DOOR_HANDLE_PIC:Class;
        [Embed(source="../../../../assets/door/DoorHandleHole.png")]
        protected const DOOR_HANDLE_HOLE_PIC:Class;
        [Embed(source="../../../../assets/Key.png")]
        protected const KEY_PIC:Class;
        
        [Embed(source="../../../../assets/clock/Clock_Board.png")]
        protected const CLOCK_BOARD_PIC:Class;
        [Embed(source="../../../../assets/clock/Clock_Cover.png")]
        protected const CLOCK_COVER_PIC:Class;
        [Embed(source="../../../../assets/clock/Door_Clock.png")]
        protected const DOOR_CLOCK_PIC:Class;
        [Embed(source="../../../../assets/clock/TweleveFifteen.png")]
        protected const TWELVE_FIFTEEN_PIC:Class;
        [Embed(source="../../../../assets/clock/WrongNeedle1.png")]
        protected const WRONG_NEEDLE_1_PIC:Class;
        [Embed(source="../../../../assets/clock/WrongNeedle2.png")]
        protected const WRONG_NEEDLE_2_PIC:Class;
        [Embed(source="../../../../assets/clock/WrongNeedle3.png")]
        protected const WRONG_NEEDLE_3_PIC:Class;
        
        [Embed(source="../../../../assets/Cat2.png")]
        protected const CAT_PIC:Class;
        [Embed(source="../../../../assets/CatBody.png")]
        protected const CAT_BODY:Class;
        [Embed(source="../../../../assets/Driller.png")]
        protected const DRILL_PIC:Class;
        [Embed(source="../../../../assets/Flower.png")]
        protected const FLOWER_PIC:Class;
        [Embed(source="../../../../assets/Rhizome.png")]
        protected const RHIZOME_PIC:Class;
        [Embed(source="../../../../assets/WindMill_Head.png")]
        protected const WINDMILL_HEAD_PIC:Class;
        [Embed(source="../../../../assets/UmbrellaPart.png")]
        protected const UMBRELLA_PART:Class;
        
        [Embed(source="../../../../assets/doll/Head.png")]
        protected const DOLL_HEAD_PIC:Class;
        [Embed(source="../../../../assets/doll/Body.png")]
        protected const DOLL_BODY_PIC:Class;
        [Embed(source="../../../../assets/doll/Left_Hand.png")]
        protected const DOLL_LEFT_HAND_PIC:Class;
        [Embed(source="../../../../assets/doll/Left_Leg.png")]
        protected const DOLL_LEFT_LEG_PIC:Class;
        [Embed(source="../../../../assets/doll/right_emotion.png")]
        protected const DOLL_RIGHT_EMO_PIC:Class;
        [Embed(source="../../../../assets/doll/Right_Hair.png")]
        protected const DOLL_RIGHT_HAIR_PIC:Class;
        [Embed(source="../../../../assets/doll/Right_Hand.png")]
        protected const DOLL_RIGHT_HAND_PIC:Class;
        [Embed(source="../../../../assets/doll/Right_Leg.png")]
        protected const DOLL_RIGHT_LEG_PIC:Class;
        [Embed(source="../../../../assets/doll/Spider_Left_Leg.png")]
        protected const DOLL_SPIDER_LEFT_LEG_PIC:Class;
        [Embed(source="../../../../assets/doll/Spider_Right_Leg.png")]
        protected const DOLL_SPIDER_RIGHT_LEG_PIC:Class;
        [Embed(source="../../../../assets/doll/wrong_emotion.png")]
        protected const DOLL_WRONG_EMO_PIC:Class;
        [Embed(source="../../../../assets/doll/Wrong_hair.png")]
        protected const DOLL_WRONG_HAIR_PIC:Class;
        
        [Embed(source="../../../../assets/heart/Heart_Container.png")]
        protected const HEART_CONTAINER:Class;
        [Embed(source="../../../../assets/heart/Heart_Piece1.png")]
        protected const HEART_PIECE_1:Class;
        [Embed(source="../../../../assets/heart/Heart_Piece2.png")]
        protected const HEART_PIECE_2:Class;
        [Embed(source="../../../../assets/heart/Heart_Piece3.png")]
        protected const HEART_PIECE_3:Class;
        [Embed(source="../../../../assets/heart/Heart_Piece4.png")]
        protected const HEART_PIECE_4:Class;
        
        [Embed(source="../../../../assets/Window1.png")]
        protected const WINDOW_MENU:Class;
        [Embed(source="../../../../assets/Window2.png")]
        protected const WINDOW_END:Class;
        
        [Embed(source="../../../../assets/UI/LeftMouseTip.png")]
        protected const LEFT_MOUSE_TIP_PIC:Class;
        [Embed(source="../../../../assets/UI/MiddleMouseTip.png")]
        protected const MIDDLE_MOUSE_TIP_PIC:Class;
        [Embed(source="../../../../assets/UI/RightMouseTip.png")]
        protected const RIGHT_MOUSE_TIP_PIC:Class;
        
        [Embed(source="../../../../assets/Prisoner.png")]
        protected const PRISONER_PIC:Class;

        [Embed(source="../../../../assets/Bed.png")]
        protected const BED_PIC:Class;
        
        [Embed(source="../../../../assets/DogHead.png")]
        protected const DOG_HEAD:Class;
        [Embed(source="../../../../assets/DogBody.png")]
        protected const DOG_BODY:Class;
        
        [Embed(source="../../../../assets/Door_Hint_1030.png")]
        protected const DOOR_HINT_1030_PIC:Class;
        [Embed(source="../../../../assets/Door_Hint_Cat.png")]
        protected const DOOR_HINT_CAT_PIC:Class;
        
        [Embed(source="../../../../assets/AlienComplete.png")]
        protected const ALIEN_COMPLETE_PIC:Class;
        [Embed(source="../../../../assets/AlienPart.png")]
        protected const ALIEN_PART_PIC:Class;
        [Embed(source="../../../../assets/SpiderHead.png")]
        protected const SPIDER_HEAD_PIC:Class;
        
        
        protected var m_sStageName:String;
        
        protected var m_bPlayerIsMoving:Boolean;
        
        protected var m_sprPlayer:CPlayer;
        
        protected var m_gWallAndFloor:FlxGroup;
        
        protected var m_cLuaMgr:BPLuaManager;
        
        //----------------------------------------------
        //Left(Subtract) or Right(Add)
        protected var m_sClickMouse:String;
        //CFlxMyGroup player select current
        protected var m_gPlayerSelectItem:CFlxMyGroup;
        //Player is taking m_gPlayerSelectItem, and select the 2nd item to combined.
        protected var m_gPlayerSelectCombineItem:CFlxMyGroup;
        //The main puzzle group
        protected var m_gPuzzleBox:CFlxMyGroup;
        //CFlxMyGroup Mouse click current
        protected var m_gMouseClickItem:CFlxMyGroup;
        
        protected var m_gMouseOverItem:CFlxMyGroup;
        
        protected var m_gPuzzleObjects:FlxGroup;
        
        private var m_bStageClear:Boolean;
        
        private var m_bStopUpdate:Boolean;
        
        public function CBaseStageState() { }
        
        override public function create():void 
        {
            super.create();

            m_sStageName "";
            m_sClickMouse = "";
            m_gPuzzleBox = null;
            m_bStopUpdate = false;
            m_bStageClear = false;
            m_gMouseOverItem = null;
            m_bPlayerIsMoving = false;
            m_gPlayerSelectItem = null;
            m_gMouseClickItem = null;
            m_gPlayerSelectCombineItem = null;
            
            m_gPuzzleObjects = new FlxGroup();
            
            m_cLuaMgr = CEntitySystem.Get().GetComponent(BPLuaManager) as BPLuaManager;
            m_cLuaMgr.SetGlobal("this", this);
            
            //Create Wall and floor(All stages are same)
            m_gWallAndFloor = new FlxGroup();
            m_gWallAndFloor.add(new FlxTileblock(-10, 0, 10, FlxG.height));
            m_gWallAndFloor.add(new FlxTileblock(FlxG.width, 0, 10 , FlxG.height));
            m_gWallAndFloor.add(new FlxTileblock(0, FlxG.height - 5, FlxG.width, 10));
            this.add(m_gWallAndFloor);
            
            //Clear mouse over
            CUIManager.Get().RemoveMouseOverEffect();
            
            CONFIG::debug
            {
                this.add(new FlxButton(0, 0, "Reload Lua",function () : void
                {
                    var loader:BPLoader = CEntitySystem.Get().GetComponent(BPLoader) as BPLoader;

                    var fnComplete:Function = function () : void
                    {
                        var sScript:String = loader.GetAsset("Stage") as String;
                        m_cLuaMgr.DoString(sScript);
                        
                        sScript = loader.GetAsset("Text") as String;
                        m_cLuaMgr.DoString(sScript);
                        
                        FlxG.resetState();
                    };
                    
                    loader.PushAssetToLoad("assets/lua/Stage.lua");
                    loader.PushAssetToLoad("assets/lua/Text.lua");
                    
                    loader.StartLoad(fnComplete);
                }));
            }
        }
        
        //
        //protected function InitialAllMyFlxGroupPosition() : void
        //{
            //
        //}
        
        override public function update():void 
        {
            super.update();
            
            if (FlxG.keys.justPressed("R") == true)
            {
                FlxG.resetState();
            }
            
            //Collide-------------------------------------------------------
            FlxG.collide(m_sprPlayer, m_gWallAndFloor);
            
            if (this.m_bStopUpdate == true)
            {
                return;
            }
            
            if (this.m_gPlayerSelectItem != null &&
                this.m_gPlayerSelectItem.members.length == 0)
            {
                this.m_gPlayerSelectItem = null;
            }
            
            BPEntityManager.Get().Update();
            
            //check player is on the path point now
            m_bPlayerIsMoving = true;
            if (m_sprPlayer.path == null ||
               (m_sprPlayer.path.nodes[0].x >= m_sprPlayer.x &&
                m_sprPlayer.path.nodes[0].x <= m_sprPlayer.x + m_sprPlayer.width))
            {
                m_bPlayerIsMoving = false;
                
                //Clear the mouseover item?
                CUIManager.Get().RemoveMouseOverEffect();
                
                //If Player is overlap group(item) and cannot take it, executing callback
                //IT CAN ONLY BE THE DOOR
                var sFnName:String;
                var fnLuaCallGabal:Function = m_cLuaMgr.cLuaAlchemy.callGlobal;
                if (FlxG.overlap(m_sprPlayer, m_gMouseClickItem) == true &&
                    m_gMouseClickItem.bCanTakeIt == false)
                {
                    sFnName = "Lua_" + this.m_sStageName + "_ClickTheDoor";
                    fnLuaCallGabal(sFnName, m_gPlayerSelectItem, m_gMouseClickItem, 
                                   m_gMouseClickItem.bCanTakeIt, m_sClickMouse);
                    if (m_bStageClear == true)
                    {
                        FlxG.play(SndDoorOpen);

                        //Pass, gotoNext State
                        this.GoToNextState();
                    }
                }
                //If Player is overlap group(item) and can take it, take it
                else if (FlxG.overlap(m_sprPlayer, m_gMouseClickItem) == true &&
                    m_gMouseClickItem.bCanTakeIt == true &&
                    m_gPlayerSelectItem == null)
                {
                    //Play Taking item snd
                    FlxG.play(SndPickUp);
                    
                    m_gPlayerSelectItem = m_gMouseClickItem;
                }
                //Take the 2nd item => combine them
                else if (FlxG.overlap(m_sprPlayer, m_gMouseClickItem) == true &&
                         m_gPlayerSelectItem != null &&
                         m_gPlayerSelectCombineItem == null &&
                         m_gPlayerSelectItem != m_gMouseClickItem)
                {
                    //If click the middle_Mouse, switch the two Item
                    if (m_sClickMouse == Mouse.MIDDLE)
                    {
                        //Play Taking item snd
                        FlxG.play(SndPickUp);
                    
                        m_gPlayerSelectItem.InitialPosition();
                        this.SetPlayerSelectItem(m_gMouseClickItem);
                    }
                    //Lua script?
                    else
                    {
                        sFnName = "Lua_" + this.m_sStageName + "_CombineTwoItem";
                        fnLuaCallGabal(sFnName, m_gPlayerSelectItem, m_gMouseClickItem, 
                                       m_gMouseClickItem.bCanTakeIt, m_sClickMouse);
                    }
                }
                
                //Set = null
                m_sClickMouse = "";
                m_gMouseClickItem = null;
            }
            
            //The 1st puzzle item player taking, moving witj player
            if (m_gPlayerSelectItem != null)
            {
                m_gPlayerSelectItem.x = m_sprPlayer.x;
                m_gPlayerSelectItem.y = m_sprPlayer.y - m_gPlayerSelectItem.height -
                                        m_sprPlayer.health - 2;
            }
            
            
            //-------------------------------------------------------------------
            //If is Moving, don't do Move event
            if (m_bPlayerIsMoving == true)
            {
                //Clear the mouseover item?
                CUIManager.Get().RemoveMouseOverEffect();
                
                return;
            }
            
            if ((FlxG.mouse.justPressed(Mouse.LEFT) || 
                 FlxG.mouse.justPressed(Mouse.RIGHT) ||
                 FlxG.mouse.justPressed(Mouse.MIDDLE) ||
                 FlxG.keys.justPressed("Z")))
            {
                CUIManager.Get().RemoveMouseOverEffect();
                
                //Move to Object
                var pClick:FlxPoint = new FlxPoint(FlxG.mouse.x, FlxG.height);
                var path:FlxPath = new FlxPath([pClick]);
                m_sprPlayer.followPath(path);
                
                m_bPlayerIsMoving = true;
                
                //Mouse select item
                m_gMouseClickItem = null;
                for each (var flxMyGroup:CFlxMyGroup in m_gPuzzleObjects.members)
                {
                    if (this.IsUnderMouse(flxMyGroup) == false)
                    {
                        continue;
                    }
                    
                    m_gMouseClickItem = flxMyGroup;
                    
                    if (FlxG.mouse.justPressed(Mouse.LEFT))
                    {
                        m_sClickMouse = Mouse.LEFT;
                    }
                    else if (FlxG.mouse.justPressed(Mouse.RIGHT))
                    {
                        m_sClickMouse = Mouse.RIGHT;
                    }
                    else if ((FlxG.mouse.justPressed(Mouse.MIDDLE) ||
                              FlxG.keys.justPressed("Z")))
                    {
                        m_sClickMouse = Mouse.MIDDLE;
                    }
                    //
                    //m_sClickMouse = (FlxG.mouse.justPressed(Mouse.LEFT)) ?
                                     //Mouse.LEFT : Mouse.RIGHT;
                    //m_sClickMouse = (FlxG.mouse.justPressed(Mouse.MIDDLE)) ?
                                     //Mouse.MIDDLE : m_sClickMouse;
                    break;
                }
            }
            
            //Can Click hint
            for each (var flxBasic:FlxBasic in m_gPuzzleObjects.members)
            {
                if (flxBasic == m_gPlayerSelectItem)
                {
                    continue;
                }
                
                if (this.IsUnderMouse(flxBasic) == false)
                {
                    continue;
                }
                
                var gMyGroup:CFlxMyGroup = flxBasic as CFlxMyGroup;
                if (gMyGroup == null || gMyGroup.members.length == 0)
                {
                    continue;
                }
                
                gMyGroup.DoMouseOverEffect();
                //gMyGroup.flicker(0.05);
            }
        }
        
        //protected function IsUnderMouse(flxBasic:FlxBasic) : Boolean
        protected function IsUnderMouse(obj:Object) : Boolean
        {
            if ((FlxG.mouse.x >= obj["x"] + obj["offset"]["x"] &&
                 FlxG.mouse.x <= obj["x"] + obj["offset"]["x"] + obj["width"]) &&
               ((FlxG.mouse.y >= obj["y"] + obj["offset"]["y"] &&
                 FlxG.mouse.y <= obj["y"] + obj["offset"]["y"] + obj["height"])))
            {
                return true;
            }
            
            return false;
        }
        
        protected function GoToNextState() : void
        {
            throw "Need override";
        }
        
        public function SetPlayerSelectItem(value:CFlxMyGroup):void 
        { 
            m_gPlayerSelectItem = value; 
        }
        
        public function EqualPuzzleBox(group:CFlxMyGroup):Boolean 
        { 
            return m_gPuzzleBox == group; 
        }
        
        public function SetStopUpdate(value:Boolean):void 
        {
            m_bStopUpdate = value;
        }
        
        public function SetStageClear(bClear:Boolean) : void
        {
            m_bStageClear = bClear;
        }
        
        //Add UI Tip
        public function AddLeftMouseUITip(nx:Number, nY:Number, nFadeInTime:Number = 0.0) : void
        {
            var spr:FlxSprite = new FlxSprite(nx, nY, LEFT_MOUSE_TIP_PIC);
            spr.alpha = 0.0;
            TweenLite.to(spr, nFadeInTime,
            {
                alpha: 1.0
            });
            
            this.add(spr);
        }
        
        public function AddRightMouseUITip(nx:Number, nY:Number, nFadeInTime:Number = 0.0) : void
        {
            var spr:FlxSprite = new FlxSprite(nx, nY, RIGHT_MOUSE_TIP_PIC)
            spr.alpha = 0.0;
            TweenLite.to(spr, nFadeInTime,
            {
                alpha: 1.0
            });
            this.add(spr);
        }
        
        public function AddMiddleMouseUITip(nx:Number, nY:Number, nFadeInTime:Number = 0.0) : void
        {
            var spr:FlxSprite = new FlxSprite(nx, nY, MIDDLE_MOUSE_TIP_PIC)
            spr.alpha = 0.0;
            TweenLite.to(spr, nFadeInTime,
            {
                alpha: 1.0
            });
            this.add(spr);
        }
        
        public function GroupHasChild(sChildName:String) : Boolean
        {
            for each (var group:CFlxMyGroup in this.members)
            {
                if (group == null)
                {
                    continue;
                }
                
                if (group.HasTheChild(sChildName) == false)
                {
                    continue;
                }
                
                return true;
            }
            
            return false;
        }
    }
}
