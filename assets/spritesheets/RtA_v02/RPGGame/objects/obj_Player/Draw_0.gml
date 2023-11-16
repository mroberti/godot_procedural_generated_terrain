





//"Submerge" player in different vegetation by only drawing upper part of the sprite
if(submerged){
	if(global.playerState == 0) //draw idle sprite
		draw_sprite_part_ext(spr_OrangeHeroIdle,image_index,0,0,16,12, xPos-spritewidth/2, yPos-spriteheight+1,xScale,yScale,color,alpha);
	else{
		if(movingLeft)
			draw_sprite_part_ext(spr_OrangeHeroLeft,image_index,0,0,spritewidth,spriteheight-6, xPos-spritewidth/2, yPos-spriteheight+1,xScale,yScale,color,alpha);
		else if(movingUp)
			draw_sprite_part_ext(spr_OrangeHeroUp,image_index,0,0,spritewidth,spriteheight-6, xPos-spritewidth/2, yPos-spriteheight+1,xScale,yScale,color,alpha);
		else if(movingRight)
			draw_sprite_part_ext(spr_OrangeHeroRight,image_index,0,0,spritewidth,spriteheight-6, xPos-spritewidth/2, yPos-spriteheight+1,xScale,yScale,color,alpha);
		else if(movingDown)
			draw_sprite_part_ext(spr_OrangeHeroDown,image_index,0,0,spritewidth,spriteheight-6, xPos-spritewidth/2, yPos-spriteheight+1,xScale,yScale,color,alpha);
	}
}
else{
	//draw shadow
	draw_sprite_ext(spr_CharacterShadow,image_index,xPos,yPos-1,xScale,yScale,angle,color,0.5);
	
	if(global.playerState == 0) //draw idle sprite
		draw_sprite_ext(spr_OrangeHeroIdle,image_index, xPos, yPos,xScale,yScale,angle,color,alpha);
	else{
		if(movingLeft)
			draw_sprite_ext(spr_OrangeHeroLeft,image_index,xPos,yPos,xScale,yScale,angle,color,alpha);
		else if(movingUp)
			draw_sprite_ext(spr_OrangeHeroUp,image_index,xPos,yPos,xScale,yScale,angle,color,alpha);
		else if(movingRight)
			draw_sprite_ext(spr_OrangeHeroRight,image_index,xPos,yPos,xScale,yScale,angle,color,alpha);
		else if(movingDown)
			draw_sprite_ext(spr_OrangeHeroDown,image_index,xPos,yPos,xScale,yScale,angle,color,alpha);
	}
}

if(global.debugmode){
	//draw vision range on map
	//draw_set_color(c_yellow);
	//draw_line(obj_Player.x+5, obj_Player.y, obj_Player.x+5, obj_Player.y-16);
	//draw_circle(obj_Player.x+sprite_get_width(spr_player)/4,obj_Player.y+sprite_get_height(spr_player)/4,obj_Player.vision,true);
}

