/// @description Insert description here

if (_showWords == false)
{
	exit;
}

_fadeAlpha = clamp(_fadeAlpha + (_fadeState*_fadeSpeed), 0.0, 1.0);
if (_fadeAlpha >= 1)
{
	//room_goto_next();
}

image_alpha = _fadeAlpha;

