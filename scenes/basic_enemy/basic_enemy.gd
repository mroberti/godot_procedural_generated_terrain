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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

