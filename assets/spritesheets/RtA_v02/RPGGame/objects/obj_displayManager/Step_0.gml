
if(keyboard_check_pressed(ord("Z"))){
	
	zoom++;
	if(zoom>max_zoom){
		zoom=1;
	}
	
	window_set_size(ideal_width*zoom, ideal_height*zoom);
	display_set_gui_size(ideal_width,ideal_height);
	surface_resize(application_surface, ideal_width*zoom, ideal_height*zoom); 
	alarm[0] = 1;
	//show_message("zoom "+string(zoom));
}

//view follow player
view_x = obj_Player.x - view_w/2;
view_y = obj_Player.y - view_h/2;

view_x = clamp(view_x, 0, room_width - view_w);
view_y = clamp(view_y, 0, room_height - view_h);

//show_debug_message("camera pos x: "+string(camera_get_view_x(camera)));
//show_debug_message("camera pos y: "+string(camera_get_view_y(camera)));
