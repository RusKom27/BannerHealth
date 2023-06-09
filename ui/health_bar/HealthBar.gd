extends HBoxContainer

onready var knight = get_node("/root/Node2D/Knight")
onready var heart_res = load("res://ui/heart/Heart.tscn")

var rounded_health: float = 0
var knight_health = 0

func _physics_process(delta):
	if (!knight):
		return
	if (knight.killable):
		knight_health = knight.killable.health
	var new_rounded_health = ceil(knight_health / 0.5) * 0.5
	
	if (new_rounded_health == rounded_health):
		return
	rounded_health = new_rounded_health
	while get_children().size() > 0:
		remove_child(get_child(0))
	while new_rounded_health >= 0:
		var heart = heart_res.instance()
		if (new_rounded_health < 1):
			heart.half = true
		if (new_rounded_health == 0):
			return
		add_child(heart)
		new_rounded_health -= 1
		
	
