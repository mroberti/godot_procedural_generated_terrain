extends Panel
@onready var monster = $".."
@onready var health_bar = $health_bar


func update_color():
	var health_percent = calcPercentage(monster.health,100.0)
	#print("Health percent: "+str(health_percent))
	var health_color_fade := get_health_color_fade_by_percent(health_percent)
	set_modulate(health_color_fade)
	health_bar.value = monster.health

func calcPercentage(partialValue, totalValue):
	return float(partialValue) / totalValue

func get_health_color_fade_by_percent(percent: float) -> Color:
	var r: float = min(2 - (percent / 0.5), 1.0)
	var g: float = min(percent / 0.5, 1.0)
	return Color(r, g, 0.0)
