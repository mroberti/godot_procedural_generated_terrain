extends CharacterBody2D
class_name BasicEnemy2
var status = "wander"
var animations
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ready")
	add_to_group("monsters")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_slide()
	if status=="wander":
		if velocity.x > 0 and velocity.y > 0 :
			$EnemySprite.play("walk_down_right")
		elif velocity.x < 0 and velocity.y > 0 :
			$EnemySprite.play("walk_down_left")	
		elif velocity.x > 0 and velocity.y < 0 :
			$EnemySprite.play("walk_up_right")	
		elif velocity.x < 0 and velocity.y < 0 :
			$EnemySprite.play("walk_up_left")

func _attack(target):
	var direction = target.global_position - global_position
	#print("Distance: "+str(direction.length() ))
	if direction.x > 0 and direction.y > 0 :
		$EnemySprite.play("attack_down_right")
	elif direction.x < 0 and direction.y > 0 :
		$EnemySprite.play("attack_down_left")	
	elif direction.x > 0 and direction.y < 0 :
		$EnemySprite.play("attack_up_right")	
	elif direction.x < 0 and direction.y < 0 :
		$EnemySprite.play("attack_up_left")

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
