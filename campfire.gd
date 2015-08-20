
extends StaticBody2D

export var health_regen = 6
export var regen_distance = 380

var heal_timer = 0
var heal_interval = .6

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	heal_timer += delta

	var player = get_tree().get_root().get_node("World").get_node("Player")

	var delta_x = player.get_pos().x-get_pos().x
	var delta_y = player.get_pos().y-get_pos().y
	
	var distance = sqrt(pow(delta_x,2)+pow(delta_y,2))
	
	if distance < regen_distance:
		if heal_timer > heal_interval:
			heal_timer = 0
			player.heal_damage(health_regen)


