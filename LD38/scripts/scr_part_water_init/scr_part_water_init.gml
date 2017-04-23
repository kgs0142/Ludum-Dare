
global.pt_water = part_type_create();
var pt = global.pt_water;

part_type_shape(pt, pt_shape_sphere);
part_type_size(pt, 0.05, 0.10, 0, 0);
part_type_color2(pt, make_color_rgb(0, 149, 233), make_color_rgb(44, 232, 245));
part_type_alpha2(pt, 0.9, 0.7);
part_type_speed(pt, 3, 5, -0.2, 0);
part_type_direction(pt, 0, 180, 0, 0);
part_type_gravity(pt, 0.3, 270);
part_type_life(pt, 6, 17);