extends CharacterBody2D
###Global variables
@export var speed = 200

##Basic jump / gravity variables
var gravity = 10
const jumpPower = -400

##Double jump variables
var jumpCount = 0
var maxJumpCount = 2


const SPELLS = preload("res://spells.tscn")
var is_casting_spell = false
var combo = Vector3(0, 0, 0)
var colour = Color(0, 0, 0)

var lastDirection = 1

##Dash variables
const dashSpeed = 500
var dashing = false
var canDash = true

@onready var animationPath = $AnimatedSprite2D

##Function to get player inputs
func get_input():
	##Get the player to move in left / right directions
	var playerDirection = Input.get_axis("left","right")
	if playerDirection:
		if dashing:
			velocity.x = playerDirection * dashSpeed
		else:
			velocity.x = playerDirection * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed) #Just slows the player so that it's a smooth motion
	
	##Setting dash to true if shift is pressed and setting a timer
	if Input.is_action_just_pressed("dash") and canDash:
		dashing = true
		canDash = false
		$DashTimer.start()
		$DashAgainTimer.start()
	
	##To get the player to jump
	if not is_on_floor():
		velocity.y += gravity #Only * delta if using rigid bodies
	
	if is_on_floor():
		jumpCount = 0
		

	if Input.is_action_just_pressed("ui_accept") && jumpCount < maxJumpCount: #To get the player to jump with space bar and double jump
		velocity.y = jumpPower
		jumpCount += 1
	
		
	
	##Variable jumping, if you hold space you'll jump higher	
	if Input.is_action_just_released("ui_select"):
		velocity.y *= 0.5

	handle_animation(playerDirection)

func _physics_process(delta):
	get_input()	
	move_and_slide()
	
	
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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_text_submit"):
		if is_casting_spell:
			var greatestValue = max(combo.x, combo.y, combo.z)
			if greatestValue != 0:
				colour = Color(combo.x / greatestValue, combo.y / greatestValue, combo.z / greatestValue)
			combo = Vector3(0,0,0)
			var spell = SPELLS.instantiate()
			spell._set_colour(colour)
			spell._set_direction(lastDirection)
			get_parent().add_child(spell)
			spell.position = $".".global_position
		is_casting_spell = not is_casting_spell
	
	if is_casting_spell:
		if Input.is_action_just_pressed("1"):
			combo.x = combo.x + 1.0
		if Input.is_action_just_pressed("2"):
			combo.y = combo.y + 1.0
		if Input.is_action_just_pressed("3"):
			combo.z = combo.z + 1.0
	pass
