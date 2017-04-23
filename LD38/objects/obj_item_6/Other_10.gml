/// @description Insert description here
event_inherited();

//instance_activate_object(self);
//instance_change(obj_item_battery_down, false);
//instance_create_depth(x, y, depth, obj_item_battery_down);
instance_create_layer(x - 5, y + 5, obj_player.layer, obj_item_battery_down);


//turn off light
var light = instance_nearest(x, y, obj_obstacle_3_on);
if (light != noone)
{
	with (light)
	{
		instance_change(obj_obstacle_3_off, false);
	}
}