/// @description Insert description here

if (_enable == false)
{
	exit;
}

_enable = false;

image_speed = 0;
image_index = image_number - 1;

alarm_set(0, _goToNextRoomDelayFrames);
