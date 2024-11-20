extends StaticBody2D

const TEXTBOX = preload("res://textbox.tscn")
var tbinstance
var firstbug = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
		tbinstance.text_to_be0 = "new text from player0"
		tbinstance.text_to_be1 = "new text from player1"
		tbinstance.text_to_be2 = "new text from player2"
		#tbinstance.text_to_be3 = "new text from player3"
		#tbinstance.text_to_be4 = "new text from player4"
		add_child(tbinstance)
	else:
		#print("did not create another instance")
		pass
	pass 
func _on_area_2d_body_exited(body: Node2D) -> void:
	if tbinstance != null:
			#print("freed textbox from area exited")
			tbinstance.queue_free()
	pass 
