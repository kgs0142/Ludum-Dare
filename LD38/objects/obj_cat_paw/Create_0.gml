/// @description *SIGH*

_originalX = x;
_originalY = y;

_aimingMask = obj_left_aiming_mask;
_pawShadow = instance_nearest(x, y, obj_cat_left_paw_shadow);

_target = noone;
_raiseHeight = 20.0;
_movingSpeed = 1.5;
_raising = false;

_movingDuration = 0.0;
_raiseDuration = 0.0;
_fallingDuration = 0.0;
_returnDuration = 0.0;
_attackingDuration = 0.0;

_doFallingDuration = 0.0;

_nextRaisingDelay = 0.0;

_movingUnderTeasingStickDuration = 0.0;

_playingTeasingStick = false;
_playingTeasingStickDuration = 0.0;

_isDoneMovingBackForTeasingStick = false;

