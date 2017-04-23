/// @description Insert description here
//Spawn right seagull

if (_enable == false)
{
	exit;
}

if (obj_game_manager._isGameClear == true)
{
	exit;
}

if (_rightSeagull != noone)
{
	alarm_set(1, random_range(_lowRndRange, _highRndRange));
	exit;
}

var xRnd = random_range(224, 320);
var yRnd = random_range(150, 160);

//_rightSeagull = instance_create_layer(xRnd, yRnd, obj_player.layer, obj_seagull)
_rightSeagull = instance_create_depth(xRnd, yRnd, obj_player.depth - 1, obj_seagull)

_rightSeagull.hspeed = -0.1;

alarm_set(1, random_range(_lowRndRange, _highRndRange));