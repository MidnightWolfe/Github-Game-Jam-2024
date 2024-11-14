extends Area2D

const SPEED = 200
var velocity = Vector2()
var colour = Color()

@onready var animationSprite = $AnimatedSprite2D

func _ready() -> void:
	animationSprite.modulate = colour
	pass

func _physics_process(delta: float) -> void:
	velocity.x = SPEED * delta
	translate(velocity)
	animationSprite.play("projectile")

func _set_colour(newColour):
	colour = newColour

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
