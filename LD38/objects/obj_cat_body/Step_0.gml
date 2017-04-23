/// @description Insert description here

var isOnLeftSide = false;
var isOnRightSide = false;

with (obj_left_aiming_mask)
{
	if (place_meeting(x, y, obj_player) == true)	
	{
		isOnLeftSide = true;
	}
}

with (obj_right_aiming_mask)
{
	if (place_meeting(x, y, obj_player) == true)	
	{
		isOnRightSide = true;
	}
}

if (isOnLeftSide == true && isOnRightSide == true)
{
	sprite_index = spr_cat_body_center;
}
else if (isOnRightSide == true)
{
	sprite_index = spr_cat_body_right;
}
else
{
	sprite_index = spr_cat_body_left;
}