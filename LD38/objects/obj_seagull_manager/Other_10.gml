/// @description Unregister the seagul
//Called by dead seagul

//self or other are all seagul
var seagul = self;
//var mgr = other;

if (obj_seagull_manager._leftSeagull == seagul)
{
	obj_seagull_manager._leftSeagull = noone;
}
else if (obj_seagull_manager._rightSeagull == seagul)
{
	obj_seagull_manager._rightSeagull = noone;
}