extends TextureButton

enum ActionType {
	Continue,
	Restart,
	MainMenu,
	Start,
	ToggleSFX,
	ToggleMusic,
}

onready var main_menu_res = load("res://ui/main_menu.tscn")
onready var base_level_res = load("res://levels/base_level.tscn")

export var text = ""
export(ActionType) var action_type

onready var label = $Label
onready var sfx_audio = $SFXAudio


func _ready():
	label.text = text
	connect("pressed", self, "_on_pressed")
	match action_type:
		ActionType.ToggleMusic:
			$Cross.visible = AudioServer.is_bus_mute(2)
		ActionType.ToggleSFX:
			$Cross.visible = AudioServer.is_bus_mute(1)
	
func _on_pressed():
	sfx_audio.play_effect(Global.SFXEffect.ButtonPress)
	match action_type:
		ActionType.Continue:
			get_tree().paused = false
			get_parent().get_parent().get_parent().visible = false
		ActionType.MainMenu:
			get_tree().change_scene_to(main_menu_res)
			get_tree().paused = false
		ActionType.Start:
			get_tree().change_scene_to(base_level_res)
			get_tree().paused = false
		ActionType.Restart:
			get_tree().change_scene_to(base_level_res)
			get_tree().paused = false
		ActionType.ToggleMusic:
			AudioServer.set_bus_mute(2, !AudioServer.is_bus_mute(2))
			$Cross.visible = AudioServer.is_bus_mute(2)
		ActionType.ToggleSFX:
			AudioServer.set_bus_mute(1, !AudioServer.is_bus_mute(1))
			$Cross.visible = AudioServer.is_bus_mute(1)
		



