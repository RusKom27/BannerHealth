extends Node2D

export(float) var move_speed:float = 100
export(int) var GRAVITY = 1000
export(int) var JUMP_FORCE = -400

var velocity = Vector2.ZERO
var move_speed_buff:float = 0
var additional_move_speed = 0

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	velocity = get_parent().move_and_slide(velocity, Vector2.UP)
	if (get_parent().killable):
		additional_move_speed = get_parent().killable.health * move_speed_buff

func walk(direction: Vector2):
	velocity.x = direction.x * (move_speed + additional_move_speed)
	
func jump():
	velocity.y = JUMP_FORCE

func add_speed(value):
	move_speed_buff += value
