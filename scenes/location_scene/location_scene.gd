# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var _timer = Timer.new()
	add_child(_timer)

	_timer.timeout.connect(go_to_next_scene)
	_timer.set_wait_time(3.0)
	_timer.set_one_shot(true) # Make sure it loops
	_timer.start()

func go_to_next_scene():
	# Put save data stuff here. 
	get_tree().call_deferred("change_scene_to_file","res://scenes/main_scene/tile_map.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
