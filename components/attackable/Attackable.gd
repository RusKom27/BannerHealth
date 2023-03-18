extends Area2D

signal attack_ready

onready var collision_shape = $CollisionShape2D
onready var attack_cooldown = $AttackCooldown

export var damage: float = 1
export var cooldown: float = 1

var attack_ready = true
var near_killables = []
var damage_buff = 0
var additional_damage = 0

func _ready():
	connect("area_entered", self, "_on_area_entered")
	connect("area_exited", self, "_on_area_exited")
	attack_cooldown.connect("timeout", self, "_on_attack_cooldown_timeout")
	attack_cooldown.wait_time = cooldown

func _physics_process(delta):
	if (get_parent().killable):
		additional_damage = get_parent().killable.health * damage_buff
		
func _on_attack_cooldown_timeout():
	emit_signal("attack_ready")
	attack_ready = true

func attack():
	if (attack_ready):
		for area in near_killables:
			area.take_damage(damage + additional_damage)
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
