extends Node2D

var unit_obj = preload("res://Objects/Units/BaseUnit.tscn")
var archer_obj = preload("res://Objects/Units/Archer.tscn")

func _ready() -> void:
	randomize()
	spawn()
	yield(get_tree().create_timer(rand_range(1,3)), "timeout")
	spawn()
	yield(get_tree().create_timer(rand_range(1,3)), "timeout")
	spawn()
	yield(get_tree().create_timer(rand_range(1,3)), "timeout")
	spawn()
	yield(get_tree().create_timer(rand_range(1,3)), "timeout")
	spawn()
	yield(get_tree().create_timer(rand_range(1,3)), "timeout")
	spawn()
	yield(get_tree().create_timer(rand_range(1,3)), "timeout")
	spawn()


func spawn() -> void:
	
	if true:
		var u = unit_obj.instance()
		u.global_position = Vector2(rand_range(100,800), rand_range(100,980))
		u.add_to_group("player")
		u.mdl = Color.skyblue
		add_child(u)
		
		var a = archer_obj.instance()
		a.global_position = Vector2(rand_range(100,800), rand_range(100,980))
		a.add_to_group("player")
		a.mdl = Color.skyblue
		add_child(a)
	
	for i in rand_range(1,3):
		var u = unit_obj.instance()
		u.global_position = Vector2(rand_range(1060, 1800), rand_range(100,980))
		u.add_to_group("enemies")
		u.IS_ENEMY = true
		u.mdl = Color.palevioletred
		add_child(u)
