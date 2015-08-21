
extends Node2D

var pause_timer = 0
var pause_interval = .15
var is_paused = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	pause_timer += delta
	if(Input.is_action_pressed("exit")):
		OS.get_main_loop().quit()

	if pause_timer > pause_interval:
		if Input.is_action_pressed("pause"):
			pause_timer = 0
			is_paused = !is_paused
			get_tree().set_pause(is_paused)



