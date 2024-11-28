extends StaticBody2D

const TEXTBOX = preload("res://textbox.tscn")
var tbinstance
var firstbug = false #Set to false for a better feeling sign - Ryan
@export var textbox_line_1: String = ""
@export var textbox_line_2: String = ""
@export var textbox_line_3: String = ""
@export var textbox_line_4: String = ""
@export var textbox_line_5: String = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if tbinstance != null:
		if tbinstance.finished == true:
			#print("freed textbox")
			tbinstance.queue_free()
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if firstbug == true:
		firstbug = false
		return
	#print("in _on_area_2d_body_entered")
	if tbinstance == null and body.has_method("player"):
		tbinstance = TEXTBOX.instantiate()
		if textbox_line_1 != "":
			tbinstance.text_to_be0 = textbox_line_1
		if textbox_line_2 != "":
			tbinstance.text_to_be1 = textbox_line_2
		if textbox_line_3 != "":
			tbinstance.text_to_be2 = textbox_line_3
		if textbox_line_4 != "":
			tbinstance.text_to_be3 = textbox_line_4
		if textbox_line_5 != "":
			tbinstance.text_to_be4 = textbox_line_5
		add_child(tbinstance)
	else:
		#print("did not create another instance")
		pass
	pass 
func _on_area_2d_body_exited(_body: Node2D) -> void:
	if tbinstance != null:
			#print("freed textbox from area exited")
			tbinstance.queue_free()
	pass 
