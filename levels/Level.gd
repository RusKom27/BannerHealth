extends Node2D

onready var knight = $Knight
onready var camera = $Camera

func _input(event):
	if (event.is_action_pressed("ui_cancel")):
		print("level")
		get_tree().paused = !get_tree().paused
		$Camera/PauseUI.visible = !$Camera/PauseUI.visible
