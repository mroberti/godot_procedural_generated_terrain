extends TileMap

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()
var width = 100	
var height = 100	
const city_icon = preload("res://scenes/village.tscn")
var _timer = null
var water_timer = null
var terrains:PackedFloat32Array
var terrains_sprites:PackedVector2Array
var lowest = 0
var highest = 0

@onready var player = $"../Player"
@export var granularity:float = 0.0013

var terrain_randomizer = RandomNumberGenerator.new()

func _ready():
	terrains.append(-105.0)
	terrains.append(-23.0)
	terrains.append(-5.0)
	terrains.append(0)
	terrains.append(22.0)
	terrains.append(45.0)
	terrains.append(57.0)
	terrains.append(60.0)
	terrains.append(136.0)
	terrains.append(140.0)
	
	_output_terrain_heights()

	terrains_sprites.append(Vector2(6,77))
	terrains_sprites.append(Vector2(18,77))
	terrains_sprites.append(Vector2(2,18))
	terrains_sprites.append(Vector2(2,1)) # Vector2(6,1),Vector2(1,29),Vector2(2,29),Vector2(1,30),Vector2(2,30)
	terrains_sprites.append(Vector2(13,24))  # Vector2(14,24),Vector2(15,24),Vector2(16,24),
	terrains_sprites.append(Vector2(6,54)) # Vector2(7,54),Vector2(8,54),Vector2(9,54)
	terrains_sprites.append(Vector2(1,39)) # Vector2(2,39),Vector2(3,39),Vector2(4,39)
	terrains_sprites.append(Vector2(49,49))
	terrains_sprites.append(Vector2(10,3))
	terrains_sprites.append(Vector2(10,3))

	moisture.seed = -686559431 #randi()
	temperature.seed = -175673643 #randi()
	# altitude.seed = 778520879 #randi()
	terrain_randomizer.seed = altitude.seed
	altitude.frequency = 0.0013

	generate_chunk(player.position)
	_timer = Timer.new()
	add_child(_timer)

	_timer.timeout.connect(_on_Timer_timeout)
	_timer.set_wait_time(0.5)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()

	# water_timer = Timer.new()
	# add_child(water_timer)

	# water_timer.timeout.connect(animate_stuff)
	# water_timer.set_wait_time(1)
	# water_timer.set_one_shot(false) # Make sure it loops
	# water_timer.start()

	var player_move_timer = Timer.new()
	add_child(player_move_timer)

	player_move_timer.timeout.connect(move_player)
	player_move_timer.set_wait_time(0.05)
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

	#Clear all tiles in the window for adjustments
	for x in range(width):
		for y in range(height):
			var coords = Vector2i(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)
			var alt = altitude.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*150
			var atlas_coords
			set_cell(0, coords,0, Vector2i(-1,-1), 0 )

	for x in range(width):
		for y in range(height):
			var coords = Vector2i(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)
			var alt = altitude.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*150
			var atlas_coords

			#if(get_cell_atlas_coords(0,coords,false) == Vector2i(-1,-1)):
			for ground in terrains.size()-1:
				# print("first ground: "+str(ground))
				# A cell doesn't exist at these coordinates, so 
				# we're creating one
				# print("ground: "+str(float(terrains[ground])))
				# print("alt "+str(alt))
				# print("terrains[ground]: "+str(terrains_sprites[ground]))
				if(alt>=terrains[ground] and alt<terrains[ground+1]):
					if(alt>highest):
						highest = alt
						print("highest: "+str(highest))
						print("lowest: "+str(lowest))
					if(alt<lowest):
						lowest = alt
						print("highest: "+str(highest))
						print("lowest: "+str(lowest))
						
					atlas_coords = Vector2(terrains_sprites[ground])
					set_cell(0, coords,0, atlas_coords, 0 )
					break
		#else:
		#	pass;

func _adjust_0(value):
	print(value)
	terrains[0] = value
	generate_chunk(player.position)
	pass;
	
func _adjust_1(value):
	print(value)
	terrains[1] = value
	generate_chunk(player.position)
	pass;
	
