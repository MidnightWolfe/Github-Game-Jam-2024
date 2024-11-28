# Useful Videos for creating the enemy mechanics
	# https://www.youtube.com/watch?v=9u59U-DWNJs
	# https://www.youtube.com/watch?v=SGd9TlqkaFU
	# https://www.youtube.com/watch?v=24hXJnwRim0
extends CharacterBody2D
@onready var enemy_sounds = %enemy_sounds
var sound : AudioStream = preload("res://Audio/enemy_sound.wav")

var speed = 100
var gravity = 10
var direction = -1

var playerInAttackRange = false
var playerAttackCooldown = true
var health = 5  #Enemies currently have five hit points (HP)
var IsEnemyAlive = true
var type = "null"

func _ready() -> void:
	$Enemy_Animation.play(type)
	enemy_sounds.set_stream(sound)

func _physics_process(_delta: float) -> void:
	if velocity.x == 0 or velocity.y != 0:
		direction = -direction
	velocity.x = speed * direction
	velocity.y += gravity
	move_and_slide()
	if health <= 0:
		IsEnemyAlive = false
		health = 0
		print("Enemy has been killed")
		self.queue_free() #This makes the enemy disappear - there are currently no (death) animations

## This is currently used to determine if the enemy is in the player hitbox
func enemy():
	pass;

func player_attack(damage_type: String):
	if type == "Red":
		if damage_type == "Cyan":
			damage()
	elif type == "Green":
		if damage_type == "Magenta":
			damage()
	elif type == "Blue":
		if damage_type == "Yellow":
			damage()
	elif type == "Cyan":
		if damage_type == "Red":
			damage()
	elif type == "Magenta":
		if damage_type == "Green":
			damage()
	elif type == "Yellow":
		if damage_type == "Blue":
			damage()

func damage():
	enemy_sounds.play()
	health = health - 1
	print("Enemy took -1 damage")
	print(health)

func _set_type(newType):
	type = newType

func _set_position(newPosition):
	position = newPosition

func _on_enemy_hit_box_area_entered(area: Area2D) -> void:
	if area.has_method("spell"):
		player_attack(area.type)
