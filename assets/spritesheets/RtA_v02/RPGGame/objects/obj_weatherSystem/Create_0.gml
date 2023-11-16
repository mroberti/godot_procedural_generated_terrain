/// @description Insert description here
// You can write your code in this editor
// we will draw particles on this surface


c_lightblue = make_color_rgb(40,180,249);
c_tealblue = make_color_rgb(47,96,94);
c_mossgreen = make_color_rgb(67,97,17);
c_brightgreen = make_color_rgb(138,176,41)
c_darkwater = make_color_rgb(3,67,92);


rainintensity = 10;

surf = surface_create(room_width, room_height);

// create a raindrop particle
rain = part_type_create();
// optional angle, this will create some kind of wind effect
rain_angle = -10

// Raindrops
rainBright = part_type_create();
part_type_shape(rainBright , pt_shape_pixel);
part_type_size(rainBright, 2, 2, 0, 0);
part_type_scale(rainBright, 0.30, 6);
part_type_orientation(rainBright, rain_angle, rain_angle, 0, 0, 0);
part_type_color3(rainBright, c_lightblue, c_brightgreen, c_mossgreen);
part_type_alpha3(rainBright, 1, 1, 1);
part_type_blend(rainBright, 0);
part_type_life(rainBright, 120, 120);
part_type_speed(rainBright, 16, 16, 0, 0);
part_type_direction(rainBright, 270+rain_angle, 270+rain_angle, 0, 0);

rainDark = part_type_create();
part_type_shape(rainDark , pt_shape_pixel);
part_type_size(rainDark, 2, 2, 0, 0);
part_type_scale(rainDark, 0.30, 6);
part_type_orientation(rainDark, rain_angle, rain_angle, 0, 0, 0);
part_type_color3(rainDark, c_tealblue, c_mossgreen, c_darkwater);
part_type_alpha3(rainDark, 1, 1, 1);
part_type_blend(rainDark, 0);
part_type_life(rainDark, 120, 120);
part_type_speed(rainDark, 16, 16, 0, 0);
part_type_direction(rainDark, 270+rain_angle, 270+rain_angle, 0, 0);

// Rainsplat
splat = part_type_create();
part_type_shape(splat , pt_shape_pixel);
part_type_size(splat, 1, 3, 0.2, 1);
part_type_scale(splat, 0.3,0.3);
part_type_orientation(splat, 0, 0, 0, 0, 0);
part_type_color3(splat, 15133336, 15133336, c_aqua);
part_type_alpha3(splat, 1, 1, 1);
part_type_blend(splat, 0.3);
part_type_life(splat, 8, 20);
part_type_speed(splat, -0.3, -0.4, 0, 0);
part_type_direction(splat, 180, 180, 0, 0);

// Floating particles
floaties = part_type_create();
part_type_shape(floaties , pt_shape_pixel);
part_type_size(floaties, 0.5, 2, 0.05, 0.02);
part_type_scale(floaties, 0.15,0.15);
part_type_orientation(floaties, 180, 290, 25, 20, 0);
part_type_color3(floaties, c_yellow, c_white, c_green);
part_type_alpha3(floaties, 1, 1, 1);
part_type_blend(floaties, 0.25);
part_type_life(floaties, 25, 230);
part_type_speed(floaties, 0.0015, 0.18, 0.013, 0.2);
part_type_direction(floaties, 180, 180+rain_angle, 0, 0);