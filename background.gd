
extends TextureFrame

var scale_color = 40000
var scale_light = 65000

var red = .6
var green = .6
var blue = .6

var light = 1

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var player_pos = get_tree().get_root().get_node("World").get_node("Player").get_pos()

	red = .5+player_pos.x/scale_color
	blue = .5-player_pos.x/scale_color
	green = .5-player_pos.y/scale_color
	
	light = .8-max(pow(player_pos.x/scale_light,2),pow(player_pos.y/scale_light,2))
	if light < .15:
		light = .15
	
	var rgb = [red*light,green*light,blue*light]
	set_modulate(Color(rgb[0],rgb[1],rgb[2]))


