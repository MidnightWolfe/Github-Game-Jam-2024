extends Control
@onready var sounds = %background_music
@onready var main = $"../../"

func _on_resume_pressed() -> void:
	main.pauseMenu()
	sounds.play()
	pass # Replace with function body.
	
	
	
func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	Engine.time_scale = 1
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
