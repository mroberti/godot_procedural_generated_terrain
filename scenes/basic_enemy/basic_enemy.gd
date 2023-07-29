extends CharacterBody2D
@onready var animations = $AnimationPlayer
var health = 100
	
	
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _move_randomly():
	var num = randi_range ( 0,3 )
	var tile_pos = get_parent().local_to_map(position)
	#print("Move? "+str(tile_pos))
	if(num==0):
		tile_pos.x -= 1
	elif(num==1):
		tile_pos.x += 1
	elif(num==2):
		tile_pos.y -= 1
	elif(num==3):
		tile_pos.y += 1
	position = get_parent().map_to_local(tile_pos)

