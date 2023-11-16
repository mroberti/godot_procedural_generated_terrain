function screenSize() {
	/******Script Begin*******/


	event_inherited();
	zoom=1;
	max_zoom=1;
	use_sub_pixels=false;

	// Set this to 1 when testing different displ sizes on computer, 0 for deployed device

	TestMode = 0;
	// Set either ideal height or width, use aspect ratio to calculate the other
	ideal_width=320; //used for view width and view height
	ideal_height = 0;

	// When Test Mode is set to 1, these values will be used to set screen size
	// (Default Aspect ratio for Galaxy S5)
	// UNUSED FOR NOW

	var test_w = 1920;
	var test_h = 1080;



	// For test mode, use display values set at begigning of script

	display_w    = test_w;
	display_h    = test_h;

	if(TestMode == 1){
		display_aspect_ratio = test_w/test_h;
	}
	else{
		display_aspect_ratio = display_get_width()/display_get_height();
	}

	ideal_height = round(ideal_width / display_aspect_ratio);

	if(ideal_height & 1){
		ideal_height++;
	
	}
	if(ideal_width & 1){
	  ideal_width++;
	}

	max_zoom = floor(display_get_width()/ideal_width);
	show_message(string(max_zoom));

	//Set all rooms to correct viewport

	globalvar Main_Camera;
	Main_Camera = camera_create_view(0,0,ideal_width,ideal_height,0,noone,0,0,0,0);
	camera_set_view_size(Main_Camera,ideal_width,ideal_height);



	for (var i=0; i<room_last;i++){
		if(room_exists(i)){
			room_set_view_enabled(i,true);
	        room_set_viewport(i,0,true,0,0,ideal_width,ideal_height);
	        room_set_camera(i,0,Main_Camera);
	}
	
	}



	// Set the vertical view and ports to our new aspect ratio
	/*
	view_hview[0] = view_wview[0] / display_aspect_ratio;

	view_hport[0] = view_wview[0] / display_aspect_ratio;

	// Resize display GUI and set application surface to our new aspect ratio

	display_set_gui_size(view_wport[0],view_hport[0])

	surface_resize(application_surface, view_wview[0], view_hview[0]);
	*/

	surface_resize(application_surface,ideal_width,ideal_height);
	display_set_gui_size(ideal_width,ideal_height);
	window_set_size(ideal_width*zoom,ideal_height*zoom);



	/******Script End*******/


}
