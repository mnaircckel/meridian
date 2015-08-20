
extends Label

var pixels_per_meter = 228
var distance

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var player = get_tree().get_root().get_node("World").get_node("Player")

	var delta_x = player.get_pos().x
	var delta_y = player.get_pos().y
	
	var distance = int(sqrt(pow(delta_x,2)+pow(delta_y,2))/pixels_per_meter)
	
	set_text("Meters to Camp: " + str(distance))