func _adjust_2(value):
	print(value)
	terrains[2] = value
	generate_chunk(player.position)
	pass;
	
func _adjust_3(value):
	print(value)
	terrains[3] = value
	generate_chunk(player.position)
	pass;
	
func _adjust_4(value):
	print(value)
	terrains[4] = value
	generate_chunk(player.position)
	pass;
	
func _adjust_5(value):
	print(value)
	terrains[5] = value
	generate_chunk(player.position)
	pass;
	
func _adjust_6(value):
	print(value)
	terrains[6] = value
	generate_chunk(player.position)
	pass;
	
func _adjust_7(value):
	print(value)
	terrains[7] = value
	generate_chunk(player.position)
	pass;

func _adjust_8(value):
	print(value)
	terrains[8] = value
	generate_chunk(player.position)
	pass;

func _adjust_9(value):
	print(value)
	terrains[9] = value
	generate_chunk(player.position)
	pass;
	
func _adjust_granularity(value):
	print(value)
	granularity = value
	generate_chunk(player.position)
	_output_terrain_heights()
	pass;

func _adjust_moisture_seed(value):
	altitude.seed = value
	print("altitude.seed: "+str(altitude.seed))
	generate_chunk(player.position)

	# temperature.seed = -175673643 #randi()
	# altitude.seed = 778520879 #randi()
	# terrain_randomizer.seed = altitude.seed
	# altitude.frequency = 0.0013
	
func _output_terrain_heights():
	print("terrains.append("+str(terrains[0])+")")
	print("terrains.append("+str(terrains[1])+")")
	print("terrains.append("+str(terrains[2])+")")
	print("terrains.append("+str(terrains[3])+")")
	print("terrains.append("+str(terrains[4])+")")
	print("terrains.append("+str(terrains[5])+")")
	print("terrains.append("+str(terrains[6])+")")
	print("terrains.append("+str(terrains[7])+")")
	print("terrains.append("+str(terrains[8])+")")
	print("terrains.append("+str(terrains[9])+")")


# func generate_chunk2(passed_position):
# 	var tile_pos = local_to_map(passed_position)
# 	altitude.frequency = granularity
# 	for x in range(width):
# 		for y in range(height):
# 			var coords = Vector2i(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)
# 			var alt = altitude.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*150
# 			var atlas_coords
# 			# print("Alt: "+str(alt))
# 			# print("Alt: "+str(alt))
# 			# 1,9 Grass
# 			# 2,33 Water
# 			#print(alt)
# 			if(get_cell_atlas_coords(0,coords,false) == Vector2i(-1,-1)):
				
# 				for ground in terrains:
# 					# A cell doesn't exist at these coordinates, so 
# 					# we're creating one
# 					if(alt>=ground and alt<ground+1):
# 						atlas_coords = Vector2(6,77)
# 						set_cell(0, coords,0, atlas_coords, 0 )
# 					#Semi-deep water
# 					if(alt>=ground and alt<ground+1):
# 						atlas_coords = Vector2(18,77)
# 						set_cell(0, coords,0, atlas_coords, 0 )
# 					# Shallow water

# 				# Deep water
# 				if(alt>=deepest_water and alt<shallow_water):
# 					atlas_coords = Vector2(6,77)
# 					set_cell(0, coords,0, atlas_coords, 0 )
# 				#Semi-deep water
# 				if(alt>=shallow_water and alt<very_shallow_water):
# 					atlas_coords = Vector2(18,77)
# 					set_cell(0, coords,0, atlas_coords, 0 )
# 				# Shallow water
# 				if(alt>=very_shallow_water and alt<sandy_beach):
# 					var t = Time.get_ticks_msec()
# 					if((t/1000)%2==0):
# 						atlas_coords = Vector2(2,18)
# 						set_cell(0, coords,0, atlas_coords, 0 )
# 					else:
# 						atlas_coords = Vector2(6,18)
# 						set_cell(0, coords,0, atlas_coords, 0 )					
				

