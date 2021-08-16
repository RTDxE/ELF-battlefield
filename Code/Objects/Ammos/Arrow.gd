extends Node2D

const ATTACK_DISTANCE = 32

var IS_ENEMY = false
var MOVE_SPEED = 200
var ATTACK_SPEED = 0
var ATTACK_RANGE = 2

var dir = Vector2()

var mdl = Color.white
var despawn_time = 0

func _ready() -> void:
	$Body.look_at(global_position + dir)
	$Body.modulate = mdl

func _process(delta: float) -> void:
	for t in get_tree().get_nodes_in_group("player" if IS_ENEMY else "enemies"):
		var dist = global_position.distance_to(t.global_position)
		var attk_dist = ATTACK_DISTANCE
		if "ENEMY_HOUSE" in t:
			attk_dist = max(attk_dist, 80)
		if dist <= attk_dist:
			attack_target(t)
			queue_free()
			return
	move_to_target(delta)
	despawn_time += delta
	if despawn_time > 5:
		queue_free()

func move_to_target(delta: float) -> void:
	global_position += dir * MOVE_SPEED * delta

func attack_target(target) -> void:
	target.damage(ATTACK_RANGE)
