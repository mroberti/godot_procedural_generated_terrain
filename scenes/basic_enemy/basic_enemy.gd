extends CharacterBody2D
@onready var animations = $AnimationPlayer
var health = 100
@onready var tile_map = get_parent()
# Experimenting with SIN for position
# var time = 0
# var amplitude = 1.0
# var frequency = 48.0
# var offset = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():	
	var num = randi_range ( 0,3 )
	if(num==0):
		animations.play("down_right")
	elif(num==1):
		animations.play("down_left")
	elif(num==2):
		animations.play("up_right")
	elif(num==3):
		animations.play("up_left")
	add_to_group("monsters")


# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	# time += delta
# 	# var y = 0.0
# 	# y = sin(time * frequency) * amplitude + offset
# 	# position.y += y
# 	pass;

func _move_randomly():
	var num = randi_range ( 0,3 )
	var tile_pos = get_parent().local_to_map(position)
	#print("Move? "+str(tile_pos))
	if(num==0):
		# Left
		var direction = Vector2i(-1,0)
		move_on_map(direction)
		animations.play("down_left")
	elif(num==1):
		# Right
		var direction = Vector2i(1,0)
		move_on_map(direction)
		animations.play("down_right")
	elif(num==2):
		# Up
		var direction = Vector2i(0,-1)
		move_on_map(direction)
		animations.play("up_right")
	elif(num==3):
		# Down
		var direction = Vector2i(0,1)
		move_on_map(direction)
		animations.play("down_right")

func move_on_map(direction):
	var source_location = tile_map.local_to_map(position)
	var target_location = source_location + direction
	var target_map_location = tile_map.map_to_local(target_location)
	#print("Check result: "+str(check_valid_tile(target_location)))
	if(check_valid_tile(target_location)):
		position = tile_map.map_to_local(target_location)

func check_valid_tile(target_location):
	var data = tile_map.get_cell_tile_data(0, target_location)
	
	if(data.get_custom_data("custom_data_layer").contains("water")):
		return false
	else:
		return true
