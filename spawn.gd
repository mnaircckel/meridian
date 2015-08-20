extends Node2D

var spawn_timer = 0
var spawn_interval = 2.9

var angle_var = PI/2
var spawn_distance = 1500

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):

	var spawn_direction = get_parent().get_node("Player").get_rot()-PI/2+rand_range(-1,1)*angle_var
	var spawn_offset = Vector2(cos(spawn_direction),-sin(spawn_direction)).normalized()*spawn_distance
	
	spawn_timer += delta
	
	if spawn_timer > spawn_interval:
		spawn_timer = 0
		var new_monster = get_node("Zombie").duplicate()
		new_monster.set_alive(true)
		new_monster.show()
		var monster_position = get_parent().get_node("Player").get_pos()+spawn_offset
		new_monster.set_pos(monster_position)
		get_tree().get_root().add_child(new_monster)
		


