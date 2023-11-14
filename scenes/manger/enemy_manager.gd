extends Node
@onready var player = $"../Player"
@onready var tile_map = $"../TileMap"
@export var basic_enemy_scene: PackedScene	
var SPAWN_RADIUS = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	# if(get_tree().get_nodes_in_group("monsters").size() < 20):
	# 	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	# 	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	# 	var enemy = basic_enemy_scene.instantiate() as Node2D
	# 	get_parent().call_deferred("add_child", enemy)
	# 	enemy.position = spawn_position
	# 	# Now convert the position value to map locaiton and
	# 	# put the enemy there. 
	# 	var loc1 = tile_map.local_to_map(enemy.position)
	# 	enemy.position = tile_map.map_to_local(loc1)
	# 	tile_map.generate_chunk(enemy.global_position)
	if(get_tree().get_nodes_in_group("monsters").size() < 5):
		for n in range(0,5):
			var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
			var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
			var enemy = basic_enemy_scene.instantiate() as Node2D
			get_parent().call_deferred("add_child", enemy)
			enemy.position = spawn_position
			# Now convert the position value to map locaiton and
			# put the enemy there. 
			var loc1 = tile_map.local_to_map(enemy.position)
			enemy.position = tile_map.map_to_local(loc1)
			tile_map.generate_chunk(enemy.global_position)
		
# func _move_enemies(the_map):
# 	print("getting here?")
# 	print(the_map.get_tree().get_nodes_in_group("monsters")[1].to_string())
# 	var guards = the_map.get_tree().get_nodes_in_group("monsters")
# 	for temp_monster in guards:
# 		temp_monster._move_randomly(get_parent())
