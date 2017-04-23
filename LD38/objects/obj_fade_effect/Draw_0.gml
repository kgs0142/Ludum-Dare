/// @description Fade

_fadeAlpha = clamp(_fadeAlpha + (_fadeState*_fadeSpeed), 0.0, 1.0);
if (_fadeAlpha >= 1)
{
	_fadeState = -1;

	//audio_stop_sound(snd_enviable_space);

	room_goto_next();
}

if (_fadeAlpha <= 0 && _fadeState == -1)
{
	audio_stop_sound(snd_enviable_space);

	instance_destroy();
}

draw_set_color(c_black);
draw_set_alpha(_fadeAlpha);
draw_rectangle(camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]),
camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]),
camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]), 0);
draw_set_alpha(1);
