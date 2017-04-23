/// @description Insert description here

friction = 0.75;

if (obj_game_manager._isGameClear == true)
{
	exit;
}

if (_isAlive == false)
{
	exit;
}

_isInWater = false;
with (obj_water)
{
	if (place_meeting(x, y, other) == true)
	{
		other._isInWater = true;
	}
}

var baseMultiplier = (_isInWater == false) ? 1.0 : 0.75;

//Input for moving.
if (_dodging == false)
{
	if (keyboard_check(vk_left) == true)
	{
		image_xscale = -1;
		hspeed = -2*baseMultiplier;
	}
	else if (keyboard_check(vk_right) == true)
	{
		image_xscale = 1;
		hspeed = 2*baseMultiplier;
	}

	if (keyboard_check(vk_up) == true)
	{
		vspeed = -2*baseMultiplier;
	}
	else if (keyboard_check(vk_down) == true)
	{
		vspeed = 2*baseMultiplier;
	}	
}

//dodging
if (_dodging == true)
{
	if (_isInWater)
	{
		hspeed /= 10;
	}

	if (hspeed == 0)
	{
		_dodging = false;
		sprite_index = spr_player_idle;
	}
}

if (_isInWater == false && _dodging == false && 
	keyboard_check_pressed(ord("Z")) == true)
{
	_dodging = true;
	sprite_index = spr_player_dodge;
	hspeed = image_xscale * 7.5*baseMultiplier;
	audio_play_sound(snd_dodge, 10, false);
}
