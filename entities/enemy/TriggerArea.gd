extends Area2D


var player_in: KinematicBody2D = null

func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")

func _on_body_entered(body: KinematicBody2D):
	if (body && body.is_in_group("Player")):
		player_in = body

func _on_body_exited(body: KinematicBody2D):
	if (body && body.is_in_group("Player")):
		player_in = null