# 				#Sand
# 				if(alt>=sandy_beach and alt<grassland):
# 					# Trees....let's seed a terrain_randomizer for reporduceable 
# 					var sand = terrain_randomizer.randi_range(0,1)
# 					#print("sand: "+str(sand))
# 					match sand:
# 						0:
# 							atlas_coords = Vector2(2,1)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 						1:
# 							atlas_coords = Vector2(6,1)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 					sand = terrain_randomizer.randi_range(0,50)
# 					#print("sand: "+str(sand))
# 					match sand:
# 						0:
# 							atlas_coords = Vector2(1,29)
# 							set_cell(1, coords+Vector2i(-1.0,0),1, atlas_coords, 0 )
# 							atlas_coords = Vector2(2,29)
# 							set_cell(1, coords,1, atlas_coords, 0 )
# 							atlas_coords = Vector2(1,30)
# 							set_cell(1, coords+Vector2i(-1.0,1.0),1, atlas_coords, 0 )
# 							atlas_coords = Vector2(2,30)
# 							set_cell(1, coords+Vector2i(0.0,1.0),1, atlas_coords, 0 )
# 				if(alt>=grassland and alt<semi_forested):
# 					var sand = terrain_randomizer.randi_range(0,3)
# 					#print("sand: "+str(sand))
# 					match sand:
# 						0:
# 							atlas_coords = Vector2(13,24)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 						1:
# 							atlas_coords = Vector2(14,24)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 						2:
# 							atlas_coords = Vector2(15,24)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 						3:
# 							atlas_coords = Vector2(16,24)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 					# Flowers
# 					var flowers = terrain_randomizer.randi_range(0,50)
# 					match flowers:
# 						0:
# 							atlas_coords = Vector2(1,1)
# 							set_cell(1, coords,1, atlas_coords, 0 )
# 						1:
# 							atlas_coords = Vector2(3,1)
# 							set_cell(1, coords,1, atlas_coords, 0 )						
# 					var settlements = terrain_randomizer.randi_range(0,15000)
# 					#Settlements
# 					match settlements:
# 						0:
# 							var sprite = Sprite2D.new()
# 							sprite.texture = load("res://assets/spritesheets/overworld_tiles.sprites/Tiny_Constructions_16.tres")
# 							add_child(sprite)
# 							sprite.position = map_to_local(coords)
# 						1:
# 							var sprite = Sprite2D.new()
# 							sprite.texture = load("res://assets/spritesheets/overworld_tiles.sprites/Tiny_Constructions_22.tres")
# 							add_child(sprite)
# 							sprite.position = map_to_local(coords)
# 						2:
# 							var sprite = Sprite2D.new()
# 							sprite.texture = load("res://assets/spritesheets/overworld_tiles.sprites/Tiny_Constructions_24.tres")
# 							add_child(sprite)
# 							sprite.position = map_to_local(coords)
# 						3:
# 							var sprite = Sprite2D.new()
# 							sprite.texture = load("res://assets/spritesheets/overworld_tiles.sprites/Tiny_Constructions_17.tres")
# 							add_child(sprite)
# 							sprite.position = map_to_local(coords)
# 				if(alt>=semi_forested and alt<forest):
# 					# Trees....let's seed a terrain_randomizer for reporduceable 
# 					var tree = terrain_randomizer.randi_range(0,3)
# 					#print("tree: "+str(tree))
# 					match tree:
# 						0:
# 							atlas_coords = Vector2(6,54)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 						1:
# 							atlas_coords = Vector2(7,54)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 						2:
# 							atlas_coords = Vector2(8,54)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 						3:
# 							atlas_coords = Vector2(9,54)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 				if(alt>=forest and alt<snow):
# 					# Trees....let's seed a terrain_randomizer for reporduceable 
# 					var tree = terrain_randomizer.randi_range(0,3)
# 					#print("tree: "+str(tree))
# 					match tree:
# 						0:
# 							atlas_coords = Vector2(1,39)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 						1:
# 							atlas_coords = Vector2(2,39)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 						2:
# 							atlas_coords = Vector2(3,39)
# 							set_cell(0, coords,0, atlas_coords, 0 )
# 						3:
# 							atlas_coords = Vector2(4,39)
# 							set_cell(0, coords,0, atlas_coords, 0 )

