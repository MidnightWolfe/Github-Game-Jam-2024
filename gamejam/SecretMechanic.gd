
extends Area2D

#	"Black": 0,
#	"Red": 1,
#	"Green": 2,
#	"Blue": 3,
#	"Yellow": 4,
#	"Magenta": 5,
#	"Cyan": 6,
#	"White": 0
@export var target_tile_colour_id: int = 1
@export var number_of_required_tiles: int = 3
@onready var tilemap = get_parent().get_parent()
@onready var collisionShape = $CollisionShape2D


var rectangleSizeInXY
var is_colliding = false

func _ready() -> void:
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	rectangleSizeInXY = collisionShape.get_shape().size
	pass
	

#toggles for is_colliding based on collision
func _on_body_entered(body) -> void:
	print("Secret collided with")
	if not is_colliding:
		is_colliding = true
		check_for_erase_tiles()
		
func _on_body_exited(body) -> void:
	if get_overlapping_bodies().size() == 0:
		is_colliding = false

#This is for checking if enough tiles are the correct colour id
func check_for_erase_tiles() -> void:
	print("Checking for tiles of type ", target_tile_colour_id)
	var tilemap_scale = tilemap.scale.x
	var rectangle_local_position = global_position / tilemap_scale
	
	##Gotta figure out how to get top left and bottom
	var topLeftRectangle = rectangle_local_position
	var bottomRightRectangle = rectangle_local_position + rectangleSizeInXY/3
	print("TopLeftPos: ", topLeftRectangle)
	print("BottomRightPos ", bottomRightRectangle)
	
	#Now convert to tilemap coords, this is used to define the edges of tile deletion
	var topLeftTile = tilemap.local_to_map(topLeftRectangle)
	var bottomRightTile = tilemap.local_to_map(bottomRightRectangle)
	print("Top: ", topLeftTile, " bot: ", bottomRightTile)
	
	#Find tiles in area
	var tilesInAreaThatMatch = []
	var allTilesInArea = []
	#Itterate through the area
	for xValues in range(topLeftTile.x, bottomRightTile.x):
		for yValues in range(topLeftTile.y, bottomRightTile.y):
			allTilesInArea.append(Vector2i(xValues,yValues))
			var tile_source_id = tilemap.get_cell_source_id(Vector2i(xValues,yValues))
			if tile_source_id == -1:
				continue
			#now extract the colour (since tile source ids are in 10 id blocks to allow colour changes modulo out 10 and take the remainder for the colour)
			var tile_colour_id = tile_source_id % 10
			
			if tile_colour_id == target_tile_colour_id:
				tilesInAreaThatMatch.append(Vector2i(xValues,yValues))
				
	print("Found: ", tilesInAreaThatMatch.size(), " matching tiles out of ", allTilesInArea.size())
	if tilesInAreaThatMatch.size() >= number_of_required_tiles:
		erase_tile_block(allTilesInArea)

			
func erase_tile_block(tilePosition: Array) -> void:
	print("Erase triggered")
	for tile in tilePosition:
		tilemap.erase_cell(tile)
		await get_tree().create_timer(0.0005).timeout
	queue_free()
	
