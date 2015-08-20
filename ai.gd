
extends KinematicBody2D

export var enemy_speed = 170
export var max_health = 100

export var damage = 4
var attack_distance = 140
var run_distance = 250

var attack_timer = 0
var attack_interval = .70

var health

var is_alive = false
var current_speed = Vector2(0,0)

var walking_timer = 0
var walking_interval = .2

var tracking_timer = 0
var tracking_interval = .5

var sprite_index = 0

var tracking_angle = PI/3
var current_tracking_angle = 0
var distance_speed_mod = 1200

var x_offset = -350
var y_offset = -350

var cull_distance = 4000


func set_alive(enable):
	is_alive = enable

func check_collisions(delta):
	if is_colliding():
		var n = get_collision_normal()
		var direction = n.slide(current_speed.normalized())
		move(direction*enemy_speed*delta)
		var collider = get_collider() 
		if collider in get_tree().get_nodes_in_group("projectiles"):
			get_tree().get_root().get_node("World").remove_child(collider)
			if is_alive:
				health -= collider.get_mass()
		
	
func update_anims():
	if walking_timer > walking_interval:
		walking_timer = 0
		get_node("Sprite").set_frame(sprite_index)
		sprite_index += 1
		if sprite_index > 4:
			sprite_index = 0

func track_player(delta):

	var player = get_tree().get_root().get_node("World").get_node("Player")
	var player_location = player.get_pos()
	
	var delta_x = player_location.x-get_pos().x
	var delta_y = player_location.y-get_pos().y
	
	var distance = sqrt(pow(delta_x,2)+pow(delta_y,2))
	var speed_modify = distance/distance_speed_mod
	
	if speed_modify < .3:
		speed_modify = .3
	if speed_modify > 1.4:
		speed_modify = 1.4
		
	walking_timer += delta
	tracking_timer += delta
	
	if tracking_timer > tracking_interval/speed_modify:
		
		tracking_timer = 0
		
		x_offset = -x_offset
		y_offset = -y_offset
		
		current_tracking_angle += rand_range(-1,1)*tracking_angle
		if abs(current_tracking_angle) > PI/3:
			current_tracking_angle = 0
		if distance < run_distance:
			current_tracking_angle = 0
	
	delta_x += x_offset*distance/distance_speed_mod
	delta_y += y_offset*distance/distance_speed_mod
	
	var angle = atan2(delta_x,delta_y)
	current_speed.x = cos(angle+PI/2+current_tracking_angle)
	current_speed.y = -sin(angle+PI/2+current_tracking_angle)
	
	set_rot(angle)
	attack_timer += delta
	if distance > cull_distance:
		get_parent().remove_child(self)
	elif distance > attack_distance:
		move(-current_speed.normalized()*enemy_speed/speed_modify*delta)
	else:
		if attack_timer > attack_interval:
			attack_timer = 0
			player.take_damage(damage)
		move(Vector2(0,0))

func check_health():
	if health <= 0:
		health = 0
		is_alive = false


func _ready():
	set_fixed_process(true)
	enemy_speed *= rand_range(.8,1.2)
	health = max_health

func _fixed_process(delta):
	check_collisions(delta)
	if is_alive:
		check_health()
		update_anims()
		track_player(delta)
	if !is_alive and health <= 0:
		#move(Vector2(0,0))
		# Temporary until dealth anim etc
		free()


