/// @description Insert description here
event_inherited();

//instance_activate_object(self);
//instance_change(obj_item_battery_left, false);
//instance_create_depth(x, y, depth, obj_item_battery_left);
instance_create_layer(x, y, obj_player.layer, obj_item_battery_left);
