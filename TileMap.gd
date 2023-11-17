extends TileMap

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()
var width = 50
var height = 50
const city_icon = preload("res://scenes/village.tscn")
var _timer = null
@onready var player = $"../Player"
var terrain_randomizer = RandomNumberGenerator.new()

func _ready():
	moisture.seed = -686559431 #randi()
	temperature.seed = -175673643 #randi()
	altitude.seed = 778520879 #randi()
	terrain_randomizer.seed = altitude.seed
	altitude.frequency = 0.00125

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
			var alt = altitude.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*150
			var atlas_coords
			# 1,9 Grass
			# 2,33 Water
			#print(alt)
			if(get_cell_atlas_coords(0,coords,false) == Vector2i(-1,-1)):
				# A cell doesn't exist at these coordinates, so 
				# we're creating one
				if(alt>=0 and alt<23):
					atlas_coords = Vector2(13,2)
					set_cell(0, coords,2, atlas_coords, 0 )
				if(alt>=23 and alt<26):
					atlas_coords = Vector2(14,2)
					set_cell(0, coords,2, atlas_coords, 0 )
				if(alt>=26 and alt<27):
					atlas_coords = Vector2(15,0)
					set_cell(0, coords,2, atlas_coords, 0 )
				if(alt>=27 and alt<30):
					# Trees....let's seed a terrain_randomizer for reporduceable 
					var sand = terrain_randomizer.randi_range(2,3)
					print("sand: "+str(sand))
					match sand:
						0:
							atlas_coords = Vector2(0,0)
							set_cell(0, coords,2, atlas_coords, 0 )
						1:
							atlas_coords = Vector2(1,0)
							set_cell(0, coords,2, atlas_coords, 0 )
						2:
							atlas_coords = Vector2(2,0)
							set_cell(0, coords,2, atlas_coords, 0 )
						3:
							atlas_coords = Vector2(3,0)
							set_cell(0, coords,2, atlas_coords, 0 )
				if(alt>=30 and alt<33):
					atlas_coords = Vector2(0,2)
					set_cell(0, coords,2, atlas_coords, 0 )
				if(alt>=33 and alt<36):
					# Trees....let's seed a terrain_randomizer for reporduceable 
					var tree = terrain_randomizer.randi_range(0,4)
					print("tree: "+str(tree))
					match tree:
						0:
							atlas_coords = Vector2(0,4)
							set_cell(0, coords,2, atlas_coords, 0 )
						1:
							atlas_coords = Vector2(1,4)
							set_cell(0, coords,2, atlas_coords, 0 )
						2:
							atlas_coords = Vector2(0,5)
							set_cell(0, coords,2, atlas_coords, 0 )
						3:
							atlas_coords = Vector2(1,5)
							set_cell(0, coords,2, atlas_coords, 0 )
						4:
							atlas_coords = Vector2(0,6)
							set_cell(0, coords,2, atlas_coords, 0 )
				if(alt>=36 and alt<37):
					# Trees....let's seed a terrain_randomizer for reporduceable 
					var snow = terrain_randomizer.randi_range(0,1)
					print("snow: "+str(snow))
					match snow:
						0:
							atlas_coords = Vector2(6,2)
							set_cell(0, coords,2, atlas_coords, 0 )
						1:
							atlas_coords = Vector2(7,2)
							set_cell(0, coords,2, atlas_coords, 0 )
				if(alt>=37 and alt<38):
					atlas_coords = Vector2(10,3)
					set_cell(0, coords,2, atlas_coords, 0 )
			else:
				pass;

# This is the old method
# func generate_chunk(position):
# 	var tile_pos = local_to_map(position)
				
# 	for x in range(width):
# 		for y in range(height):
# 			var coords = Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)
# 			var moist = moisture.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
# 			var temp = temperature.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
# 			var alt = altitude.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*150
# 			var atlas_coords = Vector2(3 if alt < 2 else round((moist + 10) / 5), round((temp + 10) / 5))
# 			if(get_cell_atlas_coords(0,coords,false) == Vector2i(-1,-1)):
# 				# A cell doesn't exist at these coordinates, so 
# 				# we're creating one
# 				set_cell(0, coords,1, atlas_coords, 0 )
# 			else:
# 				pass;
