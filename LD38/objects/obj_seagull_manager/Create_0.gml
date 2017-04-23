/// @description Insert description here

_enable = true;

_leftSeagull = noone;
_rightSeagull = noone;

_lowRndRange = 60;
_highRndRange = 240;

alarm_set(0, random_range(_lowRndRange, _highRndRange));
alarm_set(1, random_range(_lowRndRange, _highRndRange));
