/// @description Insert description here

var RAISING_DURATION = 0.5*1000*1000;
var FALLING_DURATION = 0.5*1000*1000;
var MOVING_DURATION = 0.2*1000*1000;
var RETURN_DURATION = 2.0*1000*1000;
var ATTACK_DURATION = 1.5*1000*1000;

var NEXT_RAISING_DELAY = 0.5*1000*1000;

var noPossibleTarget = true;
var noMovingTarget = true;

with (obj_char)
{
	if (place_meeting(x, y, obj_right_aiming_mask) == false)
	{
		break;
	}
	
	noPossibleTarget = false;

	if (other._fallingDuration > 0)
	{
		break;
	}
	
	other._nextRaisingDelay -= delta_time;
	if (other._nextRaisingDelay > 0)
	{
		//break;
		//exit, don't do anything.
		exit;
	}
	
	var shadow = other._pawShadow;

	if (hspeed != 0 || vspeed != 0)
	{
		noMovingTarget = false;
		
		if (other._raising == false)
		{
			other._raising = true;
			other._raisingDuration = RAISING_DURATION;
		}
	
		if (distance_to_object(other) <= 5)
		{
			other._attackingDuration += delta_time;
			if (other._attackingDuration >= ATTACK_DURATION)
			{
				other._movingDuration = 0;
				other._attackingDuration = 0;
				other._fallingDuration = 0.0001;
			}
		}
	
		other._movingDuration = MOVING_DURATION;
		other._target = self;
		break;
	}
	//else if (other._movingDuration <= 0 && other._raising == true)
	//{
	//	shadow.speed = 0;
	//	other.x = shadow.x;
	//	other.y = shadow.y;
	//}
}

if (noPossibleTarget == true)
{
	_pawShadow.speed = 0;
	other.x = _pawShadow.x;
	other.y = _pawShadow.y;
}
else if (_movingDuration <= 0 && _raising == true)
{
	_raising = false;
	_pawShadow.speed = 0;
	_attackingDuration = 0;
	_fallingDuration = FALLING_DURATION;
}
else if (noMovingTarget == true)
{
	_returnDuration -= delta_time;

	if (_returnDuration < 0)
	{
		if (point_distance(_pawShadow.x, _pawShadow.y, _originalX, _originalY) > 10)
		{
			_pawShadow.speed = other._movingSpeed/2;
			_pawShadow.direction = point_direction(_pawShadow.x, _pawShadow.y, _originalX, _originalY);
		}
		else
		{
			_pawShadow.speed = 0;
		}
	
		x = _pawShadow.x;
		y = _pawShadow.y;
	}
}

//Raising paw
var raisingRatio = 1.0;
if (_raiseDuration > 0)
{
	_raisingDuration -= delta_time;
	
	var value = (_raisingDuration < 0) ? 0 : _raisingDuration;
	raisingRatio = (RAISING_DURATION - value)/RAISING_DURATION;
}

//Moving Paw
if (_movingDuration > 0)
{
	_movingDuration -= delta_time;
	if (point_distance(_pawShadow.x, _pawShadow.y, _target.x, _target.y) > 1)
	{
		_pawShadow.speed = other._movingSpeed;
		_pawShadow.direction = point_direction(_pawShadow.x, _pawShadow.y, _target.x, _target.y);
	}
	
	other.x = _pawShadow.x;
	other.y = _pawShadow.y - (raisingRatio*other._raiseHeight);
}

//Falling
if (_fallingDuration > 0)
{
	_fallingDuration -= delta_time;
	
	//HIT!
	if (_fallingDuration <= 0)
	{
		_pawShadow.speed = 0;
		other.x = _pawShadow.x;
		other.y = _pawShadow.y;
		
		_returnDuration = RETURN_DURATION;
		_nextRaisingDelay = NEXT_RAISING_DELAY;
		
		//Create a hitbox here.
	}
}