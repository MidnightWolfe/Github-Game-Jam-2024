extends CharacterBody2D

var speed = 50
var gravity = 10
var player_chase = false
var player = null

func _ready() -> void:
	$Enemy_Animation.play("enemy")

# Functions to have the enemy chase the player - may not be needed
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true ## bad guy chase player in the "chase zone"

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false ## bad guy stop chasing player - player our of "chase zone"
