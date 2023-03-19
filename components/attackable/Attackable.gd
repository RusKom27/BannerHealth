extends Area2D

signal attack_ready

onready var temporal_info_res = load("res://components/temporal_info/TemporalInfo.tscn")

onready var collision_shape = $CollisionShape2D
onready var attack_cooldown = $AttackCooldown
onready var sfx_audio = $SFXAudio

export var damage: float = 1
export var cooldown: float = 1

var attack_ready = true
var near_killables = []
var damage_buff = 0
var damage_banners_count = 0
var additional_damage = 0
var kills = 0

func _ready():
	connect("area_entered", self, "_on_area_entered")
	connect("area_exited", self, "_on_area_exited")
	attack_cooldown.connect("timeout", self, "_on_attack_cooldown_timeout")
	attack_cooldown.wait_time = cooldown

func _physics_process(delta):
	if (get_parent().killable):
		additional_damage = get_parent().killable.health * damage_buff
	if (attack_cooldown.time_left > 0):
		$Label.text = "%.1fs" % attack_cooldown.time_left
	else:
		$Label.text = ""
	print(kills)
func _on_attack_cooldown_timeout():
	emit_signal("attack_ready")
	attack_ready = true

func attack():
	if (attack_ready):
		for area in near_killables:
			if (area.health > 0):
				var is_dead = area.take_damage(damage + additional_damage)
				if (is_dead):
					kills += 1
		sfx_audio.play_effect(Global.SFXEffect.Attack)
		attack_ready = false
		attack_cooldown.start()

func _on_area_entered(area:Area2D):
	if (area and area.name == "Killable" and area.get_parent() != get_parent()):
		near_killables.push_back(area)
		

func _on_area_exited(area: Area2D):
	if (near_killables.find(area) != -1):
		near_killables.remove(near_killables.find(area))
	
func add_damage(value):
	damage_buff += value
	damage_banners_count += 1
	var temporal_info = temporal_info_res.instance()
	temporal_info.text = "+%.2f damage" % value
	sfx_audio.play_effect(Global.SFXEffect.Pickup)
	add_child(temporal_info)
