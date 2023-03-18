extends Control

onready var knight = get_parent().knight


func _physics_process(delta):
	if (!knight):
		knight = get_parent().knight
		return
	
