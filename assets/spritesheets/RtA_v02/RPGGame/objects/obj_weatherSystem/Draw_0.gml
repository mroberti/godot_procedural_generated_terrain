
// create surface if it doesn't exist
if !surface_exists(surf) surf = surface_create(room_width, room_height);

surface_set_target(surf);

// fill the surface with transparent color to prevent particles from leaving ugly traces
draw_clear_alpha(1,0);

// draw particles now
part_system_drawit(global.ps);


// reset target and draw the surface
surface_reset_target();
draw_surface(surf, 0, 0);