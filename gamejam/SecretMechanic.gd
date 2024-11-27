extends Area2D

@export var target_tile_colour_id: int = 1
@export var number_of_required_tiles: int = 3
@onready var tilemap = get_parent().get_parent()

var is_colliding = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	pass # Replace with function body.

#toggles for is_colliding
func _on_body_entered(body) -> void:
	if not is_colliding:
		is_colliding = true
		check_for_erase_tiles()
		
func _on_body_exited(body) -> void:
	if get_overlapping_bodies().size() == 0:
		is_colliding = false

func check_for_erase_tiles() -> void:
	pass	
