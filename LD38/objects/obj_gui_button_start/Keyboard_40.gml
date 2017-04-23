/// @description Insert description here

with (obj_gui_button_hint)
{
	if (self._name != "down")
	{
		continue;
	}
	
	if (self.image_index == 0)
	{
		self.image_index = 1;
		audio_play_sound(snd_battery_in, 10, false);
	}
}

var allTriggered = true;
with (obj_gui_button_hint)
{
	if (image_index != 1)
	{
		allTriggered = false;
	}
}

if (allTriggered == true)
{
	image_index = 1;
}
