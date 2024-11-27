extends Node2D

@onready var area_to_check = $AreaToCheck
@onready var area_to_remove = $AreaToRemove

func process_secret():
	if area_to_check and area_to_remove:
		var matching_tiles = area_to_check.get_matching_tiles()
		if matching_tiles.size() >= area_to_check.match_threshold:
			area_to_remove.remove_tiles()
