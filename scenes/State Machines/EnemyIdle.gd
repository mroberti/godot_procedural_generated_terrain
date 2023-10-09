extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D

var player : CharacterBody2D

var move_direction : Vector2
var idle_time : float

func randomize_idle():
	enemy.status = "idle"
	enemy.random_idle_animation()
	idle_time = randf_range(1,3)
	
func Enter():
	print("Idle State Entered")
	player = get_tree().get_first_node_in_group("player")
	enemy.random_idle_animation()
	
func Update(delta:float):
	if idle_time > 0:
		idle_time -= delta
	else:
		randomize_idle()
