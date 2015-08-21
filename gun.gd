
extends Node2D

export var fire_rate = .4
export var bullet_speed = 1000
export var damage = 25

var variance = PI/80

var knockback = 18


# Angles fun fires at - default is 0, or straight forward
var angles = [0]

var fire_timer = 0
var player_rot
var player_pos

var forward_offset = 105

# Bullets are represented as the object and a timer keeping track of how long that have been alive
# [bullet, timer]
var bullets = []
var old_bullets = []


func shoot(shoot_angle):
	player_pos = get_parent().get_pos()
	player_rot = get_parent().get_rot()
	
	var new_bullet = RigidBody2D.new()
	var new_bullet_sprite = Sprite.new()
	
	var angle = (player_rot-PI/2) + shoot_angle + (rand_range(-1,1)*variance)
	var direction_vector = Vector2(cos(angle),-sin(angle)).normalized()
	var location_vector = player_pos+direction_vector*forward_offset
	
	var collider = RectangleShape2D.new()
	collider.set_extents(Vector2(15,15))
	
	new_bullet.set_pos(location_vector)
	new_bullet.set_rot(player_rot)
	
	new_bullet_sprite.set_scale(Vector2(.5,.5))
	new_bullet_sprite.set_texture(load("res://textures/bullet.png"))
	new_bullet.add_child(new_bullet_sprite)
	
	# Mass determines damage
	new_bullet.set_mass(damage)
	
	new_bullet.add_shape(collider)
	new_bullet.set_gravity_scale(0)
	new_bullet.set_linear_velocity(direction_vector * bullet_speed)
	
	get_parent().move(-direction_vector * knockback)
	
	get_node("Sounds").play("fire")
	get_parent().get_node("Camera2D").set_pos(Vector2(get_pos().x+rand_range(-8,8),get_pos().y+rand_range(-8,8)))
	bullets.push_back([new_bullet,0])
	new_bullet.add_to_group("projectiles")
	get_tree().get_root().get_node("World").add_child(new_bullet)
	
	
func _ready():
	set_process(true)

func _process(delta):

	fire_timer += delta
	
	old_bullets = []
	for bullet in bullets:
		bullet[1] += delta
		if bullet[1] > 2:
			old_bullets.push_back(bullet)
	
	for old_bullet in old_bullets:
		bullets.remove(bullets.find(old_bullet))
		get_tree().get_root().get_node("World").remove_child(old_bullet[0])
	
	if Input.is_action_pressed("fire"):
		if fire_timer > fire_rate:
			fire_timer = 0
			for shoot_angle in angles:
				shoot(shoot_angle)


