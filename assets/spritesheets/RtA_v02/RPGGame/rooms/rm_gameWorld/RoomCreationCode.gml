// create a particle system and turn off automatic drawing
// this will prevent our application surface from drawing our raindrops
global.ps = part_system_create();
part_system_automatic_draw(global.ps, false);