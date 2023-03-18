extends HBoxContainer


onready var knight = get_parent().knight

func _physics_process(delta):
	if (!knight):
		knight = get_parent().knight
		return
	$Health.label.text = "%.2f" % knight.killable.health
	$Armor.label.text = (
		"%.2f" % (knight.killable.armor + knight.killable.additional_armor) + 
		"\n(+%.2f)" % knight.killable.additional_armor
		)
	$Damage.label.text = (
		"%.2f" % (knight.attackable.damage + knight.attackable.additional_damage) + 
		"\n(+%.2f)" % knight.attackable.additional_damage
		)
	$Speed.label.text = (
		"%.2f" % (knight.movable.move_speed + knight.movable.additional_move_speed) +
		"\n(+%.2f)" % knight.movable.additional_move_speed
		)
