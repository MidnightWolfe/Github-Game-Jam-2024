extends CharacterBody2D
###Global variables

class_name Player


@onready var pause_menu = $Camera2D/PauseMenu
var paused = false



signal healthChanged

@export var speed = 200



##Basic jump / gravity variables
var gravity = 10
const jumpPower = -400

##Double jump variables
var jumpCount = 0
var maxJumpCount = 2

##Dash variables
const dashSpeed = 500
var dashing = false
var canDash = true
##Sound Code
@onready var movement_sounds = %movement_sounds
@onready var spell_sounds = %spell_sounds


##Markus Code
const SPELLS = preload("res://spells.tscn")
var is_casting_spell = false
var combo = Vector3(0, 0, 0)
var colour = Color(0, 0, 0)
@onready var spellParticles = $SpellParticles
@onready var animationPath = $AnimatedSprite2D

##Player Attack/HitBox
var enemyInAttackRange = false
var enemyAttackCooldown = true
#@export var health = 30

@export var maxHealth = 30  #Player currently has 30 hit points (HP)
@onready var currentHealth: int = maxHealth #Tracking the current health of the player

var IsPlayerAlive = true

var lastDirection = 1

func _physics_process(_delta):
	get_input()	
	move_and_slide()
	
	enemy_attack()
	if currentHealth <= 0: #Current Health
		IsPlayerAlive = false
		#currentHealth = 0 #Current health
		print("Player has been killed")
		get_tree().change_scene_to_file("res://death_menu.tscn")
	
##Function to get player inputs
func get_input():
	##Get the player to move in left / right directions
	var playerDirection = Input.get_axis("left","right")
	if playerDirection:
		if dashing:
			velocity.x = playerDirection * dashSpeed
		else:
			velocity.x = playerDirection * speed
			directSprite(playerDirection)
	else:
		velocity.x = move_toward(velocity.x, 0, speed) #Just slows the player so that it's a smooth motion
	
	##Setting dash to true if shift is pressed and setting a timer
	if Input.is_action_just_pressed("dash") and canDash:
		movement_sounds.dash_sound()
		dashing = true
		canDash = false
		$DashTimer.start()
		$DashAgainTimer.start()
	
	##To get the player to jump
	if not is_on_floor():
		velocity.y += gravity #Only * delta if using rigid bodies
	
	if is_on_floor():
		jumpCount = 0
		
	if Input.is_action_just_pressed("space") && jumpCount < maxJumpCount: #To get the player to jump with space bar and double jump
		movement_sounds.jump_sound()
		velocity.y = jumpPower
		jumpCount += 1
	
		
	
	##Variable jumping, if you hold space you'll jump higher	
	if Input.is_action_just_released("space"):
		velocity.y *= 0.5
	handle_animation(playerDirection)


func directSprite(direction: float) -> void:
	if direction < 0 and lastDirection != -1:
		lastDirection = -1
		spellParticles.process_material.emission_shape_offset.x *= -1
	elif direction > 0 and lastDirection != 1:
		lastDirection = 1
		spellParticles.process_material.emission_shape_offset.x *= -1
	

##Make the player stop dashing
func _on_dash_timer_timeout() -> void:
	dashing = false

func _on_dash_again_timer_timeout() -> void:
	canDash = true
	pass # Replace with function body.

##Function to handle the animation of the player sprite
func handle_animation(playerDirection):
	handle_animation_flip(playerDirection)
	if is_on_floor():
		if velocity: #For running animation
			animationPath.play("run")
		else:
			animationPath.play("idle")
	else: #If jumping animation
		animationPath.play("jump")

##Function to handle the animation flip in direction
func handle_animation_flip(playerDirection):
	if playerDirection == 1:
		animationPath.flip_h = false #Do not flip in the right direction
	elif playerDirection == -1:
		animationPath.flip_h = true #Flip in the left direction



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	var greatestValue = max(combo.x, combo.y, combo.z)
	if greatestValue != 0:
				colour = Color(combo.x / greatestValue, combo.y / greatestValue, combo.z / greatestValue)
	if Input.is_action_just_pressed("enter"):
		if is_casting_spell:
			combo = Vector3(0,0,0)
			var spell = SPELLS.instantiate()
			if(colour == Color.BLUE):
				spell_sounds.spell_blue_sound()
			elif(colour == Color.RED):
				spell_sounds.spell_red_sound()
			elif(colour == Color.GREEN):
				spell_sounds.spell_green_sound()
			elif(colour == Color.CYAN):
				spell_sounds.spell_green_sound()
			elif(colour == Color.MAGENTA):
				spell_sounds.spell_green_sound()
			elif(colour == Color.YELLOW):
				spell_sounds.spell_green_sound()
			
			spell._set_colour(colour)
			spell._set_direction(lastDirection)
			get_parent().add_child(spell)
			spell.position = $".".global_position
		is_casting_spell = not is_casting_spell
	
	spellParticles.modulate = colour
	
	if is_casting_spell:
		if Input.is_action_just_pressed("1"):
			combo.x = combo.x + 1.0
		if Input.is_action_just_pressed("2"):
			combo.y = combo.y + 1.0
		if Input.is_action_just_pressed("3"):
			combo.z = combo.z + 1.0
	pass

## This is currently used to determine if the player is in the enemy hitbox
func player():
	pass

func _on_player_hit_box_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemyInAttackRange = true

func _on_player_hit_box_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemyInAttackRange = false

##Functions that happen while the enemy is attacking
#This is set up so that when the enemy touches the player, the player is "attacked".
func enemy_attack():
	if enemyInAttackRange and enemyAttackCooldown == true:
		currentHealth = currentHealth - 5 #Enemy damage to player
		healthChanged.emit()

		enemyAttackCooldown = false
		$Attack_Cooldown_Timer.start()
		print("Player took -5 damage")
		print(currentHealth)

func _on_attack_cooldown_timer_timeout() -> void:
	enemyAttackCooldown = true

		
##Function to get the pause menu to show when player hits escape
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
	pass
	
