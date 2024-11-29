# Useful Videos for creating the enemy mechanics
	# https://www.youtube.com/watch?v=9u59U-DWNJs
	# https://www.youtube.com/watch?v=SGd9TlqkaFU
	# https://www.youtube.com/watch?v=24hXJnwRim0
extends CharacterBody2D
@onready var enemy_sounds = %Boss_sounds
var sound : AudioStream = preload("res://Audio/enemy_sound.wav")
var blueCollar = preload("res://Sprites/boss/blueCollar.png")
var yellowCollar = preload("res://Sprites/boss/yellowCollar.png")
var cyanCollar = preload("res://Sprites/boss/cyanCollar.png")
var magentaCollar = preload("res://Sprites/boss/magentaCollar.png")
var greenCollar = preload("res://Sprites/boss/greenCollar.png")

var speed = 100
var speedHold = 0
var gravity = 10
var direction = -1
var dash = false
var dashSpeed = 500
var count = 0

var playerInAttackRange = false
var playerAttackCooldown = true
var health = 5  #Enemies currently have five hit points (HP)
var IsEnemyAlive = true
var type = "null"

func _ready() -> void:
	$Boss_Animation.play("idle")
	enemy_sounds.set_stream(sound)

func _physics_process(_delta: float) -> void:
	if(dash == true):
		count += 1
		if(count == 200):
			speedHold = speed
			speed = dashSpeed
		if(count == 250):
			speed = speedHold
			count = 0
	if velocity.x == 0 or velocity.y != 0:
		direction = -direction
	velocity.x = speed * direction
	velocity.y += gravity
	move_and_slide()
	if health <= 0 && self.type == "Red":
		self.health = 5
		speed = 150
		$Collar.texture = blueCollar
		self.type = "Blue"
	elif health <= 0 && self.type == "Blue":
		self.health = 5
		speed = 200
		$Collar.texture = yellowCollar
		self.type = "Yellow"	
	elif health <= 0 && self.type == "Yellow":
		self.health = 5
		speed = 250
		dash = true
		$Collar.texture = magentaCollar
		self.type = "Magenta"	
	elif health <= 0 && self.type == "Magenta":
		self.health = 5
		speed = 300
		$Collar.texture = cyanCollar
		self.type = "Cyan"	
	elif health <= 0 && self.type == "Cyan":
		self.health = 8
		speed = 350
		dashSpeed = 700
		$Collar.texture = greenCollar
		self.type = "Green"	
	elif health <= 0 && self.type == "Green":
		IsEnemyAlive = false
		health = 0
		print("Boss has been killed")
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
