extends Node2D

var current_state = Global.IDLE_STATE

var attack_ability = false
var move_ability = false
var jump_ability = false
var idle_ability = false


func _physics_process(delta):
	attack_ability = ([
		Global.IDLE_STATE,
		Global.WALK_STATE,
		].has(current_state)
	)
	move_ability = ([
		Global.IDLE_STATE,
		Global.WALK_STATE,
		Global.JUMP_STATE, 
		Global.FALL_STATE,
		Global.LAND_STATE,
		].has(current_state)
	)
	jump_ability = ([
		Global.IDLE_STATE, 
		Global.WALK_STATE
		].has(current_state)
	)
	idle_ability = (
		![Global.ATTACK_STATE,
		Global.LAND_STATE,
		Global.FALL_STATE,
		Global.JUMP_STATE,
		Global.DEATH_STATE,
		Global.TAKE_DAMAGE_STATE,
		].has(current_state)
	)

func change_state(state, ignore_ability = false):
	match state:
		Global.State.IDLE:
			if ((idle_ability and current_state != Global.ATTACK_STATE) || ignore_ability):
				current_state = Global.IDLE_STATE
		Global.State.WALK:
			if (move_ability || ignore_ability):
				current_state = Global.WALK_STATE
		Global.State.JUMP:
			if (jump_ability || ignore_ability):
				current_state = Global.JUMP_STATE
		Global.State.FALL:
			current_state = Global.FALL_STATE
		Global.State.LAND:
			current_state = Global.LAND_STATE
		Global.State.ATTACK:
			if (attack_ability || ignore_ability):
				current_state = Global.ATTACK_STATE
		Global.State.TAKE_DAMAGE:
			current_state = Global.TAKE_DAMAGE_STATE
		Global.State.DEATH:
			current_state = Global.DEATH_STATE
			
