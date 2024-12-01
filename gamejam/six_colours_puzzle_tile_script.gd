extends Area2D

@export var target_tile_colour_id: int = 1
@export var number_of_required_tiles: int = 3
@onready var tilemap = get_parent().get_parent().get_parent()
@onready var collisionShape = $CollisionShape2D

var rectangleSizeInXY
var is_colliding = false

func _ready() -> void:
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	rectangleSizeInXY = collisionShape.get_shape().size
	pass

func _on_body_entered(body) -> void:
	if not is_colliding:
		is_colliding = true
		check_tiles_and_update_parent()

func _on_body_exited(body) -> void:
	if get_overlapping_bodies().size() == 0:
		is_colliding = false

func check_tiles_and_update_parent() -> void:
	print("Checking for tiles of type ", target_tile_colour_id)
	var tilemap_scale = tilemap.scale.x
	var rectangle_local_position = global_position / tilemap_scale
	
	var topLeftRectangle = rectangle_local_position
	var bottomRightRectangle = rectangle_local_position + rectangleSizeInXY / 3
	
	var topLeftTile = tilemap.local_to_map(topLeftRectangle)
	var bottomRightTile = tilemap.local_to_map(bottomRightRectangle)
	
	var tilesInAreaThatMatch = []
	for xValues in range(topLeftTile.x, bottomRightTile.x + 1):
		for yValues in range(topLeftTile.y, bottomRightTile.y + 1):
			var tile_source_id = tilemap.get_cell_source_id(Vector2i(xValues, yValues))
			if tile_source_id == -1:
				continue
			var tile_colour_id = tile_source_id % 10
			if tile_colour_id == target_tile_colour_id:
				tilesInAreaThatMatch.append(Vector2i(xValues, yValues))
				
	print("Found: ", tilesInAreaThatMatch.size(), " matching tiles.")
	
	if tilesInAreaThatMatch.size() >= number_of_required_tiles:
		update_parent_value()

func update_parent_value() -> void:
	print("Updating parent value for colour ID ", target_tile_colour_id)
	var parent_node = get_parent()
	match target_tile_colour_id:
		0: return
		1: parent_node.redCheck = true
		2: parent_node.greenCheck = true
		3: parent_node.blueCheck = true
		4: parent_node.yellowCheck = true
		5: parent_node.magentaCheck = true
		6: parent_node.cyanCheck = true
		7: parent_node.whiteCheck = true
	queue_free()
