extends TileMap

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()
var width = 50
var height = 50
const city_icon = preload("res://scenes/village.tscn")
var _timer = null
@onready var player = $"../Player"
@export var level1: float = -35.0
@export var level2: float = -23.0
@export var level3: float = -5
@export var level4: float = -0
@export var level5: float = 2
@export var level6: float = 5
@export var level7: float = 7
@export var level8: float = 20
@export var level9: float = 37
@export var granularity:float = 0.0013
var terrain_randomizer = RandomNumberGenerator.new()

func _ready():
	moisture.seed = -686559431 #randi()
	temperature.seed = -175673643 #randi()
	altitude.seed = 778520879 #randi()
	terrain_randomizer.seed = altitude.seed
	altitude.frequency = 0.0013

	generate_chunk(player.position)
	_timer = Timer.new()
	add_child(_timer)

	_timer.timeout.connect(_on_Timer_timeout)
	_timer.set_wait_time(0.1)
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
	altitude.frequency = granularity
	for x in range(width):
		for y in range(height):
			var coords = Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)
			var alt = altitude.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*150
			var atlas_coords
			# print("Alt: "+str(alt))
			#print("Alt: "+str(alt))
			# 1,9 Grass
			# 2,33 Water
			#print(alt)
			if(get_cell_atlas_coords(0,coords,false) == Vector2i(-1,-1)):
				# A cell doesn't exist at these coordinates, so 
				# we're creating one
				
				# Deep water
				if(alt>=level1 and alt<level2):
					atlas_coords = Vector2(13,2)
					set_cell(0, coords,2, atlas_coords, 0 )
				#Semi-deep water
				if(alt>=level2 and alt<level3):
					atlas_coords = Vector2(14,2)
					set_cell(0, coords,2, atlas_coords, 0 )
				# Shallow water
				if(alt>=level3 and alt<level4):
					atlas_coords = Vector2(15,0)
					set_cell(0, coords,2, atlas_coords, 0 )
				#Sand
				if(alt>level4 and alt<level5):
					# Trees....let's seed a terrain_randomizer for reporduceable 
					var sand = terrain_randomizer.randi_range(2,3)
					#print("sand: "+str(sand))
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
				if(alt>level5 and alt<level6):
					atlas_coords = Vector2(0,2)
					set_cell(0, coords,2, atlas_coords, 0 )
				if(alt>=level6 and alt<level7):
					# Trees....let's seed a terrain_randomizer for reporduceable 
					var tree = terrain_randomizer.randi_range(0,4)
					#print("tree: "+str(tree))
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
				if(alt>=level7 and alt<level8):
					atlas_coords = Vector2(6,2)
					set_cell(0, coords,2, atlas_coords, 0 )
				if(alt>=level8 and alt<level9):
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
