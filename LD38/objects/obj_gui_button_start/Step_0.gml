/// @description Fade all gui

if (_goToNextRoom == false)
{
	exit;
}

_fadeAlpha = clamp(_fadeAlpha + (_fadeState*_fadeSpeed), 0.0, 1.0);
if (_fadeAlpha <= 0)
{
	room_goto_next();
}

with (obj_gui)
{
	image_alpha = other._fadeAlpha;
}
