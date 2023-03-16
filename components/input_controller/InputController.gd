extends Node2D

var direction = Vector2(0,0)
var is_jump_pressed = false
var is_attack_pressed = false

func _physics_process(delta):
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	is_jump_pressed = Input.is_action_pressed("ui_jump")
	is_attack_pressed = false

func _input(event):
	if (event.is_action_pressed("ui_attack")):
		is_attack_pressed = true
