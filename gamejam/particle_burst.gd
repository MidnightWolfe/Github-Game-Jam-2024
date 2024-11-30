extends Node2D

@onready var particle = $SpellEffect
@onready var area = $Area2D
var colour = "Black"
var hasCollided = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	particle.emitting = true
	await waitForLifetime()
	
#Collision code
func _process(delta: float) -> void:
	if hasCollided:
		return

	var overlapping_bodies = area.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body is TileMapLayer:
			hasCollided = true
			await get_tree().create_timer(0.1).timeout
			body.handle_particle_collision(self)
			break
		

func waitForLifetime():
	await get_tree().create_timer(4.0).timeout
	queue_free()
