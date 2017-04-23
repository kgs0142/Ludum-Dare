/// @description Insert description here
//Spawn left seagull

if (_enable == false)
{
	exit;
}

if (obj_game_manager._isGameClear == true)
{
	exit;
}

if (_leftSeagull != noone)
{
	alarm_set(0, random_range(_lowRndRange, _highRndRange));
	exit;
}

var xRnd = random_range(64, 160);
var yRnd = random_range(150, 160);

//_leftSeagull = instance_create_layer(xRnd, yRnd, obj_player.layer, obj_seagull)
_leftSeagull = instance_create_depth(xRnd, yRnd, obj_player.depth - 1, obj_seagull)

_leftSeagull.image_xscale = -1;
_leftSeagull.hspeed = 0.1;

alarm_set(0, random_range(_lowRndRange, _highRndRange));
