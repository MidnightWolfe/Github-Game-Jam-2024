extends Node2D


var redCheck = false
var blueCheck = false
var greenCheck = false
var yellowCheck = false
var magentaCheck = false
var cyanCheck = false
var openBoss = false

@onready var collisionBox = $CollisionShape2D
@onready var tilemap = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().create_timer(3).timeout
	if not redCheck:
		return
	if not blueCheck:
		return
	if not greenCheck:
		return
	if not yellowCheck:
		return
	if not magentaCheck:
		return
	if not cyanCheck:
		return
	if openBoss:
		return
	openBoss = true
	activateBossDoor()
	pass

func activateBossDoor() -> void:
	print("Deleting tiles in collision area.")
	
	# Get the size and position of the collision box
	var collision_shape = collisionBox.shape
	var topLeft = collisionBox.global_position - collision_shape.extents
	var bottomRight = collisionBox.global_position + collision_shape.extents
	
	# Convert the area to tilemap coordinates
	var topLeftTile = tilemap.local_to_map(topLeft / tilemap.scale)
	var bottomRightTile = tilemap.local_to_map(bottomRight / tilemap.scale)
	
	# Iterate through the tiles in the collision box
	for x in range(topLeftTile.x, bottomRightTile.x + 1):
		for y in range(topLeftTile.y, bottomRightTile.y + 1):
			var tile_source_id = tilemap.get_cell_source_id(Vector2i(x, y))
			if tile_source_id != -1:
				tilemap.erase_cell(Vector2i(x, y))
	
	print("All tiles in collision area deleted.")
