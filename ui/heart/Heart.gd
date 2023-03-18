extends Control

onready var animated_sprite = $AnimatedSprite

var half = false

func _ready():
	animated_sprite.connect("animation_finished", self, "_on_animation_finished")
	active()
	
func _on_animation_finished():
	if (animated_sprite.animation == "active"):
		animated_sprite.play("idle")
	if (animated_sprite.animation == "half_active"):
		animated_sprite.play("half_idle")

func active():
	if (half):
		animated_sprite.play("half_active")
	else:
		animated_sprite.play("active")
