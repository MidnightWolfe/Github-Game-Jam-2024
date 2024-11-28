extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://level_0.tscn")
	pass # Replace with function body.
	

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://credits.tscn")
	pass # Replace with function body.
	
	

func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_secret_pressed() -> void:
	get_tree().change_scene_to_file("res://secret_screen.tscn")
	pass # Replace with function body.
