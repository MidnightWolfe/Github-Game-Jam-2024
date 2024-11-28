extends Control



func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://level_0.tscn")
	pass 


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	pass 


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass
