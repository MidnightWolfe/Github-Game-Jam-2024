extends CharacterBody2D

@export var speed = 200
#var gravity = 600

var gravity = 10
const jumpPower = -400

@onready var animationPath = $AnimatedSprite2D


#func get_input():
#	var input_direction = Input.get_vector("left", "right", "up", "down")
#	velocity = input_direction * speed
	
	

func _physics_process(delta):
	#get_input()	#Getting the player inputs
	
	##Get the player to move in left / right directions
	var playerDirection = Input.get_axis("left","right")
	if playerDirection:
		velocity.x = playerDirection * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed) #Just slows the player so that it's a smooth motion
	
	##To get the player to jump
	if not is_on_floor():
		velocity.y += gravity #Only * delta if using rigid bodies
		
	if Input.is_action_just_pressed("ui_accept") && is_on_floor(): #To get the player to jump with space bar
		velocity.y = jumpPower
	
	##Variable jumping, if you hold space you'll jump higher	
	if Input.is_action_just_released("ui_accept"):
		velocity.y *= 0.5
		
	move_and_slide()
	handle_animation(playerDirection)
	
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
