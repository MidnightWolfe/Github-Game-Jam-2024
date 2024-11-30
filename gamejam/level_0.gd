extends Node2D

const ENEMY = preload("res://enemy.tscn")
const BOSS = preload("res://boss.tscn")

func _ready() -> void:

	_add_enemy("Red", Vector2(-500,-40))
	#_add_enemy("Green", Vector2(-200,50))
	#_add_enemy("Blue", Vector2(500,-125))
	#_add_enemy("Cyan", Vector2(200,-175))
	#_add_enemy("Magenta", Vector2(800,100))
	#_add_enemy("Yellow", Vector2(600,-300))
	_add_boss("Red", Vector2(0, -800))


func _add_enemy(type: String, pos: Vector2):
	var enemy = ENEMY.instantiate()
	enemy._set_type(type)
	enemy._set_position(pos)
	add_child(enemy)
func _add_boss(type: String, pos: Vector2):
	var boss = BOSS.instantiate()
	boss._set_type(type)
	boss._set_position(pos)
	add_child(boss)
