extends AnimatedSprite

var current_animation = "default"

func _ready():
	connect("frame_changed", self, "_on_frame_changed")

func _on_frame_changed():
	play(current_animation)
