extends KinematicBody2D


const IDLE_STATE = "idle"
const WALK_STATE = "walk"
const JUMP_STATE = "jump"
const FALL_STATE = "fall"
const LAND_STATE = "land"
const ATTACK_STATE = "attack"

export(int) var MOVE_SPEED = 100
export(int) var GRAVITY = 1000
export(int) var JUMP_FORCE = -400

onready var animation = $Animation
onready var input_controller = $InputController

var velocity = Vector2.ZERO
var current_state = IDLE_STATE

func _ready():
	animation.connect("animation_finished", self, "_on_animation_finished")

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	animation.current_animation = current_state
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if input_controller.direction.x != 0:
		velocity.x = input_controller.direction.x * MOVE_SPEED
		animation.scale.x = abs(input_controller.direction.x) / input_controller.direction.x
		current_state = WALK_STATE
	elif (current_state == WALK_STATE):
		velocity.x = 0
		current_state = IDLE_STATE
	if input_controller.is_jump_pressed and is_on_floor():
		velocity.y = JUMP_FORCE
	if (velocity.y < 0):
		current_state = JUMP_STATE
	elif (velocity.y > 0):
		current_state = FALL_STATE
	if input_controller.is_attack_pressed:
		current_state = ATTACK_STATE
		print(current_state)
	
func _on_animation_finished():
	if (animation.animation == FALL_STATE):
		current_state = LAND_STATE
		velocity.x = 0
	if (animation.animation == LAND_STATE):
		current_state = IDLE_STATE
	if (animation.animation == ATTACK_STATE):
		current_state = IDLE_STATE
		velocity.x = 0

