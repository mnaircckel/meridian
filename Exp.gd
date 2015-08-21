
extends Label

var player
var level
var this_level_exp
var next_level_exp

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	player = get_tree().get_root().get_node("World").get_node("Player")
	level = player.get_level()
	this_level_exp = player.get_levels_by_exp()[level-1]
	next_level_exp = player.get_levels_by_exp()[level]
	set_text("Experience: \n" + str(player.get_experience()-this_level_exp) + "/" + str(next_level_exp-this_level_exp))

