extends CharacterBody2D
# var buttons = {
# 	"left_held" = false,
# 	"right_held" = false,
# 	"up_held" = false,
# 	"down_held" = false
# }
@onready var tile_map = get_parent()

const SPEED = 700

func _ready():
	position = tile_map.map_to_local(Vector2i(-12,0))


func _input(event):
	velocity.x = Input.get_axis("ui_left", "ui_right")
	velocity.y = Input.get_axis("ui_up", "ui_down")
	velocity = velocity.normalized()*SPEED

	# if event.is_action_pressed("move_left") or event.is_action_pressed("ui_left"):
	# 	var direction = Vector2i(-1,0)
	# 	move_on_map(direction)
	# 	if not buttons.left_held:
	# 		buttons.left_held = true
	# elif event.is_action_released("move_left"):
	# 	buttons.left_held = false
		
	# if event.is_action_pressed("ui_right"):
	# 	var direction = Vector2i(1,0)
	# 	move_on_map(direction)
	# 	if not buttons.left_held:
	# 		buttons.left_held = true
	# elif event.is_action_released("ui_right"):
	# 	buttons.left_held = false
		
	# if event.is_action_pressed("ui_up"):
	# 	var direction = Vector2i(0,-1)
	# 	move_on_map(direction)
	# 	if not buttons.left_held:
	# 		buttons.left_held = true
	# elif event.is_action_released("ui_up"):
	# 	buttons.left_held = false
		
	# if event.is_action_pressed("ui_down"):
	# 	var direction = Vector2i(0,1)
	# 	move_on_map(direction)
	# 	if not buttons.left_held:
	# 		buttons.left_held = true
	# elif event.is_action_released("ui_down"):
	# 	buttons.left_held = false

func _physics_process(delta):
	# velocity.x = Input.get_axis("ui_left", "ui_right")
	# velocity.y = Input.get_axis("ui_up", "ui_down")
	# velocity = velocity.normalized()*SPEED
	move_and_slide()

func move_on_map(direction):
	var source_location = tile_map.local_to_map(position)
	var target_location = source_location + direction
	var target_map_location = tile_map.map_to_local(target_location)
	print("Check result: "+str(check_valid_tile(target_location)))
	if(check_valid_tile(target_location)):
		position = tile_map.map_to_local(target_location)

func check_valid_tile(target_location):
	var data = tile_map.get_cell_tile_data(0, target_location)
	
	return data.get_custom_data("custom_data_layer")
