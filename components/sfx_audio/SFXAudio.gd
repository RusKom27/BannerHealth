extends AudioStreamPlayer2D
class_name SFXAudio


func play_effect(effect):
	randomize()
	match effect:
		Global.SFXEffect.Attack:
			stream = Global.attack_sounds_res[randi() % 4]
		Global.SFXEffect.TakeDamage:
			stream = Global.take_damage_sounds_res[randi() % 4]
		Global.SFXEffect.ButtonPress:
			stream = Global.button_press_sounds_res[randi() % 4]
		Global.SFXEffect.Jump:
			stream = Global.jump_sounds_res[randi() % 4]
		Global.SFXEffect.Pickup:
			stream = Global.pickup_sounds_res[randi() % 4]
		Global.SFXEffect.Walk:
			stream = Global.walk_sounds_res[randi() % 4]
		
	play()
