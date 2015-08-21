
extends KinematicBody2D

export var player_speed = 375
var current_speed = Vector2()

var energy_drain = 45

var walking_timer = 0
var walking_interval = .12

export var max_health = 100
var health

export var max_energy = 100
var energy

var is_alive = true

var is_spriting = false
export var sprint_speed = 2
var sprint_multi = 1

var sprite_index = 0

func get_health():
	return health

func get_max_health():
	return max_health

func get_energy():
	return energy

func get_max_energy():
	return max_energy
	
func heal_damage(amount):
	health += amount
	if health > max_health:
		health = max_health

func take_damage(amount):
	get_node("Sounds").play("hurt")
	health -= amount
	check_alive()

func check_alive():
	if health <= 0:
		health = 0
		is_alive = false
		get_tree().set_pause(true)

func _ready():
	energy = max_energy
	health = max_health
	set_fixed_process(true)
	
func _fixed_process(delta):
	
	check_alive()
	
	walking_timer += delta 
	
	if walking_timer > walking_interval:
		walking_timer = 0
		get_node("Sprite").set_frame(sprite_index)
		sprite_index += 1
		if sprite_index > 4:
			sprite_index = 0
	
	if Input.is_action_pressed("sprint"):
		energy -= energy_drain*delta
		if energy < 0:
			energy = 0
			sprint_multi = 1
		else:
			sprint_multi = sprint_speed
	else:
		energy += energy_drain/3.5*delta
		if energy > max_energy:
			energy = max_energy
		sprint_multi = 1
	
	
	if Input.is_action_pressed("left"):
		current_speed.x = -1
	elif Input.is_action_pressed("right"):
		current_speed.x = 1
	else:
		current_speed.x = 0
	
	if Input.is_action_pressed("up"):
		current_speed.y = -1
	elif Input.is_action_pressed("down"):
		current_speed.y = 1
	else:
		current_speed.y = 0

	if is_colliding():
        var n = get_collision_normal()
        var direction = n.slide(current_speed.normalized())
        move(direction*player_speed*delta)
	move(current_speed.normalized()*player_speed*sprint_multi*delta)
	get_parent().get_node("Pointer").set_pos(get_viewport().get_mouse_pos()-Vector2(960,540)+get_pos())
	look_at(get_viewport().get_mouse_pos()-Vector2(960,540)+get_pos())
	
	


