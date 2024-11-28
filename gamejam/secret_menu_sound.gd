extends AudioStreamPlayer2D
var background_in_menu : AudioStream = preload("res://Audio/Axel_Scream.mp3")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_stream(background_in_menu)
	self.volume_db = 20
	play()
	pass # Replace with function body.
