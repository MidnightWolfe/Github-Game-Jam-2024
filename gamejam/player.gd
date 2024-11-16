extends CharacterBody2D
###Global variables
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
	if Input.is_action_just_released("ui_accept"):
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
func _process(delta: float) -> void:
	pass
