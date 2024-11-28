extends TileMapLayer

var debugReadout = true

# Dictionary to map colors to tile offsets
var colour_to_offset = {
	"Black": 0,
	"Red": 1,
	"Green": 2,
	"Blue": 3,
	"Yellow": 4,
	"Magenta": 5,
	"Cyan": 6,
	"White": 0
	
}

# The Ranges for each category of tiles
var category_ranges = {
	"grass": range(0, 7),
	"cloud": range(10, 17),
	"block": range(20, 27),
	"bgplant": range(30, 37)
}

# When a particle from particleburst collides with the tilemap we replace the tile with a coloured tile
func handle_particle_collision(particle: Node2D) -> void:
	if debugReadout: print("Particle Collision Detected")
		
	# Get the particle's position in local coordinates
	var world_position = particle.global_position
	var tilemap_scale = scale.x
	var local_position = world_position / tilemap_scale
	var center_tile_position = local_to_map(local_position)
	if debugReadout: print("World Position: ", world_position)
	if debugReadout: print("Local Position: ", local_position)
	if debugReadout: print("Center Tile Position: ", center_tile_position)
	
	for x_offset in range(-2,3):
		for y_offset in range(-2,3):
			var tile_position = center_tile_position + Vector2i(x_offset, y_offset)
			# Get Tile ID
			var current_tile_id = get_cell_source_id(tile_position)
			if current_tile_id == -1:
				if debugReadout: print("No Tile found at collision")
				continue
			if debugReadout: print("Current Tile ID: ", current_tile_id)
			
			#Get the Atlas coords so the tile is the same style just different colour
			var atlas_coords = get_cell_atlas_coords(tile_position)
			if debugReadout: print("Atlas Coordinate: ", atlas_coords)
			
			# Set the Tile's category
			var category = null
			for key in category_ranges.keys():
				if int(current_tile_id) in category_ranges[key]:
					category = key
					break
			if debugReadout: print("Category: ", category)
			if category == null:
				if debugReadout: print("No matching category for the tile. Contact Ryan")
				continue
				
			# Now that we have the category we need to find the greyversion then from that the colour version
			var base_colour_id = category_ranges[category][0]
			var offset = colour_to_offset.get(particle.colour, -1)
			if offset == -1:
				if debugReadout: print("Invalid Colour, contact Ryan")
				continue
			if debugReadout: print("BaseID: ", base_colour_id)
			var coloured_tile_id = base_colour_id + offset
			if debugReadout: print("WithOffset: ", coloured_tile_id)
			

			if debugReadout: print("Replacing tile at ", tile_position, " with Atlas: ", atlas_coords, " with ID ", coloured_tile_id, " and currentID: ", current_tile_id)
			erase_cell(tile_position)
			set_cell(tile_position, coloured_tile_id, atlas_coords)
			if debugReadout: print("After replacing: ", get_cell_source_id(tile_position), " Atlas: ", get_cell_atlas_coords(tile_position))


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.	
