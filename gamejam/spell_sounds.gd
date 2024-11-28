extends AudioStreamPlayer2D
var spell_red : AudioStream = preload("res://Audio/red_spell.mp3")
var spell_green : AudioStream = preload("res://Audio/green_spell.mp3")
var spell_blue : AudioStream = preload("res://Audio/blue_spell.mp3")
#var spell_green : AudioStream = preload("res://Audio/background.mp3")
#var spell_green : AudioStream = preload("res://Audio/background.mp3")
#var spell_green : AudioStream = preload("res://Audio/background.mp3")

func spell_red_sound() -> void:
	self.volume_db = -5
	self.set_stream(spell_red)
	play()
	pass
func spell_green_sound() -> void:
	self.volume_db = -5
	self.set_stream(spell_green)
	play()
	pass
func spell_blue_sound() -> void:
	self.volume_db = -10
	self.set_stream(spell_blue)
	play()
	pass
