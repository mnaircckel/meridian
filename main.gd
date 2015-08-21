
extends Node2D

var gui_scene = load("res://gui.scn")
var gui = gui_scene.instance()

var background_scene = load("res://background.scn")
var background = background_scene.instance()

func _ready():
	OS.set_window_size(OS.get_screen_size())
	Input.set_mouse_mode(1)
	add_child(gui)
	add_child(background)


