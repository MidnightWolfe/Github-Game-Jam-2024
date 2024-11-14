extends Area2D

const SPEED = 200
var velocity = Vector2()
var colour = Color()

@onready var sprite = $Sprite2D

var image = Image.load_from_file("res://Sprites/player.png")
var texture = ImageTexture.create_from_image(image)

func _set_colour(colour):
	self.colour = colour

func _ready() -> void:
	sprite.texture = texture
	sprite.modulate = colour

func _physics_process(delta: float) -> void:
	velocity.x = SPEED * delta
	translate(velocity)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
