extends TileMap

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()
var width = 41
var height = 25
const city_icon = preload("res://scenes/village.tscn")
var _timer = null
var water_timer = null
@onready var player = $"../Player"
@export var deepest_water: float = -35.0
@export var shallow_water: float = -23.0
@export var very_shallow_water: float = -5
@export var sandy_beach: float = -0
@export var grassland: float = 2
@export var semi_forested: float = 5
@export var forest: float = 7
@export var snow: float = 20
@export var mountains: float = 37
@export var mountains2: float = 37
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
	_timer.set_wait_time(0.5)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()

	water_timer = Timer.new()
	add_child(water_timer)

	water_timer.timeout.connect(animate_stuff)
	water_timer.set_wait_time(1)
	water_timer.set_one_shot(false) # Make sure it loops
	water_timer.start()

	var player_move_timer = Timer.new()
	add_child(player_move_timer)

	player_move_timer.timeout.connect(move_player)
	player_move_timer.set_wait_time(0.25)
	player_move_timer.set_one_shot(false) # Make sure it loops
	player_move_timer.start()

func move_player():
	player.move_on_map()	


func _on_Timer_timeout():
	# var the_monsters = get_tree().get_nodes_in_group("monsters")
	# for tempMonster in the_monsters:
	# 	if tempMonster != null:
	# 		print("Monster location: "+str(tempMonster.position))
	# 		tempMonster.random_idle_animation()
	get_tree().call_group("monsters", "random_idle_animation")
	get_tree().call_group("monsters", "_move_randomly", self)
# 		tempMonster._move_randomly(self)



func generate_chunk(passed_position):
	var tile_pos = local_to_map(passed_position)
	altitude.frequency = granularity
	for x in range(width):
		for y in range(height):
			var coords = Vector2i(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)
			var alt = altitude.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*150
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
				if(alt>=deepest_water and alt<shallow_water):
					atlas_coords = Vector2(6,77)
					set_cell(0, coords,0, atlas_coords, 0 )
				#Semi-deep water
				if(alt>=shallow_water and alt<very_shallow_water):
					atlas_coords = Vector2(18,77)
					set_cell(0, coords,0, atlas_coords, 0 )
				# Shallow water
				if(alt>=very_shallow_water and alt<sandy_beach):
					var t = Time.get_ticks_msec()
					if((t/1000)%2==0):
						atlas_coords = Vector2(2,18)
						set_cell(0, coords,0, atlas_coords, 0 )
					else:
						atlas_coords = Vector2(6,18)
						set_cell(0, coords,0, atlas_coords, 0 )					
				

				#Sand
				if(alt>=sandy_beach and alt<grassland):
					# Trees....let's seed a terrain_randomizer for reporduceable 
					var sand = terrain_randomizer.randi_range(0,1)
					#print("sand: "+str(sand))
					match sand:
						0:
							atlas_coords = Vector2(2,1)
							set_cell(0, coords,0, atlas_coords, 0 )
						1:
							atlas_coords = Vector2(6,1)
							set_cell(0, coords,0, atlas_coords, 0 )
					sand = terrain_randomizer.randi_range(0,50)
					#print("sand: "+str(sand))
					match sand:
						0:
							atlas_coords = Vector2(1,29)
							set_cell(1, coords+Vector2i(-1.0,0),1, atlas_coords, 0 )
							atlas_coords = Vector2(2,29)
							set_cell(1, coords,1, atlas_coords, 0 )
							atlas_coords = Vector2(1,30)
							set_cell(1, coords+Vector2i(-1.0,1.0),1, atlas_coords, 0 )
							atlas_coords = Vector2(2,30)
							set_cell(1, coords+Vector2i(0.0,1.0),1, atlas_coords, 0 )
				if(alt>=grassland and alt<semi_forested):
					var sand = terrain_randomizer.randi_range(0,3)
					#print("sand: "+str(sand))
					match sand:
						0:
							atlas_coords = Vector2(13,24)
							set_cell(0, coords,0, atlas_coords, 0 )
						1:
							atlas_coords = Vector2(14,24)
							set_cell(0, coords,0, atlas_coords, 0 )
						2:
							atlas_coords = Vector2(15,24)
							set_cell(0, coords,0, atlas_coords, 0 )
						3:
							atlas_coords = Vector2(16,24)
							set_cell(0, coords,0, atlas_coords, 0 )
					# Flowers
					var flowers = terrain_randomizer.randi_range(0,50)
					match flowers:
						0:
							atlas_coords = Vector2(1,1)
							set_cell(1, coords,1, atlas_coords, 0 )
						1:
							atlas_coords = Vector2(3,1)
							set_cell(1, coords,1, atlas_coords, 0 )						
					var settlements = terrain_randomizer.randi_range(0,15000)
					#Settlements
					match settlements:
						0:
							var sprite = Sprite2D.new()
							sprite.texture = load("res://assets/spritesheets/overworld_tiles.sprites/Tiny_Constructions_16.tres")
							add_child(sprite)
							sprite.position = map_to_local(coords)
						1:
							var sprite = Sprite2D.new()
							sprite.texture = load("res://assets/spritesheets/overworld_tiles.sprites/Tiny_Constructions_22.tres")
							add_child(sprite)
							sprite.position = map_to_local(coords)
						2:
							var sprite = Sprite2D.new()
							sprite.texture = load("res://assets/spritesheets/overworld_tiles.sprites/Tiny_Constructions_24.tres")
							add_child(sprite)
							sprite.position = map_to_local(coords)
						3:
							var sprite = Sprite2D.new()
							sprite.texture = load("res://assets/spritesheets/overworld_tiles.sprites/Tiny_Constructions_17.tres")
							add_child(sprite)
							sprite.position = map_to_local(coords)
				if(alt>=semi_forested and alt<forest):
					# Trees....let's seed a terrain_randomizer for reporduceable 
					var tree = terrain_randomizer.randi_range(0,3)
					#print("tree: "+str(tree))
					match tree:
						0:
							atlas_coords = Vector2(6,54)
							set_cell(0, coords,0, atlas_coords, 0 )
						1:
							atlas_coords = Vector2(7,54)
							set_cell(0, coords,0, atlas_coords, 0 )
						2:
							atlas_coords = Vector2(8,54)
							set_cell(0, coords,0, atlas_coords, 0 )
						3:
							atlas_coords = Vector2(9,54)
							set_cell(0, coords,0, atlas_coords, 0 )
				if(alt>=forest and alt<snow):
					# Trees....let's seed a terrain_randomizer for reporduceable 
					var tree = terrain_randomizer.randi_range(0,3)
					#print("tree: "+str(tree))
					match tree:
						0:
							atlas_coords = Vector2(1,39)
							set_cell(0, coords,0, atlas_coords, 0 )
						1:
							atlas_coords = Vector2(2,39)
							set_cell(0, coords,0, atlas_coords, 0 )
						2:
							atlas_coords = Vector2(3,39)
							set_cell(0, coords,0, atlas_coords, 0 )
						3:
							atlas_coords = Vector2(4,39)
							set_cell(0, coords,0, atlas_coords, 0 )

				if(alt>=snow and alt<mountains):
					atlas_coords = Vector2(49,49)
					set_cell(0, coords,0, atlas_coords, 0 )
				if(alt>=mountains and alt<mountains2):
					atlas_coords = Vector2(10,3)
					set_cell(0, coords,0, atlas_coords, 0 )
			else:
				pass;

