extends Node

const IDLE_STATE = "idle"
const WALK_STATE = "walk"
const JUMP_STATE = "jump"
const FALL_STATE = "fall"
const LAND_STATE = "land"
const ATTACK_STATE = "attack"
const TAKE_DAMAGE_STATE = "take_damage"
const DEATH_STATE = "death"

enum State {
	IDLE,
	WALK,
	JUMP, 
	FALL,
	LAND,
	ATTACK,
	TAKE_DAMAGE,
	DEATH
}

