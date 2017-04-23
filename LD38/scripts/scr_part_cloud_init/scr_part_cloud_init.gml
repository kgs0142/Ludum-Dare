
global.pt_cloud = part_type_create();
var pt = global.pt_cloud;

part_type_shape(pt, pt_shape_smoke);
part_type_size(pt, 0.1, 0.2, 0, 0);
part_type_color2(pt, make_color_rgb(192, 203, 220), make_color_rgb(139, 155, 180));
part_type_alpha2(pt, 0.5, 0.1);
part_type_speed(pt, 3, 5, -0.2, 0);
part_type_direction(pt, 0, 180, 0, 0);
part_type_gravity(pt, 0.1, 270);
part_type_life(pt, 6, 17);