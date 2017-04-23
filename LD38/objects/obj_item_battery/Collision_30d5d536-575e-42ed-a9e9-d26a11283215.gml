/// @description Insert description here

if (_enable == false)
{
	exit;
}

var player = other;
if (player._takingItem != noone)
{
	exit;
}

_following = player;

player._takingItem = self;

audio_play_sound(snd_get_battery, 10, false);
