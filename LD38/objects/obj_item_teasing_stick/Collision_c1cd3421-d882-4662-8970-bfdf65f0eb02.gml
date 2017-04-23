/// @description Insert description here

var player = other;

if (player._takingItem == noone)
{
	exit;
}

var battery = player._takingItem;

battery._enable = false;
battery._following = noone;
player._takingItem = noone;

audio_play_sound(snd_battery_in, 10, false);

switch (battery.object_index)
{
	case obj_item_battery_up:
		battery.x = x + 5;
		battery.y = y + 1;
		_gotBatteryUp = true;
		break;
		
	case obj_item_battery_left:
		battery.x = x + 15;
		battery.y = y + 1;
		_gotBatteryLeft = true;
		break;
		
	case obj_item_battery_down:
		battery.x = x + 25;
		battery.y = y + 2;
		_gotBatteryDown = true;
		break;
		
	case obj_item_battery_right:
		battery.x = x + 34;
		battery.y = y + 1;
		_gotBatteryRight = true;
		break;
		
	default:
		break;
}

if (_gotBatteryUp && _gotBatteryLeft && _gotBatteryDown && _gotBatteryRight)
{
	image_speed = 0.35;
	
	obj_game_manager._isGameClear = true;
	
	alarm_set(0, 180);
}