extends Node

var attack_sounds_res = [
	load("res://assets/sounds/attack_1.wav"),
	load("res://assets/sounds/attack_2.wav"),
	load("res://assets/sounds/attack_3.wav"),
	load("res://assets/sounds/attack_4.wav"),
]

var button_press_sounds_res = [
	load("res://assets/sounds/button_press_1.wav"),
	load("res://assets/sounds/button_press_2.wav"),
	load("res://assets/sounds/button_press_3.wav"),
	load("res://assets/sounds/button_press_4.wav"),
]
var jump_sounds_res = [
	load("res://assets/sounds/jump_1.wav"),
	load("res://assets/sounds/jump_2.wav"),
	load("res://assets/sounds/jump_3.wav"),
	load("res://assets/sounds/jump_4.wav"),
]
var pickup_sounds_res = [
	load("res://assets/sounds/pickup_1.wav"),
	load("res://assets/sounds/pickup_2.wav"),
	load("res://assets/sounds/pickup_3.wav"),
	load("res://assets/sounds/pickup_4.wav"),
]
var take_damage_sounds_res = [
	load("res://assets/sounds/take_damage_1.wav"),
	load("res://assets/sounds/take_damage_2.wav"),
	load("res://assets/sounds/take_damage_3.wav"),
	load("res://assets/sounds/take_damage_4.wav"),
]
var walk_sounds_res = [
	load("res://assets/sounds/walk_1.wav"),
	load("res://assets/sounds/walk_2.wav"),
	load("res://assets/sounds/walk_3.wav"),
	load("res://assets/sounds/walk_4.wav"),
]

var menu_music = load("res://assets/sounds/Runescape - Camelot.mp3")
var game_music = load("res://assets/sounds/Runescape - Dogs Of War.mp3")
var game_over_music = load("res://assets/sounds/Runescape - Newbie Melody.mp3")

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

enum SFXEffect {
	Walk,
	Attack,
	ButtonPress,
	Jump,
	Pickup,
	TakeDamage,
}


