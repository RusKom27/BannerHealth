extends KinematicBody2D
class_name Knight

onready var animation = $Animation
onready var input_controller = $InputController
onready var movable = $Movable
onready var killable = $Killable
onready var attackable = $Attackable
onready var state_machine = $EntityStateMachine
onready var camera = get_parent().camera

var is_dead = false

func _ready():
	animation.connect("animation_finished", self, "_on_animation_finished")
	animation.connect("frame_changed", self, "_on_frame_changed")
	killable.connect("death", self, "_on_death")
	killable.connect("take_damage", self, "_on_damage_taked")

func _physics_process(delta):
	camera = get_parent().camera
	animation.current_animation = state_machine.current_state
	
	if (killable.health == 0):
		return
	if (!state_machine.move_ability):
		movable.velocity = Vector2(0, movable.velocity.y)
	
	if (input_controller.direction.x == 0):
		state_machine.change_state(Global.State.IDLE)
		movable.velocity.x = 0
	if input_controller.direction.x != 0:
		movable.walk(input_controller.direction)
		animation.scale.x = abs(input_controller.direction.x) / input_controller.direction.x
		attackable.collision_shape.position = Vector2(
			abs(attackable.collision_shape.position.x) *
			input_controller.direction.x,
			attackable.collision_shape.position.y
		)
		state_machine.change_state(Global.State.WALK)
	if input_controller.is_jump_pressed and is_on_floor():
		movable.jump()
	if (movable.velocity.y < 0):
		state_machine.change_state(Global.State.JUMP, true)
	elif (movable.velocity.y > 0):
		state_machine.change_state(Global.State.FALL)
	if input_controller.is_attack_pressed:
		attack()

func _on_death():
	state_machine.change_state(Global.State.DEATH)

func _on_damage_taked():
	state_machine.change_state(Global.State.TAKE_DAMAGE)

func _on_animation_finished():
	if (animation.animation == Global.FALL_STATE):
		state_machine.change_state(Global.State.LAND, true)
	if (animation.animation == Global.LAND_STATE):
		movable.sfx_audio.play_effect(Global.SFXEffect.ButtonPress)
		state_machine.change_state(Global.State.IDLE, true)
	if (animation.animation == Global.ATTACK_STATE):
		state_machine.change_state(Global.State.IDLE, true)
	if (animation.animation == Global.TAKE_DAMAGE_STATE):
		state_machine.change_state(Global.State.IDLE, true)
	if (animation.animation == Global.DEATH_STATE):
		is_dead = true

func _on_frame_changed():
	if (animation.animation == Global.ATTACK_STATE and animation.frame == 2):
		attackable.attack()
		if (camera):
			camera.shake()
	if (animation.animation == Global.WALK_STATE and 
		(animation.frame == 2 or animation.frame == 4)):
		movable.sfx_audio.play_effect(Global.SFXEffect.Walk)

func attack():
	if (attackable.attack_ready):
		state_machine.change_state(Global.State.ATTACK)




