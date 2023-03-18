extends KinematicBody2D


export(SpriteFrames) var sprite_frames = null

onready var animation = $Animation
onready var movable = $Movable
onready var killable = $Killable
onready var attackable = $Attackable
onready var state_machine = $EntityStateMachine
onready var update = $Update

onready var trigger_area = $TriggerArea
onready var follow_area = $FollowArea
onready var attack_area = $AttackArea

var move_direction = Vector2.ZERO

func _ready():
	animation.connect("animation_finished", self, "_on_animation_finished")
	animation.connect("frame_changed", self, "_on_frame_changed")
	update.connect("timeout", self, "_on_update_timeout")
	killable.connect("death", self, "_on_death")
	killable.connect("take_damage", self, "_on_damage_taked")
	animation.frames = sprite_frames
	animation.current_animation = state_machine.current_state
	animation.play(animation.current_animation)

func _physics_process(delta):	
	animation.current_animation = state_machine.current_state
	if (killable.health == 0):
		return
	if (!state_machine.move_ability):
		movable.velocity = Vector2(0, movable.velocity.y)
	if move_direction.x == 0:
		state_machine.change_state(Global.State.IDLE)
		movable.velocity.x = 0
	if move_direction.x != 0:
		movable.walk(move_direction)
		if (!attackable.attack_ready):
			movable.velocity.x /= 2
		animation.scale.x = abs(move_direction.x) / move_direction.x
		attackable.collision_shape.position = Vector2(
			abs(attackable.collision_shape.position.x) *
			move_direction.x,
			attackable.collision_shape.position.y
		)
		state_machine.change_state(Global.State.WALK)
	if move_direction.y < -0.3 and move_direction.y != 0 and is_on_floor():
		movable.jump()
	if (movable.velocity.y < 0):
		state_machine.change_state(Global.State.JUMP, true)
	elif (movable.velocity.y > 0):
		state_machine.change_state(Global.State.FALL)

func _on_death():
	state_machine.change_state(Global.State.DEATH)

func _on_damage_taked():
	state_machine.change_state(Global.State.TAKE_DAMAGE)

func _on_update_timeout():
	if (trigger_area.player_in):
		pass
	if (follow_area.player_in):
		move_direction = -follow_area.player_in.global_position.direction_to(position)
	else:
		move_direction = Vector2.ZERO
	if (attack_area.player_in):
		move_direction = Vector2.ZERO
		if (attack_area.player_in.killable.health != 0):
			attack()
	
func _on_animation_finished():
	if (animation.animation == Global.FALL_STATE):
		state_machine.change_state(Global.State.LAND, true)
	if (animation.animation == Global.LAND_STATE):
		state_machine.change_state(Global.State.IDLE, true)
	if (animation.animation == Global.ATTACK_STATE):
		state_machine.change_state(Global.State.IDLE, true)
	if (animation.animation == Global.TAKE_DAMAGE_STATE):
		state_machine.change_state(Global.State.IDLE, true)
		

func _on_frame_changed():
	if (animation.animation == Global.ATTACK_STATE and animation.frame == 2):
		attackable.attack()

func attack():
	if (attackable.attack_ready):
		state_machine.change_state(Global.State.ATTACK)