# 				if(alt>=snow and alt<mountains):
# 					atlas_coords = Vector2(49,49)
# 					set_cell(0, coords,0, atlas_coords, 0 )
# 				if(alt>=mountains and alt<mountains2):
# 					atlas_coords = Vector2(10,3)
# 					set_cell(0, coords,0, atlas_coords, 0 )
# 			else:
# 				pass;
				
# func animate_stuff():
# 	#var t = Time.get_ticks_msec()
# 	var tile_pos = local_to_map(player.position)
# 	altitude.frequency = granularity
# 	for x in range(width):
# 		for y in range(height):
# 			var coords = Vector2i(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)
# 			var alt = altitude.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*150
# 			var atlas_coords
# 			# Deep water
# 			if(alt>=deepest_water and alt<shallow_water):
# 				var tree = terrain_randomizer.randi_range(0,1)
# 				#print("tree: "+str(tree))
# 				match tree:
# 					0:
# 						atlas_coords = Vector2(6,77)
# 						set_cell(0, coords,0, atlas_coords, 0 )
# 					1:
# 						atlas_coords = Vector2(2,77)
# 						set_cell(0, coords,0, atlas_coords, 0 )
# 			#Semi-deep water
# 			if(alt>=shallow_water and alt<very_shallow_water):
# 				var tree = terrain_randomizer.randi_range(0,1)
# 				#print("tree: "+str(tree))
# 				match tree:
# 					0:
# 						atlas_coords = Vector2(18,77)
# 						set_cell(0, coords,0, atlas_coords, 0 )
# 					1:
# 						atlas_coords = Vector2(22,77)
# 						set_cell(0, coords,0, atlas_coords, 0 )
# 			# Shallow water
# 			if(alt>=very_shallow_water and alt<sandy_beach):
# 				var tree = terrain_randomizer.randi_range(0,1)
# 				#print("tree: "+str(tree))
# 				match tree:
# 					0:
# 						atlas_coords = Vector2(2,18)
# 						set_cell(0, coords,0, atlas_coords, 0 )
# 					1:
# 						atlas_coords = Vector2(6,18)
# 						set_cell(0, coords,0, atlas_coords, 0 )

# func animate_stuff2():
	# var t = Time.get_ticks_msec()
	# var tile_pos = local_to_map(player.position)
	# altitude.frequency = granularity
	# for x in range(width):
	# 	for y in range(height):
	# 		var coords = Vector2i(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)
	# 		var alt = altitude.get_noise_2d(tile_pos.x-width/2.0 + x, tile_pos.y-height/2.0 + y)*150
	# 		var atlas_coords
	# 		# Deep water
	# 		if(alt>=deepest_water and alt<shallow_water):
	# 			if((t/1000)%2==0):
	# 				atlas_coords = Vector2(6,77)
	# 				set_cell(0, coords,0, atlas_coords, 0 )
	# 			else:
	# 				atlas_coords = Vector2(2,77)
	# 				set_cell(0, coords,0, atlas_coords, 0 )			
	# 		#Semi-deep water
	# 		if(alt>=shallow_water and alt<very_shallow_water):
	# 			if((t/1000)%2==0):
	# 				atlas_coords = Vector2(18,77)
	# 				set_cell(0, coords,0, atlas_coords, 0 )
	# 			else:
	# 				atlas_coords = Vector2(22,77)
	# 				set_cell(0, coords,0, atlas_coords, 0 )		
	# 		# Shallow water
	# 		if(alt>=very_shallow_water and alt<sandy_beach):
	# 			if((t/1000)%2==0):
	# 				atlas_coords = Vector2(2,18)
	# 				set_cell(0, coords,0, atlas_coords, 0 )
	# 			else:
	# 				atlas_coords = Vector2(6,18)
	# 				set_cell(0, coords,0, atlas_coords, 0 )					
