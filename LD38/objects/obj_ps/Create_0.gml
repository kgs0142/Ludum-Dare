/// @description Insert description here
global.ps = part_system_create();
part_system_depth(global.ps, obj_player.depth);

scr_part_dust_init();
scr_part_cloud_init();
scr_part_obstacle_init();
scr_part_water_init();