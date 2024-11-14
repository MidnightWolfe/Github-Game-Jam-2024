extends Area2D

const SPEED = 200
var velocity = Vector2()
var colour = Color()
var type = "null"
@onready var animationSprite = $AnimatedSprite2D

func _ready() -> void:
	animationSprite.modulate = colour
	if colour.r == 0 && colour.g == 0 && colour.b == 0:
		type = "Black"
	elif colour.r == 1 && colour.g == 1 && colour.b == 1:
		type = "White"
	elif colour.r == 1:
		if colour.g > 0.5 && colour.b <= 0.5:
			type = "Yellow"
		elif colour.b > 0.5 && colour.g <= 0.5:
			type = "Magenta"
		else:
			type = "Red"
	elif colour.g == 1:
		if colour.r > 0.5 && colour.b <= 0.5:
			type = "Yellow"
		elif colour.b > 0.5 && colour.r <= 0.5:
			type = "Cyan"
		else:
			type = "Green"
	elif colour.b == 1:
		if colour.r > 0.5 && colour.g <= 0.5:
			type = "Magenta"
		elif colour.g > 0.5 && colour.r <= 0.5:
			type = "Cyan"
		else:
			type = "Blue"
	
	print(colour)
	print(type)

func _physics_process(delta: float) -> void:
	velocity.x = SPEED * delta
	translate(velocity)
	animationSprite.play("projectile")

func _set_colour(newColour):
	colour = newColour

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
