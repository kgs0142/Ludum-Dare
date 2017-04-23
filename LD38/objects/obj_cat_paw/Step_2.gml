/// @description DON'T LOOK AT ME

var RAISING_DURATION = 0.5*1000*1000;
var FALLING_DURATION = 0.5*1000*1000;
var MOVING_DURATION = 0.2*1000*1000;
var RETURN_DURATION = 2.0*1000*1000;
var ATTACK_DURATION = 1.5*1000*1000;

var NEXT_RAISING_DELAY = 0.5*1000*1000;
var DO_FALLING_DURATION = 0.1*1000*1000;

var noPossibleTarget = true;
var noMovingTarget = true;

if(_isDoneMovingBackForTeasingStick == true)
{
	return;
}

if (obj_game_manager._isGameClear == true)
{
	//returning first, then playing the teasing stick
	
	//returning
	if (point_distance(_pawShadow.x, _pawShadow.y, _originalX, _originalY) > 5)
	{
		_pawShadow.speed = _movingSpeed/2;
		_pawShadow.direction = point_direction(_pawShadow.x, _pawShadow.y, _originalX, _originalY);
	}
	else
	{
		_pawShadow.speed = 0;

		_isDoneMovingBackForTeasingStick = true;

		event_perform_object(obj_gui_thanks, ev_other, ev_user0);
	}
	
	x = _pawShadow.x;
	y = _pawShadow.y;
	
	exit;
}

with (obj_char)
{
	if (self._isAlive == false)
	{
		continue;
	}

	if (self.visible == false)
	{
		continue;
	}

	//if (place_meeting(x, y, other._aimingMask) == false)
	if (place_meeting(x, y, other._aimingMask) == false)
	{
		continue;
	}
	
	noPossibleTarget = false;

	if (other._fallingDuration > 0)
	{
		break;
	}
	
	if (other._doFallingDuration > 0)
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
	
		if (distance_to_object(other) <= 2)
		{
			other._attackingDuration += delta_time;
			if (other._attackingDuration >= ATTACK_DURATION)
			{
				other._movingDuration = 0;
				other._attackingDuration = 0;
				other._fallingDuration = 0.0001;
				other._doFallingDuration = DO_FALLING_DURATION;
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
	if (point_distance(_pawShadow.x, _pawShadow.y, _originalX, _originalY) > 5)
	{
		_pawShadow.speed = other._movingSpeed/2.5;
		_pawShadow.direction = point_direction(_pawShadow.x, _pawShadow.y, _originalX, _originalY);
	}
	else
	{
		_pawShadow.speed = 0;
	}
	
	_fallingDuration = 0.0001;
	_doFallingDuration = DO_FALLING_DURATION;
	
	x = _pawShadow.x;
	y = _pawShadow.y;
}
else if (_movingDuration <= 0 && _raising == true)
{
	_raising = false;
	_pawShadow.speed = 0;
	_attackingDuration = 0;
	_fallingDuration = FALLING_DURATION;
	_doFallingDuration = DO_FALLING_DURATION;
}
else if (noMovingTarget == true)
{
	_returnDuration -= delta_time;

	if (_returnDuration < 0)
	{
		if (point_distance(_pawShadow.x, _pawShadow.y, _originalX, _originalY) > 5)
		{
			_pawShadow.speed = _movingSpeed/2;
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
		_pawShadow.speed = _movingSpeed;
		_pawShadow.direction = point_direction(_pawShadow.x, _pawShadow.y, _target.x, _target.y);
	}
	
	x = _pawShadow.x;
	y = _pawShadow.y - (raisingRatio*_raiseHeight);
}

//Falling
if (_fallingDuration <= 0 && _doFallingDuration > 0)
{
	_doFallingDuration -= delta_time;
	var value = (_doFallingDuration < 0) ? 0 : _doFallingDuration;
	raisingRatio = 1 - (DO_FALLING_DURATION - value)/DO_FALLING_DURATION;

	_pawShadow.speed = 0;
	x = _pawShadow.x;
	y = _pawShadow.y - (raisingRatio*_raiseHeight);
		
	//HIT
	if (_doFallingDuration <= 0)
	{
		_returnDuration = RETURN_DURATION;
		_nextRaisingDelay = NEXT_RAISING_DELAY;
		
		audio_play_sound(snd_cat_paw_hit, 10, false);
		
		//Create a hitbox here.
		with (obj_breakable)
		{
			if (place_meeting(x, y, other._pawShadow) == true)
			{
				event_perform(ev_other, ev_user0);
			}
		}
	}
}
else if (_fallingDuration > 0)
{
	_fallingDuration -= delta_time;
	
	if (_fallingDuration <= 0)
	{
		var fadeEffect = instance_create_layer(x, y, layer, obj_cat_paw_fade_effect);
		fadeEffect._followingTaget = self;

		fadeEffect.image_index = image_index;
		fadeEffect.sprite_index = sprite_index;
	}
}