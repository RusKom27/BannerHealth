extends Node2D

enum BannerType {
	Speed,
	Health,
	Armor,
	Damage,
}

onready var animation = $Animation
onready var area = $Area2D

export(BannerType) var current_type = BannerType.Damage
export(bool) var empty = false

func _ready():
	animation.current_animation = str(current_type)
	area.connect("body_entered", self, "_on_body_entered")
	$Animation.visible = !empty
	
func _on_body_entered(body: KinematicBody2D):
	if (body and body.is_in_group("Player") and !empty):
		match current_type:
			BannerType.Speed:
				body.movable.add_speed(0.2)
			BannerType.Health:
				body.killable.add_health(1)
			BannerType.Armor:
				body.killable.add_armor(0.1)
			BannerType.Damage:
				body.attackable.add_damage(0.1)
		empty = true
		$Animation.visible = false
