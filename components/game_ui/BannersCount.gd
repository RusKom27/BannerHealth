extends HBoxContainer


onready var knight = get_parent().knight

func _physics_process(delta):
	if (!knight):
		knight = get_parent().knight
		return
	$Health.label.text = "x%x" % knight.killable.health_banners_count
	$Armor.label.text = "x%x" % knight.killable.armor_banners_count
	$Damage.label.text = "x%x" % knight.attackable.damage_banners_count
	$Speed.label.text = "x%x" % knight.movable.move_speed_banners_count
	$Kills.label.text = "x%x" % knight.attackable.kills
	
