extends Node2D

onready var knight = $Knight
onready var camera = $Camera
onready var audio_player = $AudioStreamPlayer

func _ready():
	audio_player.stream = Global.game_music
	audio_player.play()
	knight.killable.connect("death", self, "e")

func e():
	audio_player.stream = Global.game_over_music
	audio_player.play()
	$Camera/GameOverUI.visible = true
		

func _input(event):
	if (event.is_action_pressed("ui_cancel") and !$Camera/GameOverUI.visible):
		print("level")
		get_tree().paused = !get_tree().paused
		$Camera/PauseUI.visible = !$Camera/PauseUI.visible
