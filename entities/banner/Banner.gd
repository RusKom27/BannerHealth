extends Node2D

enum BannerType {
	Speed,
	Health,
	Armor,
	Damage,
}

onready var animation = $Animation

export(BannerType) var current_type = BannerType.Damage

func _ready():
	animation.current_animation = str(current_type)

