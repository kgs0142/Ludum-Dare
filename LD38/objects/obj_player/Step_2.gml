/// @description World border
if (y >= room_height ||
	place_meeting(x, y, obj_invisible_world_mask) == true)
{
	x = xprevious;
	y = yprevious;
	hspeed = 0;
	vspeed = 0;
}

if (_isInWater == true)
{
	if (sprite_index != spr_player_die && sprite_index != spr_player_dodge)
	{
		sprite_index = spr_player_in_water;
	}
}
else
{
	if (sprite_index != spr_player_die && sprite_index != spr_player_dodge)
	{
		sprite_index = spr_player_idle;
	}
}