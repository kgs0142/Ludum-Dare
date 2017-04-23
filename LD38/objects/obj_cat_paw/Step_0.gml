

exit


if (_isDoneMovingBackForTeasingStick == false)
{
	exit;
}

//only doing with left paw.
if (self.object_index == obj_cat_right_paw)
{
	exit;
}

if (_playingTeasingStickDuration > 0)
{
	_playingTeasingStickDuration -= delta_time;
	_pawShadow.speed = _movingSpeed*random_range(1.0, 2);
	_pawShadow.direction = 180;
	
	x = _pawShadow.x;
	y = _pawShadow.y - _raiseHeight;
	
	exit;
}

if (distance_to_point(210, 110) > 2)
{
	_pawShadow.speed = _movingSpeed;
	_pawShadow.direction = point_direction(_pawShadow.x, _pawShadow.y, 210, 110);
	
	x = _pawShadow.x;
	y = _pawShadow.y - _raiseHeight;
}
else
{
	_pawShadow.speed = 0;
	x = _pawShadow.x;
	y = _pawShadow.y - _raiseHeight;
	
	if (_playingTeasingStick == false) 
	{
		_playingTeasingStick = true;
		alarm_set(0, random_range(15, 90));
	}
}

