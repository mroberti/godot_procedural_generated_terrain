extends TileMap
var monster = preload("res://scenes/basic_enemy/basic_enemy.tscn")
var altitude = FastNoiseLite.new()
var width = 49
var height = 28
var old_data = null

@onready var player = $Player


func _ready():
	altitude.seed = randi()
	altitude.frequency = 0.005


func _process(delta):
	generate_chunk(player.position)	


func generate_chunk(position):
	var tile_pos = local_to_map(position)
	var data = get_cell_atlas_coords(0, tile_pos)
	if(data != old_data):
		old_data = data
		print(str(data))
	for x in range(width):
		for y in range(height):
			var alt = altitude.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
			if alt <=-2.5:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(6,33))
			if alt >-2.5 and alt <=-1:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(6,3))
			if alt >-1 and alt <=-0.75:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(2,1))
			if alt >-0.75 and alt <=0.25:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(2,54))
			if alt >0.25 and alt <=2:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(8,54))
			if alt >2 and alt <=3.25:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(4,54))
			if alt >3.25 and alt <=3.75:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(14,54))
			if alt >3.75 and alt <=4.0:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(19,54))
			if alt >4.0: # and alt <=4.5:
				set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(64,43))
			# if alt >4.5 and alt <=4.75:
			# 	set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(7,1))
			# if alt >4.75:
			# 	set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(6,2))
			# if alt >4.5 and alt <=4.75:
			# 	set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(7,1))
			# if alt >4.75:
			# 	set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(6,2))

func between(val, start, end):
	if start <= val and val < end:
		return true
