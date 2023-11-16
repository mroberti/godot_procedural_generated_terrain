
currentwidth = view_w;
currentheight = view_h;

//DEBUGMODE GUI STUFF
if(global.debugmode){

	draw_set_color(c_yellow);
	draw_set_font(fnt_tinyUnicode12);

	draw_text_outline(minmargin, minmargin, "Scale: "+string(zoom)+" FPS: "+string(fps_real),  c_black);
	draw_text_outline(4, debugtextheight+minpadding, "Player State: "+string(global.playerState)+" x: "+string(obj_Player.x) + " y: "+string(obj_Player.y), c_black);
	draw_text_outline(4, debugtextheight*2, "LandscapeTile: "+string(global.currentLandscapeTile)+"  LandTile: "+string(global.currentGroundTile), c_black);
	draw_text_outline(4, debugtextheight*3, "Rain intensity: "+string(global.rain), c_black);
	draw_text_outline(4, debugtextheight*4, "MouseXY: "+string(window_view_mouse_get_x(1))+" "+string(window_view_mouse_get_y(1)), c_black);
}

