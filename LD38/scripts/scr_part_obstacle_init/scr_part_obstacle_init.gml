
global.pt_obstacle = part_type_create();
var pt = global.pt_obstacle;

part_type_shape(pt, pt_shape_star);
part_type_size(pt, 0.05, 0.1, 0, 0);
part_type_color2(pt, make_color_rgb(63, 63, 63), make_color_rgb(254, 174, 52));
part_type_alpha2(pt, 0.9, 0.5);
part_type_speed(pt, 5, 7, -0.2, 0);
part_type_direction(pt, 0, 180, 0, 0);
part_type_gravity(pt, 0.3, 270);
part_type_life(pt, 6, 17);