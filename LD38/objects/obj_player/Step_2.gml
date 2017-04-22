/// @description World border
if (y >= room_height ||
	place_meeting(x, y, obj_invisible_world_mask) == true)
{
	x = xprevious;
	y = yprevious;
	hspeed = 0;
	vspeed = 0;
}