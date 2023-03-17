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
onready var camera = get_parent().camera

var velocity = Vector2.ZERO
var current_state = IDLE_STATE
var attack_ability = false
var move_ability = false
var jump_ability = false

func _ready():
	animation.connect("animation_finished", self, "_on_animation_finished")
	animation.connect("frame_changed", self, "_on_frame_changed")

func _physics_process(delta):
	camera = get_parent().camera
	velocity.y += GRAVITY * delta
	if (!move_ability):
		velocity = Vector2(0, velocity.y)
	animation.current_animation = current_state
	velocity = move_and_slide(velocity, Vector2.UP)
	attack_ability = ([
		IDLE_STATE,
		WALK_STATE,
		].has(current_state) and 
		input_controller.is_attack_pressed
	)
	move_ability = ([
		IDLE_STATE, 
		WALK_STATE,
		JUMP_STATE, 
		FALL_STATE
		].has(current_state) and
		input_controller.direction.x != 0
	)
	jump_ability = ([
		IDLE_STATE, 
		WALK_STATE
		].has(current_state) and 
		input_controller.is_jump_pressed and 
		is_on_floor()
	)
	if (input_controller.direction.x == 0 and
		![ATTACK_STATE, LAND_STATE, FALL_STATE, JUMP_STATE].has(current_state)
	):
		current_state = IDLE_STATE
	if move_ability:
		walk()
	if jump_ability:
		jump()
	if (velocity.y < 0):
		current_state = JUMP_STATE
	elif (velocity.y > 0):
		current_state = FALL_STATE
	if attack_ability:
		attack()
	
func _on_animation_finished():
	if (animation.animation == FALL_STATE):
		current_state = LAND_STATE
	if (animation.animation == LAND_STATE):
		current_state = IDLE_STATE
	if (animation.animation == ATTACK_STATE):
		current_state = IDLE_STATE

func _on_frame_changed():
	if (animation.animation == ATTACK_STATE and animation.frame == 2):
		if (camera):
			camera.shake()

func attack():
	current_state = ATTACK_STATE

func walk():
	velocity.x = input_controller.direction.x * MOVE_SPEED
	animation.scale.x = abs(input_controller.direction.x) / input_controller.direction.x
	current_state = WALK_STATE

func jump():
	velocity.y = JUMP_FORCE


