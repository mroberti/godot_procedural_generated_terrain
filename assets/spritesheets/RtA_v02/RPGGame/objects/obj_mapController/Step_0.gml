/// @description Insert description here

//Track what landscape (blocking) tile player is standing on
global.currentLandscapeTile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("Landscape")), obj_Player.x, obj_Player.y);
show_debug_message("tile: "+string(global.currentLandscapeTile));

//Track ground tiles, climate etc
//Desert and dry  earth tiles
global.currentGroundTile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("BaseGroundTiles")), obj_Player.x, obj_Player.y);
if(global.currentGroundTile >= 16 && global.currentGroundTile <= 30){
	global.currentTileClimate = "dry";
}
else{
	global.currentTileClimate = "notdry";
}


//show_debug_message(string(variable_instance_get(global.currentObjectInFront.instance_id,gold)));
ignoreID = obj_Player.object_index;


//	show_message("object in front is: "+object_get_name(global.currentObjectInFront));


//if(global.currentObjectInFront)	
	
//show_debug_message("object-tile: "+string(global.currentObjectTile));