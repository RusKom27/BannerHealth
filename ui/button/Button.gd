extends TextureButton

export var text = ""

onready var label = $Label


func _ready():
	label.text = text



