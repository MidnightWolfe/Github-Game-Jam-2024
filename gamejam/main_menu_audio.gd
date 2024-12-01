extends AudioStreamPlayer2D
var background_in_game : AudioStream = preload("res://Audio/One Man Symphony - Downtempo & Lofi & Progressive Music Pack Vol - 2 (Free) - 04 Hyperfine Timekeeping.mp3")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_stream(background_in_game)
	self.volume_db = -25
	play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
