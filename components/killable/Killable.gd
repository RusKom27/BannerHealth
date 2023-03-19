extends Node2D

signal death
signal take_damage


onready var temporal_info_res = load("res://components/temporal_info/TemporalInfo.tscn")

onready var sfx_audio = $SFXAudio

var armor_buff = 0
var additional_armor = 0

export var health: float = 10
export var armor: float = 0.2



var armor_banners_count = 0
var health_banners_count = 0

func _physics_process(delta):
	additional_armor = health * armor_buff
	
func take_damage(damage):
	if (health > 0):
		var new_damage = clamp(damage - (armor + additional_armor), 0, INF)
		health -= new_damage
		emit_signal("take_damage")
		var temporal_info = temporal_info_res.instance()
		temporal_info.text = "-%.2f" % new_damage 
		add_child(temporal_info)
		health = clamp(health, 0, 30)
		sfx_audio.play_effect(Global.SFXEffect.TakeDamage)
		if (health == 0):
			emit_signal("death")
			return true
	return false

func add_health(value):
	health += value
	health_banners_count += 1
	var temporal_info = temporal_info_res.instance()
	temporal_info.text = "+%.2f health" % value
	sfx_audio.play_effect(Global.SFXEffect.Pickup)
	add_child(temporal_info)
	
func add_armor(value):
	armor_buff += value
	armor_banners_count += 1
	var temporal_info = temporal_info_res.instance()
	temporal_info.text = "+%.2f armor" % value
	sfx_audio.play_effect(Global.SFXEffect.Pickup)
	add_child(temporal_info)
