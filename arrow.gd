
extends Sprite

var campfire_location
var player_location

var delta_x
var delta_y

func _ready():
	set_process(true)
	
func _process(delta):
	campfire_location = Vector2(0,0)
	player_location = get_tree().get_root().get_node("World").get_node("Player").get_pos()
	
	delta_x = campfire_location.x-player_location.x
	delta_y = campfire_location.y-player_location.y
	
	set_rot(atan2(delta_x,delta_y))


