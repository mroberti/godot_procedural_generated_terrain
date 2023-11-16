


event_inherited();
globalvar zoom;
max_zoom=1;
zoom=3;
use_sub_pixels=false;

// Set this to 1 when testing different displ sizes on computer, 0 for deployed device

TestMode = 0;
// Set either ideal height or width, use aspect ratio to calculate the other
ideal_width=0; //used for view width and view height
ideal_height = 180;

// When Test Mode is set to 1, these values will be used to set screen size
// (Default Aspect ratio for Galaxy S5)
// UNUSED FOR NOW

var test_w = 1920;
var test_h = 1080;

window_set_color(c_black);

// For test mode, use display values set at begigning of script

display_w    = test_w;
display_h    = test_h;

if(TestMode == 1){
	display_aspect_ratio = test_w/test_h;
}
else{
	display_aspect_ratio = display_get_width()/display_get_height();
}

ideal_width = round(ideal_height * display_aspect_ratio);
//ideal_height = round(ideal_width / display_aspect_ratio);

if(ideal_height & 1){
	ideal_height++;
	
}
if(ideal_width & 1){
  ideal_width++;
}

max_zoom = floor(display_get_width()/ideal_width);


//Set all rooms to correct viewport

/*globalvar Main_Camera;
Main_Camera = camera_create_view(0,0,ideal_width,ideal_height,0,noone,0,0,0,0);
camera_set_view_size(Main_Camera,ideal_width,ideal_height);
*/

/*for (var i=0; i<room_last;i++){
	if(room_exists(i)){
		room_set_view_enabled(i,true);
        room_set_viewport(i,0,true,0,0,ideal_width,ideal_height);
        room_set_camera(i,0,Main_Camera);
}
	
}
*/


// Set the vertical view and ports to our new aspect ratio
/*
view_hview[0] = view_wview[0] / display_aspect_ratio;

view_hport[0] = view_wview[0] / display_aspect_ratio;

// Resize display GUI and set application surface to our new aspect ratio

display_set_gui_size(view_wport[0],view_hport[0])

surface_resize(application_surface, view_wview[0], view_hview[0]);
*/




display_set_gui_size(ideal_width,ideal_height);
window_set_size(ideal_width*zoom,ideal_height*zoom);
surface_resize(application_surface,ideal_width,ideal_height);


global.camera = camera_create();
globalvar view_x, view_y, view_w, view_h;
view_x=0;
view_y=0;
view_w = ideal_width;
view_h = ideal_height;


alarm[0] = 1;
room_goto_next();