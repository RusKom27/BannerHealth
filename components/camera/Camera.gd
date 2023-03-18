extends Camera2D

export var follow_speed = 5
export var amplitude = 0.05
export var frequency = 6

onready var knight = get_parent().knight
var time = 0

func _physics_process(delta):
	if (!knight):
		knight = get_parent().knight
		return
	time += delta
	var camera_pos = position
	var offset_y = sin(time * frequency) * amplitude
	var knight_pos = knight.position
	camera_pos = camera_pos.linear_interpolate(knight_pos, delta * follow_speed)

	position = camera_pos + Vector2(0, offset_y)

var shake_duration = 0.1 # длительность тряски в секундах
var shake_amplitude = Vector2(8, 2) # амплитуда тряски по осям X и Y

func shake():
	var original_pos = position
	var timer = 0.0
	while timer < shake_duration:
		var offset = Vector2(rand_range(-shake_amplitude.x, shake_amplitude.x),
							 rand_range(-shake_amplitude.y, shake_amplitude.y))
							 
		position = original_pos + offset
		
		timer += get_process_delta_time()
		
		yield(get_tree().create_timer(0.0), "timeout")
		
	position = original_pos
