/// @description Insert description here

friction = 0.75;

//Input for moving.
if (_dodging == false)
{
	if (keyboard_check(vk_left) == true)
	{
		image_xscale = -1;
		hspeed = -2;
	}
	else if (keyboard_check(vk_right) == true)
	{
		image_xscale = 1;
		hspeed = 2;
	}

	if (keyboard_check(vk_up) == true)
	{
		vspeed = -2;
	}
	else if (keyboard_check(vk_down) == true)
	{
		vspeed = 2;
	}	
}

//dodging
if (_dodging == true)
{
	if (hspeed == 0)
	{
		_dodging = false;
		sprite_index = spr_player_idle;
	}
}

if (_dodging == false && keyboard_check_pressed(ord("Z")) == true)
{
	_dodging = true;
	sprite_index = spr_player_dodge;
	hspeed = image_xscale * 7.5;
}
