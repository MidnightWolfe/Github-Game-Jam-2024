extends CanvasLayer

const CHAR_READ_RATE = .075

@onready var textbox_container = $TextBoxContainer
@onready var start = $TextBoxContainer/MarginContainer/HBoxContainer/Start
@onready var end = $TextBoxContainer/MarginContainer/HBoxContainer/End
@onready var text_on_screen = $TextBoxContainer/MarginContainer/HBoxContainer/TextOnScreen
@onready var tween 
var text_to_be0 = ""
var text_to_be1 = ""
var text_to_be2 = ""
var text_to_be3 = ""
var text_to_be4 = ""
var finished = false

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print("Starting state READY")
	hide_textbox()
	queue_text(text_to_be0)
	queue_text(text_to_be1)
	queue_text(text_to_be2)
	queue_text(text_to_be3)
	queue_text(text_to_be4)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
			else:
				print("set kill true")
				finished = true
			pass
		State.READING:
			if Input.is_action_just_pressed("down"):
				text_on_screen.visible_characters = -1
				change_state(State.READY)
			pass
	pass

func queue_text(next_text):
	if next_text != "":
		text_queue.push_back(next_text)
	pass

func hide_textbox():
	text_on_screen.text = ""
	textbox_container.hide()
	pass
func show_textbox():
	textbox_container.show()
	pass
func display_text():
	var next_text = text_queue.pop_front()
	text_on_screen.text = next_text
	change_state(State.READING)
	show_textbox()
	#tween = get_tree().create_tween()
	#tween.connect("finished", on_tween_finished)
	#tween.tween_property(text_on_screen, "visible_characters", len(next_text), len(next_text) * CHAR_READ_RATE)
	#tween.play()

	pass

func on_tween_finished():
	print("hit finished")
	change_state(State.FINISHED)
	pass

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changed to state READY")
			pass
		State.READING:
			print("Changed to state READING")
			pass
