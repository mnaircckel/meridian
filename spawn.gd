extends Node2D

var spawn_timer = 0
var spawn_interval = 3.8
var min_spawn_interval = .2
var current_spawn_interval = 0

var campfire_safe_zone = 380
var angle_var = 2*PI
var spawn_distance = 1300
var spawn_scalar = 5000

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):

	spawn_timer += delta
		
	var spawn_direction = get_parent().get_node("Player").get_rot()-PI/2+rand_range(-1,1)*angle_var
	var spawn_offset = Vector2(cos(spawn_direction),-sin(spawn_direction)).normalized()*spawn_distance
	
	var player = get_tree().get_root().get_node("World").get_node("Player")

	var delta_x = player.get_pos().x
	var delta_y = player.get_pos().y
	
	var distance = sqrt(pow(delta_x,2)+pow(delta_y,2))
	
	if distance < campfire_safe_zone:
		current_spawn_interval = 0
	else:
		current_spawn_interval = spawn_interval-sqrt((distance/spawn_scalar))
	
	if current_spawn_interval < .2 and current_spawn_interval != 0:
		current_spawn_interval = .2

	if spawn_timer > current_spawn_interval and current_spawn_interval != 0:
		spawn_timer = 0
		var new_monster = get_node("Zombie").duplicate()
		new_monster.set_alive(true)
		new_monster.show()
		new_monster.set_z(-1)
		var monster_position = get_parent().get_node("Player").get_pos()+spawn_offset
		new_monster.set_pos(monster_position)
		get_tree().get_root().add_child(new_monster)
		


