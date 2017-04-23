/// @description Insert description here

if (_goToNextRoom == true)
{
	exit;
}

if (image_index == 1)
{
	_status = "none";
	//image_index = 0;

	//audio_play_sound(snd_battery_in, 10, false);

	//room_goto_next();
	
	audio_play_sound(snd_battery_in, 10, false);

	_goToNextRoom = true;
	
	//Wait for the performance is done.
	//var fadeEffect = instance_create_depth(x, y, layer, obj_fade_effect);
}