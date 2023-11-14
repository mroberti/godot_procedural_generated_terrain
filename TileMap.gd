extends TileMap

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()
var width = 5
var height = 5
const city_icon = preload("res://scenes/village.tscn")
var _timer = null
@onready var player = $"../Player"



func _ready():
	moisture.seed = -686559431 #randi()
	temperature.seed = -175673643 #randi()
	altitude.seed = 778520879 #randi()
	altitude.frequency = 0.001

	generate_chunk(player.position)
	_timer = Timer.new()
	add_child(_timer)

	_timer.timeout.connect(_on_Timer_timeout)
	_timer.set_wait_time(5.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()


func _on_Timer_timeout():
	# var the_monsters = get_tree().get_nodes_in_group("monsters")
	# for tempMonster in the_monsters:
	# 	if tempMonster != null:
	# 		print("Monster location: "+str(tempMonster.position))
	# 		tempMonster.random_idle_animation()
	get_tree().call_group("monsters", "random_idle_animation")
	get_tree().call_group("monsters", "_move_randomly", self)
	# 		tempMonster._move_randomly(self)

func generate_chunk(position):
	var tile_pos = local_to_map(position)
				
	for x in range(width):
		for y in range(height):
			var coords = Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)
			var moist = moisture.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
			var temp = temperature.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
			var alt = altitude.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*150
			var atlas_coords = Vector2(3 if alt < 2 else round((moist + 10) / 5), round((temp + 10) / 5))
			if(get_cell_atlas_coords(0,coords,false) == Vector2i(-1,-1)):
				# A cell doesn't exist at these coordinates, so 
				# we're creating one
				set_cell(0, coords,1, atlas_coords, 0 )
			else:
				pass;
