extends Control


onready var audio_player = $AudioStreamPlayer

func _ready():
	audio_player.stream = Global.menu_music
	audio_player.play()

