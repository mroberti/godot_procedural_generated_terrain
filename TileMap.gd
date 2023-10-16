extends TileMap

var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()
var width = 26
var height = 30
const city_icon = preload("res://scenes/village.tscn")
var time_passed = 0
var calls_per_sec = 1
var time_for_one_call = 1 / calls_per_sec 

@onready var player = $Player

func _ready():
	moisture.seed = -686559431 #randi()
	temperature.seed = -175673643 #randi()
	altitude.seed = 778520879 #randi()
	altitude.frequency = 0.001
	scrnOutput.print("Hello World!")
	scrnOutput.print("\n\nBIONIC VISUAL CORTEX TERMINAL\nCATALOG #075/kfb\n43MM O.D. F/0.95\nZOOM RATION:20.1 TO 1\n2135 LINE 60 HZ\nEXTENDED CHROMATIC RESPONSE\nCLASS JC  [pulse freq=7.0 height=0.0][pulse color=#FF0000 freq=7.0]CLASSIFIED[/pulse][/pulse]\n\n BIONIC NEURO-LINK\nBIPEDAL ASSEMBLY\nCATALOG #914 PAH\n
	NEURO FEEDBACK TERMINATED\nPOWER SUPPLY:\nATOMIC TYPE AED-9A\n4920 WATT CONTINUOS DUTY\n\n[pulse freq=7.0 height=0.0][pulse color=#FF0000 freq=7.0]CLASSIFIED[/pulse][/pulse]\nNOMINAL DOUBLE GAIN\nOVERLOAD FOLLOWER\n2100 WATT RESERVE\nINTERMITTENT DUTY\nCLASS CC")


func _process(delta):
	time_passed += delta

	if time_passed >= time_for_one_call:
		scrnOutput.print(str(Time.get_ticks_msec()))
		time_passed -= time_for_one_call 
	var guards = get_tree().get_nodes_in_group("monsters")
	for temp_monster in guards:
		generate_chunk(temp_monster.position)
	

func generate_chunk(position):
	var tile_pos = local_to_map(position)
				
	for x in range(width):
		for y in range(height):
			var coords = Vector2i(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)
			var moist = moisture.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
			var temp = temperature.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*10
			var alt = altitude.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y-height/2 + y)*150
			var atlas_coords = Vector2(3 if alt < 2 else round((moist + 10) / 5), round((temp + 10) / 5))
			set_cell(0, coords,1, atlas_coords, 0 )
