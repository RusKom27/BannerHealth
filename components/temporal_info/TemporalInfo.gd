extends Node2D

onready var animation_player = $AnimationPlayer
onready var label = $Label

var text = ""

func _ready():
	label.text = text
	animation_player.play("start")
	animation_player.connect("animation_finished", self, "_on_animation_finished")

func _on_animation_finished(anim_name):
	if(anim_name == "start"):
		animation_player.play("end")
	if(anim_name == "end"):
		queue_free()



