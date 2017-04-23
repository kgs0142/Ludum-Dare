
global.pt_dust = part_type_create();
var pt = global.pt_dust;

part_type_shape(pt, pt_shape_smoke);
part_type_size(pt, 0.1, 0.2, 0, 0);
part_type_color2(pt, $5a6988, $5a6988);
part_type_alpha2(pt, 0.9, 0.5);
part_type_speed(pt, 5, 7, -0.2, 0);
part_type_direction(pt, 0, 180, 0, 0);
part_type_gravity(pt, 0.1, 270);
part_type_life(pt, 5, 10);