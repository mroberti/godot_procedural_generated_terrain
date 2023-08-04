extends Node
@onready var player = $"../Player"

@export var basic_enemy_scene: PackedScene	
const SPAWN_RADIUS = 330
# Called when the node enters the scene tree for the first time.
func _ready():
	for n in range(1):
		var tile_pos = get_parent().local_to_map(player.position)
		var enemy = basic_enemy_scene.instantiate() as CharacterBody2D
		get_parent().call_deferred("add_child", enemy)
		var rand_x = randi_range ( -5,5 )
		var rand_y = randi_range ( -5,5 )
		enemy.position = get_parent().map_to_local (Vector2i(tile_pos.x-rand_x,tile_pos.y-rand_y))
		print("Adding at "+str(get_parent().local_to_map(enemy.position)))

func _move_enemies():
	get_parent().get_tree().call_group("monsters", "_move_randomly")
