extends Node2D

const ENEMY = preload("res://enemy.tscn")
const BOSS = preload("res://boss.tscn")

func _ready() -> void:

	_add_enemy("Red", Vector2(-550,-82))
	_add_enemy("Red", Vector2(-2128,-704))
	_add_enemy("Red", Vector2(-3186,-640))
	_add_enemy("Red", Vector2(-4032,-768))
	_add_enemy("Red", Vector2(-3968,64))
	_add_enemy("Red", Vector2(-5120,64))
	_add_enemy("Red", Vector2(-4800,1728))
	
	_add_enemy("Green", Vector2(-4992,1908))
	_add_enemy("Green", Vector2(-5184,-1632))
	_add_enemy("Green", Vector2(-5664,-2176))
	_add_enemy("Green", Vector2(-5056,-2304))
	_add_enemy("Green", Vector2(-4608,-2432))
	_add_enemy("Green", Vector2(-4800,-1632))
	_add_enemy("Green", Vector2(-4480,-1536))
	_add_enemy("Green", Vector2(-3888,-2112))
	_add_enemy("Green", Vector2(-2816,1728))
	
	_add_enemy("Blue", Vector2(-330,1220))
	_add_enemy("Blue", Vector2(174,1190))
	_add_enemy("Blue", Vector2(928,-530))
	_add_enemy("Blue", Vector2(1782,-79))
	_add_enemy("Blue", Vector2(-4071,180))
	_add_enemy("Blue", Vector2(-4500,1400))
	_add_enemy("Blue", Vector2(-3672,1554))
	
	_add_enemy("Cyan", Vector2(-1600,1920))
	_add_enemy("Cyan", Vector2(-6656,1888))
	_add_enemy("Cyan", Vector2(-6912,1888))
	_add_enemy("Cyan", Vector2(-7072,1664))
	_add_enemy("Cyan", Vector2(-7296,1536))
	_add_enemy("Cyan", Vector2(-4096,1992))
	_add_enemy("Cyan", Vector2(2770,-64))
	
	_add_enemy("Magenta", Vector2(-1856,1344))
	_add_enemy("Magenta", Vector2(-7104,-960))
	_add_enemy("Magenta", Vector2(-7616,-1856))
	_add_enemy("Magenta", Vector2(-6464,64))
	_add_enemy("Magenta", Vector2(-6592,352))
	_add_enemy("Magenta", Vector2(-7360,1108))
	_add_enemy("Magenta", Vector2(-5120,160))
	_add_enemy("Magenta", Vector2(1440,-192))
	_add_enemy("Magenta", Vector2(-2904,1400))
	
	
	_add_enemy("Yellow", Vector2(-1400,-1130))
	_add_enemy("Yellow", Vector2(-856,-1160))
	_add_enemy("Yellow", Vector2(-348,-1186))
	_add_enemy("Yellow", Vector2(-160,-857))
	_add_enemy("Yellow", Vector2(-1173,-1260))
	_add_enemy("Yellow", Vector2(3158,-51))
	_add_enemy("Yellow", Vector2(-4348,1616))
	_add_enemy("Yellow", Vector2(-1872,1360))
	_add_enemy("Yellow", Vector2(-4552,-904))
	_add_enemy("Yellow", Vector2(-472,-1136))
	_add_enemy("Yellow", Vector2(-4272,-808))
	
	
	
	_add_boss("Red", Vector2(5500, -800))


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
