extends AudioStreamPlayer2D
var jump : AudioStream = preload("res://Audio/jump.mp3")
var dash : AudioStream = preload("res://Audio/dash.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func jump_sound() -> void:
	self.set_stream(jump)
	play()
	pass
func dash_sound() -> void:
	self.set_stream(dash)
	play()
	pass
