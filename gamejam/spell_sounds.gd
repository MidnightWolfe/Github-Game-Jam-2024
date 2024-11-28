extends AudioStreamPlayer2D
var spell_red : AudioStream = preload("res://Audio/red_spell.mp3")
var spell_green : AudioStream = preload("res://Audio/green_spell.mp3")
var spell_blue : AudioStream = preload("res://Audio/blue_spell.mp3")
var spell_cyan : AudioStream = preload("res://Audio/cyan_spell.mp3")
var spell_magenta : AudioStream = preload("res://Audio/magenta_spell.mp3")
var spell_yellow : AudioStream = preload("res://Audio/yellow_spell.mp3")

func spell_red_sound() -> void:
	self.volume_db = -5
	self.set_stream(spell_red)
	play()
	
func spell_green_sound() -> void:
	self.volume_db = -5
	self.set_stream(spell_green)
	play()
	
func spell_blue_sound() -> void:
	self.volume_db = -10
	self.set_stream(spell_blue)
	play()
	
func spell_cyan_sound() -> void:
	self.volume_db = 0
	self.set_stream(spell_cyan)
	play()
	
func spell_magenta_sound() -> void:
	self.volume_db = 0
	self.set_stream(spell_magenta)
	play()
	
func spell_yellow_sound() -> void:
	self.volume_db = -10
	self.set_stream(spell_yellow)
	play()
