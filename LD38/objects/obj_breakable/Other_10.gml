/// @description Got hitted by cat paw.
speed = 0;

audio_play_sound(snd_paw_break_obstacle, 10, false);

part_particles_create(global.ps, x, y, global.pt_obstacle, 5);

instance_deactivate_object(self);
