extends CharacterBody2D
class_name BasicEnemy
var status = "wander"
var animations
var move_distance = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Enemy Ready")
	add_to_group("monsters")
	#print(get_tree().get_nodes_in_group("monsters").size())


func random_idle_animation():
	var num = randi_range ( 0,3 )
	if(num==0):
		$EnemySprite.play("idle_down_right")
	elif(num==1):
		$EnemySprite.play("idle_down_left")
	elif(num==2):
		$EnemySprite.play("idle_up_right")
	elif(num==3):
		$EnemySprite.play("idle_up_left")

func _move_randomly(tile_map):
	# Let's move the monsters in one tile move
	# in random direction...
	var num = randi_range ( 0,3 )
	if(num==0):
		move_left(tile_map)
	elif(num==1):
		move_down(tile_map)
	elif(num==2):
		move_right(tile_map)
	elif(num==3):
		move_up(tile_map)

func move_left(tile_map):
	var direction = Vector2i(-move_distance,0)
	move_on_map(tile_map,direction)

func move_right(tile_map):
	var direction = Vector2i(move_distance,0)
	move_on_map(tile_map,direction)
	
func move_up(tile_map):
	var direction = Vector2i(0,-move_distance)
	move_on_map(tile_map,direction)

func move_down(tile_map):
	var direction = Vector2i(0,move_distance)
	move_on_map(tile_map,direction)

func move_on_map(tile_map,direction):
	var source_location = tile_map.local_to_map(position)
	var target_location = source_location + direction
	var target_map_location = tile_map.map_to_local(target_location)
	#print("Check result: "+str(check_valid_tile(tile_map,target_location)))
	if(check_valid_tile(tile_map,target_location)):
		tile_map.generate_chunk(position)
		position = tile_map.map_to_local(target_location)


func check_valid_tile(tile_map,target_location):
	var check = tile_map.get_cell_atlas_coords(0,target_location,false)
	#print(check)
	if(check != Vector2i(-1,-1)):
		var data = tile_map.get_cell_tile_data(0, target_location)
		return data.get_custom_data("Walkable")
	else:
		return false
