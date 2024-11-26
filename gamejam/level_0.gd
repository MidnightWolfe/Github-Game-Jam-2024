extends Node2D

const ENEMY = preload("res://enemy.tscn")

func _ready() -> void:
	_add_enemy("Red", Vector2(-400,0))
	_add_enemy("Green", Vector2(-200,50))
	_add_enemy("Blue", Vector2(500,-125))
	_add_enemy("Cyan", Vector2(200,-175))
	_add_enemy("Magenta", Vector2(400,-50))
	_add_enemy("Yellow", Vector2(600,-300))

func _add_enemy(type: String, pos: Vector2):
	var enemy = ENEMY.instantiate()
	enemy._set_type(type)
	enemy._set_position(pos)
	add_child(enemy)
