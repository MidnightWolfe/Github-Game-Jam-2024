extends CharacterBody2D

@export var speed = 200
#var gravity = 600

var gravity = 10
const jumpPower = -400

@onready var animationPath = $AnimatedSprite2D

const SPELLS = preload("res://spells.tscn")
var is_casting_spell = false
var combo = Vector3(0, 0, 0)
var colour = Color()


#func get_input():
#	var input_direction = Input.get_vector("left", "right", "up", "down")
#	velocity = input_direction * speed
	
	

func _physics_process(_delta):
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
		
	if Input.is_action_just_pressed("ui_select") && is_on_floor(): #To get the player to jump with space bar
		velocity.y = jumpPower
	
	##Variable jumping, if you hold space you'll jump higher	
	if Input.is_action_just_released("ui_select"):
		velocity.y *= 0.5
	
	if Input.is_action_just_pressed("ui_text_submit"):
		if is_casting_spell:
			var greatestValue = max(combo.x, combo.y, combo.z)
			colour = Color(combo.x / greatestValue, combo.y / greatestValue, combo.z / greatestValue)
			combo = Vector3(0,0,0)
			var spell = SPELLS.instantiate()
			spell._set_colour(colour)
			get_parent().add_child(spell)
			spell.position = $".".global_position
		is_casting_spell = not is_casting_spell
	
	if is_casting_spell:
		if Input.is_action_just_pressed("left"):
			combo.x = combo.x + 1.0
		if Input.is_action_just_pressed("up"):
			combo.y = combo.y + 1.0
		if Input.is_action_just_pressed("right"):
			combo.z = combo.z + 1.0
	
	move_and_slide()
	handle_animation()
	
##Function to handle the animation of the player sprite
func handle_animation():
	if is_on_floor():
		if velocity: #For running animation
			pass
		else:
			animationPath.play("idle")
		pass
	else: #If jumping animation
		pass
	
	
	
	pass



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
