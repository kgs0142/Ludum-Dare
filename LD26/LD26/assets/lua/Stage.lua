local CFlxMyGroup = as3.class.com.game.CFlxMyGroup;
local CFlxMySprite = as3.class.com.game.CFlxMySprite;
local CBaseStageState = as3.class.com.game.state.CBaseStageState
local FlxG = as3.class.org.flixel.FlxG;

local MOUSE_LEFT = "left";
local MOUSE_RIGHT = "right";
local MOUSE_MIDDLE = "middle";

function Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse)
	local bResult = false;
	--if (sClickMouse == MOUSE_LEFT and 
	--	as3.tolua(this.EqualPuzzleBox(secondItem)) == true) then
	--	bResult = false;
	if (sClickMouse == MOUSE_LEFT) then
		bResult = as3.tolua(CFlxMyGroup.SubstractTwoGroup(firstItem, secondItem));
	elseif (sClickMouse == MOUSE_RIGHT) then
		bResult = as3.tolua(CFlxMyGroup.AdditionTwoGroup(firstItem, secondItem));
	end
	 

	--switch the items
	--if (bResult == false) then
	--	this.SetPlayerSelectItem(secondItem);
	--	firstItem.InitialPosition();
	--end
end

function Lua_Stage1_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)
	if (bCanTakeIt == false) then
		return;
	end

	Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse)
end

function Lua_Stage1_ClickTheDoor(firstItem, secondItem, bCanTakeIt, sClickMouse)
	if (bCanTakeIt == true) then
		return;
	end


	if (firstItem == nil or 
	 	as3.tolua(firstItem.HasOnlyTheseChild("key")) == false) then
		return;
	end

	if (secondItem == nil or 
		as3.tolua(secondItem.HasOnlyTheseChild("door_handle", "door_board")) == false) then
		return;
	end	

	print("PASS!");
	this.SetStageClear(true);
end

---------------------------------------------------------------------------------------
function Lua_Stage2_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)
	if (bCanTakeIt == false) then
		return;
	end

	Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse)
end

function Lua_Stage2_ClickTheDoor(firstItem, secondItem, bCanTakeIt, sClickMouse)
	if (bCanTakeIt == true) then
		return;
	end

	if (firstItem == nil or 
	 	as3.tolua(firstItem.HasOnlyTheseChild("clock_board", 
	 										  "tweleve_fifteen")) == false) then
		return;
	end

	if (secondItem == nil or 
		as3.tolua(secondItem.HasOnlyTheseChild("door_handle", "door_board", 
											   "door_clock")) == false) then
		return;
	end	

	print("PASS!");
	this.SetStageClear(true);
end

---------------------------------------------------------------------------------------
function Lua_Stage3_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)
	--combine on the door
	Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse)
end

function Lua_Stage3_ClickTheDoor(firstItem, secondItem, bCanTakeIt, sClickMouse)
	
	if (firstItem == nil or 
	 	as3.tolua(firstItem.HasOnlyTheseChild("door_handle", 
	 										  "door_board")) == false) then
		return;
	end

	if (secondItem == nil or 
		as3.tolua(secondItem.HasOnlyTheseChild("door_board_dotted_line_pic")) == false) then
		return;
	end	

	print("PASS!");
	this.SetStageClear(true);
end

---------------------------------------------------------------------------------------
function Lua_Stage4_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)
	--combine on the door
	Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse)
end

function Lua_Stage4_ClickTheDoor(firstItem, secondItem, bCanTakeIt, sClickMouse)
	
	if (firstItem == nil or 
		as3.tolua(firstItem.HasOnlyTheseChild("doll_right_emo", "doll_head",
		"doll_right_hair", "doll_body", "doll_left_hand", "doll_right_hand", 
		"doll_left_leg", "doll_right_leg")) == false) then
		return;
	end	

	if (secondItem == nil or 
	 	as3.tolua(secondItem.HasOnlyTheseChild("door_handle", 
	 										   "door_board")) == false) then
		return;
	end

	print("PASS!");
	this.SetStageClear(true);
end

local bStageLock1 = false
local bStageLock2 = false
function Lua_Stage5_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)
	--combine on the door
	Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse);

	--拼出破碎的心後
	if (bStageLock1 == false and
		as3.tolua(firstItem.HasOnlyTheseChild("heart_container", "heart_piece_1",
		"heart_piece_2", "heart_Piece_3", "heart_piece_4")) == true) then
		
		bStageLock1 = true;
		--Text.Lua
		Stage5_Text1();
	--把破碎的心清空
	elseif (bStageLock1 == true and bStageLock2 == false and
			as3.tolua(firstItem.HasOnlyTheseChild("heart_container")) == true) then
		
		bStageLock2 = true;
		--Text.Lua
		Stage5_Text3();
	end	
