extends TileMap

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()
var width = 26
var height = 16
const city_icon = preload("res://scenes/village.tscn")

@onready var player = $Player

func _ready():
	moisture.seed = -686559431 #randi()
	temperature.seed = -175673643 #randi()
	altitude.seed = 778520879 #randi()
	altitude.frequency = 0.001


func _process(delta):
	generate_chunk(player.position)
	

func generate_chunk(position):
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			var moist = moisture.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
			var temp = temperature.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
			var alt = altitude.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*150
			
			var atlas_coords = Vector2(3 if alt < 2 else round((moist + 10) / 5), round((temp + 10) / 5))
			
			set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y),0, atlas_coords, 0 )
			if(alt>2 and randi()%10000+1==4):
				#Make instance
				var city_instance= city_icon.instantiate()
				add_child(city_instance)
				city_instance.position = map_to_local(Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y))
			#if alt < 2:
			#	set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(3, round((temp+10)/5)))
			#else:
			#	set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y), 0, Vector2(round((moist+10)/5), round((temp+10)/5)))