func animate_stuff():
	#var t = Time.get_ticks_msec()
	var tile_pos = local_to_map(player.position)
	altitude.frequency = granularity
	for x in range(width):
		for y in range(height):
			var coords = Vector2i(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)
			var alt = altitude.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*150
			var atlas_coords
			# Deep water
			if(alt>=deepest_water and alt<shallow_water):
				var tree = terrain_randomizer.randi_range(0,1)
				#print("tree: "+str(tree))
				match tree:
					0:
						atlas_coords = Vector2(6,77)
						set_cell(0, coords,0, atlas_coords, 0 )
					1:
						atlas_coords = Vector2(2,77)
						set_cell(0, coords,0, atlas_coords, 0 )
			#Semi-deep water
			if(alt>=shallow_water and alt<very_shallow_water):
				var tree = terrain_randomizer.randi_range(0,1)
				#print("tree: "+str(tree))
				match tree:
					0:
						atlas_coords = Vector2(18,77)
						set_cell(0, coords,0, atlas_coords, 0 )
					1:
						atlas_coords = Vector2(22,77)
						set_cell(0, coords,0, atlas_coords, 0 )
			# Shallow water
			if(alt>=very_shallow_water and alt<sandy_beach):
				var tree = terrain_randomizer.randi_range(0,1)
				#print("tree: "+str(tree))
				match tree:
					0:
						atlas_coords = Vector2(2,18)
						set_cell(0, coords,0, atlas_coords, 0 )
					1:
						atlas_coords = Vector2(6,18)
						set_cell(0, coords,0, atlas_coords, 0 )

func animate_stuff2():
	var t = Time.get_ticks_msec()
	var tile_pos = local_to_map(player.position)
	altitude.frequency = granularity
	for x in range(width):
		for y in range(height):
			var coords = Vector2i(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)
			var alt = altitude.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*150
			var atlas_coords
			# Deep water
			if(alt>=deepest_water and alt<shallow_water):
				if((t/1000)%2==0):
					atlas_coords = Vector2(6,77)
					set_cell(0, coords,0, atlas_coords, 0 )
				else:
					atlas_coords = Vector2(2,77)
					set_cell(0, coords,0, atlas_coords, 0 )			
			#Semi-deep water
			if(alt>=shallow_water and alt<very_shallow_water):
				if((t/1000)%2==0):
					atlas_coords = Vector2(18,77)
					set_cell(0, coords,0, atlas_coords, 0 )
				else:
					atlas_coords = Vector2(22,77)
					set_cell(0, coords,0, atlas_coords, 0 )		
			# Shallow water
			if(alt>=very_shallow_water and alt<sandy_beach):
				if((t/1000)%2==0):
					atlas_coords = Vector2(2,18)
					set_cell(0, coords,0, atlas_coords, 0 )
				else:
					atlas_coords = Vector2(6,18)
					set_cell(0, coords,0, atlas_coords, 0 )					

# This is the old method
# func generate_chunk(position):
# 	var tile_pos = local_to_map(position)
				
# 	for x in range(width):
# 		for y in range(height):
# 			var coords = Vector2i(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)
# 			var moist = moisture.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*10
# 			var temp = temperature.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*10
# 			var alt = altitude.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*150
# 			var atlas_coords = Vector2(3 if alt < 2 else round((moist + 10) / 5), round((temp + 10) / 5))
# 			if(get_cell_atlas_coords(0,coords,false) == Vector2i(-1,-1)):
# 				# A cell doesn't exist at these coordinates, so 
# 				# we're creating one
# 				set_cell(0, coords,1, atlas_coords, 0 )
# 			else:
# 				pass;
