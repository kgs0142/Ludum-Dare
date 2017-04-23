/// @description Insert description here

if (object_get_parent(other.object_index) == obj_water || 
	object_get_parent(other.object_index) == obj_cloud ||
	other.object_index == obj_seagull)
{
	exit;
}

x = xprevious;
y = yprevious;
hspeed = 0;
vspeed = 0;