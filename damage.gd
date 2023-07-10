extends Node

var weapons = {}
var weapon_subset = "weapons"
# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_file(path):
	var file = path
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	var weapon_names = json_as_dict.keys()
	for i in weapon_names:
		print(i)
	return json_as_dict


func select_random_weapon(theWeaponType) -> String:
	var weapon_names = weapons[str(theWeaponType)].keys()
	var random_index = randi() % weapon_names.size()
	return weapon_names[random_index]

func _ready() -> void:
	weapons = load_file("res://all_weapons.json")
	
	for i in range(6):
		# Select a random weapon from the collection
		var weapon_name = select_random_weapon(weapon_subset)

		# Retrieve the weapon details
		var weapon = weapons[weapon_subset][weapon_name]
		var description = weapon["description"]

		# Simulate attacker and target objects with positions
		var attacker = {
			"position": Vector2(0, 0)
		}
		var target = {
			"position": Vector2(100, 100)
		}

		# Calculate the distance between attacker and target
		var distance = attacker.position.distance_to(target.position)
		var weapon_range = int(weapon["range"])

		# Check if the distance is within the weapon's range
		if distance <= weapon_range:
			# Calculate and display the damage
			var calculated_damage = calculate_damage(weapon)
			print("Hit. Damage:", calculated_damage)
		else:
			print("Miss")



func calculate_damage(weapon: Dictionary) -> int:
	var damage_str = weapon["damage"]

	# Extract the number of dice and sides from the damage string
	var num_dice = 1
	var dice_sides = 6  # Default to 6-sided dice if not specified
	if damage_str.find("d") != -1:
		var parts = damage_str.split("d")
		num_dice = int(parts[0])
		dice_sides = int(parts[1])
	else:
		num_dice = int(damage_str)

	# Roll the dice for each die and sum the results
	var total_damage = 0
	for i in range(num_dice):
		total_damage += roll_dice(dice_sides)

	return total_damage

func roll_dice(sides: int) -> int:
	return randi() % sides + 1
