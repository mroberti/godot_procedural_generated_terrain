function nineSliceBox(argument0, argument1, argument2, argument3, argument4) {
	/*@desc nineSliceBox(sprite, x1, x2, x2, y2);
	@arg sprite
	@arg x1
	@arg y1
	@arg x2
	@arg y2
	*/


	var _size = sprite_get_width(argument0) / 3;
	var _x1 = argument1;
	var _y1 = argument2;
	var _x2 = argument3;
	var _y2 = argument4;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1;
	var _columns = _w div _size;
	var _rows = _h div _size;


	//CORNERS
	//Top left
	draw_sprite_part(argument0, 0, 0, 0, _size, _size, _x1, _y1);
	//Top right
	draw_sprite_part(argument0, 0, _size*2, 0, _size, _size, _x1+(_columns*_size), _y1);
	//Bottom left
	draw_sprite_part(argument0, 0,  0, _size*2, _size, _size, _x1, _y1+(_rows * _size));
	//Bottom right
	draw_sprite_part(argument0, 0,  _size*2, _size*2, _size, _size, _x1+(_columns * _size), _y1+(_rows * _size));


	//EDGES
	for (var i = 1; i < _rows; i++){

		//Left edge
		draw_sprite_part(argument0, 0, 0, _size, _size, _size, _x1, _y1+(i*_size));
		//right edge
		draw_sprite_part(argument0, 0, _size*2, _size, _size, _size, _x1+(_columns*_size),_y1+(i*_size));

	}

	for (var i = 1; i < _columns; i++){

		//top edge
		draw_sprite_part(argument0, 0, _size, 0, _size, _size, _x1+(i*_size), _y1);
		//borrom edge
		draw_sprite_part(argument0, 0, _size, _size*2, _size, _size, _x1+(i*_size),_y1+(_rows*_size));
	}


	//MIDDLE
	for (var i = 1; i < _columns; i++){
	
		for(var j = 1; j < _rows; j++){
			draw_sprite_part(argument0, 0, _size, _size, _size, _size, _x1+(i*_size), _y1+(j*_size));
		}
	}


}
