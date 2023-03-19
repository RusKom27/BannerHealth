extends Area2D

onready var main_menu_res = load("res://ui/main_menu.tscn")


func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: KinematicBody2D):
	if (body and body.is_in_group("Player")):
		get_tree().change_scene_to(main_menu_res)
		get_tree().paused = false
