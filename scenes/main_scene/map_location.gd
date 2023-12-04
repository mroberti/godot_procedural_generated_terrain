extends Area2D

@onready var tile_map = $".."
var map_location_name = "Town"

func _ready():
	position = tile_map.map_to_local(Vector2i(-25,-30))
	var new_texture = preload("res://assets/spritesheets/overworld_tiles.sprites/Tiny_Constructions_02.tres")
	$Sprite2D.texture = new_texture
	map_location_name = map_location_name + " "+str(randi_range(0,50))
	print("Created "+map_location_name)

func _process(delta):
	pass

func _on_body_entered(body):
	print(body.name + " entered this town: "+map_location_name)
	ToastParty.show({
		"text": "🥑"+body.name + " entered this town: "+map_location_name+"🤟",       # Text (emojis can be admit)
		"bgcolor": Color(0, 0, 0, 0.7), # Background Color
		"color": Color(1, 1, 1, 1),     # Text Color
		"gravity": "bottom",               # top or bottom
		"direction": "right",           # left or center or right
	})


func _on_body_exited(body):
	ToastParty.show({
		"text": "🥑"+body.name + " exited this town: "+map_location_name+"🤌",       # Text (emojis can be admit)
		"bgcolor": Color(0, 0, 0, 0.7), # Background Color
		"color": Color(1, 1, 1, 1),     # Text Color
		"gravity": "bottom",               # top or bottom
		"direction": "right",           # left or center or right
	})
