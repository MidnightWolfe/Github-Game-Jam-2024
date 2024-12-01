extends AudioStreamPlayer2D
var jump : AudioStream = preload("res://Audio/jump2.wav")
var dash : AudioStream = preload("res://Audio/dash2.wav")
var hurt : AudioStream = preload("res://Audio/dash2.wav")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.volume_db = -5
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
func hurt_sound() -> void:
	self.set_stream(hurt)
	play()
	pass
