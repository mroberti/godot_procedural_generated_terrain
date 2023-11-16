/// @description Player movement and tile "collision"

//animation
frame += framespeed;
xPos = x;
yPos = y;

global.playerState = 0; //If no key is pressed, player is idle
movingUp = false;
movingDown = false;
movingLeft = false;
movingRight = false;


//Here we check if the tile ahead of player is traversable, checks happen on Landscape layer (mountains etc) and BaseGroundTiles-layer (water)
if (keyboard_check(vk_up)) {
	global.playerState = 1; //moving
	//sprite = spr_OrangeHeroUp;
	movingDown = false; movingUp = true; movingRight = false; movingLeft = false;
	//Check if tile above is traversable
	nexttile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("Landscape")), obj_Player.x, obj_Player.y-stepsizeY-lookahead);
	groundtile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("BaseGroundTiles")), obj_Player.x, obj_Player.y-stepsizeY-lookahead);
	if(!(nexttile > blockertilesStart && nexttile < blockertilesStop) && !(groundtile > blockertilesStart && groundtile < blockertilesStop)){
		y -= stepsizeY;
	}
}
if (keyboard_check(vk_down)) {
	global.playerState = 1; //moving
	movingDown = true; movingUp = false; movingRight = false; movingLeft = false;
	//Check if tile below is traversable
	nexttile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("Landscape")), obj_Player.x, obj_Player.y+stepsizeY+lookahead);
	groundtile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("BaseGroundTiles")), obj_Player.x, obj_Player.y+stepsizeY+lookahead);
	if(!(nexttile > blockertilesStart && nexttile < blockertilesStop) && !(groundtile > blockertilesStart && groundtile < blockertilesStop)){
		y += stepsizeY;
	}
}
if (keyboard_check(vk_left)) {
	movingDown = true; movingUp = false; movingRight = false; movingLeft = true;
	global.playerState = 1; //moving
	//Check if tile to the left is traversable
	nexttile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("Landscape")), obj_Player.x-stepsizeX-lookahead, obj_Player.y);
	groundtile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("BaseGroundTiles")), obj_Player.x-stepsizeX-lookahead, obj_Player.y);
	if(!(nexttile > blockertilesStart && nexttile < blockertilesStop) && !(groundtile > blockertilesStart && groundtile < blockertilesStop)){
		x -= stepsizeX;
	}
}
if (keyboard_check(vk_right)) {
	global.playerState = 1; //moving
	movingDown = false; movingUp = false; movingRight = true; movingLeft = false;
	//Check if tile to the right is traversable
	nexttile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("Landscape")), obj_Player.x+stepsizeX+lookahead, obj_Player.y);
	groundtile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("BaseGroundTiles")), obj_Player.x+stepsizeX+lookahead, obj_Player.y);
	if(!(nexttile > blockertilesStart && nexttile < blockertilesStop) && !(groundtile > blockertilesStart && groundtile < blockertilesStop)){
		x += stepsizeX;
	}
}

//get current tile player is standing on
currenttile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("Landscape")), obj_Player.x, obj_Player.y);

// Check for tree-tiles in the tileset
if((currenttile >= 160 && currenttile <= 163) || (currenttile >= 240 && currenttile <= 245) || (currenttile >= 170 && currenttile <= 173) || (currenttile >= 187 && currenttile <= 189) || (currenttile >= 249 && currenttile <= 251) ){
	//show_message("player is in woods");
	//Set submerged state on char with a slight delay, if in forest tiles
	if(!submergedTimerStarted && !submerged){
		submergedTimerStarted = true;
		alarm[0] = room_speed*0.1;
	}
}
else
	submerged = false;
	
global.currentLandscapeTile = currenttile; //only used in debug mode in GUI
global.currentGroundTile = tilemap_get_at_pixel(layer_tilemap_get_id(layer_get_id("BaseGroundTiles")), obj_Player.x, obj_Player.y); //only used in debug mode in GUI



