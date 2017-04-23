/// @description Insert description here
event_inherited();

//instance_activate_object(self);
//instance_change(obj_item_battery_up, false);
//instance_create_depth(x, y, depth, obj_item_battery_up);
instance_create_layer(x, y, obj_player.layer, obj_item_battery_up);

//turn off light
var light = instance_nearest(x, y, obj_environment_4_on);
if (light != noone)
{
	with (light)
	{
		instance_change(obj_environment_4_off, false);
	}
}