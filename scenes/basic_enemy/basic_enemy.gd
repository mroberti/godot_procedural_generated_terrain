extends CharacterBody2D
class_name BasicEnemy
var status = "wander"
var animations
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("monsters")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if status=="wander":
		move_and_slide()
		if velocity.x > 0 and velocity.y > 0 :
			$AnimationPlayer.play("down_right")
		elif velocity.x < 0 and velocity.y > 0 :
			$AnimationPlayer.play("down_left")	
		elif velocity.x > 0 and velocity.y < 0 :
			$AnimationPlayer.play("up_right")	
		elif velocity.x < 0 and velocity.y < 0 :
			$AnimationPlayer.play("up_left")

func random_idle():
	var num = randi_range ( 0,3 )
	if(num==0):
		$AnimationPlayer.play("idle_down_right")
	elif(num==1):
		$AnimationPlayer.play("idle_down_left")
	elif(num==2):
		$AnimationPlayer.play("idle_up_right")
	elif(num==3):
		$AnimationPlayer.play("idle_up_left")
