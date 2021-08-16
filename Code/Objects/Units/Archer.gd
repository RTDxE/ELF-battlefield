extends Node2D

const ATTACK_DISTANCE = 512

var IS_ENEMY = false
var MOVE_SPEED = 80
var ATTACK_SPEED = 1.5
var MAX_HEALTH = 2

var health = 4
var target = null

var current_attack_time = 0

var mdl = Color.white
var update_target_time = 0

var arrow = preload("res://Objects/Ammos/Arrow.tscn")

func _ready() -> void:
	MAX_HEALTH = health
	$HealthBar.max_value = MAX_HEALTH
	$HealthBar.value = health
	$Body.modulate = mdl

func _process(delta: float) -> void:
	if is_instance_valid(target) and update_target_time < 1.0:
		update_target_time += delta		
		var dist = global_position.distance_to(target.global_position)
		var attk_dist = ATTACK_DISTANCE
		if "ENEMY_HOUSE" in target:
			attk_dist = max(attk_dist, 80)
		if dist > attk_dist:
			move_to_target(delta)
		else:
			attack_target(delta)
	else:
		find_target()

func move_to_target(delta: float) -> void:
	var dir: Vector2 = target.global_position - global_position
	dir = dir.normalized()
	global_position += dir * MOVE_SPEED * delta
	
	current_attack_time = 0

func attack_target(delta: float) -> void:
	if current_attack_time >= ATTACK_SPEED:
		current_attack_time -= ATTACK_SPEED
		var a = arrow.instance()
		a.dir = target.global_position - global_position
		a.dir = a.dir.normalized()
		a.IS_ENEMY = IS_ENEMY
		add_child(a)
	current_attack_time += delta

func find_target() -> void:
	update_target_time = 0
	var units = get_tree().get_nodes_in_group("player" if IS_ENEMY else "enemies")
	var max_dist = 9999
	var t = null
	for unit in units:
		var dist = global_position.distance_to(unit.global_position)
		if dist < max_dist and max_dist - dist > 128:
			max_dist = dist
			t = unit
	target = t

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