end

function Lua_Stage5_ClickTheDoor(firstItem, secondItem, bCanTakeIt, sClickMouse)
	
	--特殊條件：四個碎片都集到之後，必須跳出說明文字

	--特殊條件：必須把現場所有愛心清掉，只剩Container才能離開
	
	if (bStageLock1 ~= true or bStageLock2 ~= true) then
		return;
	end

	print("PASS!");
	this.SetStageClear(true);
end

--POST COMPO
----------------------------------------------------------------------------------------
local bStage6Lock1 = false
function Lua_Stage6_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)
	--combine on the door
	Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse)

	if (bStage6Lock1 == false and
		(as3.tolua(firstItem.HasOnlyTheseChild("key")) == true or
		 as3.tolua(secondItem.HasOnlyTheseChild("key"))) == true) then
		bStage6Lock1 = true;
		Stage6_Text2();
	end
end

function Lua_Stage6_ClickTheDoor(firstItem, secondItem, bCanTakeIt, sClickMouse)
	if (firstItem == nil or 
	 	as3.tolua(firstItem.HasOnlyTheseChild("key")) == false) then
		return;
	end

	if (secondItem == nil or 
		as3.tolua(secondItem.HasOnlyTheseChild("door_handle", "door_board")) == false) then
		return;
	end	

	print("PASS!");
	this.SetStageClear(true);
end

----------------------------------------------------------------------------------------
function Lua_Stage7_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)
	--combine on the door
	Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse)
end

function Lua_Stage7_ClickTheDoor(firstItem, secondItem, bCanTakeIt, sClickMouse)

	if ((firstItem ~= null and
		 as3.tolua(firstItem.HasOnlyTheseChild("key")) == true) and
		(secondItem ~= null and
		 as3.tolua(secondItem.HasOnlyTheseChild("door_handle", "door_board")) == true)) then
	
		print("PASS!");
		this.SetStageClear(true);
		return;
	end

	--else do the combine
	Lua_Stage7_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)

end

----------------------------------------------------------------------------------------

function Lua_Stage8_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)
	--combine on the door
	Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse)
end

function Lua_Stage8_ClickTheDoor(firstItem, secondItem, bCanTakeIt, sClickMouse)

	if (firstItem == nil or 
	 	as3.tolua(firstItem.HasOnlyTheseChild("clock_board", "ten_thirty")) == false) then
		return;
	end

	if (secondItem == nil or 
		as3.tolua(secondItem.HasOnlyTheseChild("door_handle", "door_board", "door_clock")) == false) then
		return;
	end	

	print("PASS!");
	this.SetStageClear(true);

end

----------------------------------------------------------------------------------------

function Lua_Stage9_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)
	--combine on the door
	Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse)
end

function Lua_Stage9_ClickTheDoor(firstItem, secondItem, bCanTakeIt, sClickMouse)

	if (firstItem == nil or 
	 	as3.tolua(firstItem.HasOnlyTheseChild("cat_head", "cat_body")) == false) then
		return;
	end

	if (secondItem == nil or 
		as3.tolua(secondItem.HasOnlyTheseChild("door_handle", "door_board", "door_clock")) == false) then
		return;
	end	

	print("PASS!");
	this.SetStageClear(true);

end

----------------------------------------------------------------------------------------

function Lua_Stage10_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)
	--combine on the door
	Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse)
end

function Lua_Stage10_ClickTheDoor(firstItem, secondItem, bCanTakeIt, sClickMouse)

	if (firstItem == nil or 
	 	as3.tolua(firstItem.HasOnlyTheseChild("door_handle")) == false) then
		return;
	end

	if (secondItem == nil or 
		as3.tolua(secondItem.HasOnlyTheseChild("door_board_dotted_line_pic", "door_board")) == false) then
		return;
	end	

	print("PASS!");
	this.SetStageClear(true);

end
----------------------------------------------------------------------------------------

function Lua_Stage11_CombineTwoItem(firstItem, secondItem, bCanTakeIt, sClickMouse)
	--combine on the door
	Lua_Common_CombineTwoItem(firstItem, secondItem, sClickMouse)
end

function Lua_Stage11_ClickTheDoor(firstItem, secondItem, bCanTakeIt, sClickMouse)

	if (firstItem == nil or 
	 	as3.tolua(firstItem.HasOnlyTheseChild("door_board", "door_handle")) == false) then
		return;
	end

	if (secondItem == nil or 
		as3.tolua(secondItem.HasOnlyTheseChild("door_board_dotted_line_pic")) == false) then
		return;
	end	

	print("PASS!");
	this.SetStageClear(true);

end