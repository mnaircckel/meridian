
extends TextureButton

var player

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	player = get_tree().get_root().get_node("World").get_node("Player")
	set_scale( Vector2(1.25*player.get_energy()/player.get_max_energy(),get_scale().y) )