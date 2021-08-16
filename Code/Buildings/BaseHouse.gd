extends Node2D

export var ENEMY_HOUSE = false
var MAX_HEALTH = 2
var health = 32

func _ready() -> void:
	MAX_HEALTH = health
	$HealthBar.max_value = MAX_HEALTH
	$HealthBar.value = health
	add_to_group("enemies" if ENEMY_HOUSE else "player")


func damage(value: int) -> void:
	health = clamp(health - value, 0, MAX_HEALTH)
	$HealthBar.value = health
	if health <= 0:
		die()

func die() -> void:
	queue_free()

func heal(value: int) -> void:
	health = clamp(health + value, 0, MAX_HEALTH)
	$HealthBar.value = health
