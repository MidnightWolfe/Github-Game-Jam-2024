extends Control

@onready var main = $"../../"


func _on_resume_pressed() -> void:
	main.pauseMenu()
	
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
