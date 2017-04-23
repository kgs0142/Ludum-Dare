/// @description DIE

if (_invincible == true)
{
	exit;
}

if (obj_game_manager._isGameClear == true)
{
	exit;
}

if (sprite_index == spr_player_dodge)
{
	exit;
}

audio_play_sound(snd_player_die, 10, false);
audio_stop_sound(snd_vibrant_prose);

_isAlive = false;

sprite_index = spr_player_die;

alarm_set(0, 60);


