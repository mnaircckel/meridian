
extends Label

var player

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	player = get_tree().get_root().get_node("World").get_node("Player")
	set_text("Level: \n" + str(player.get_level()))



