# Useful Videos for creating the enemy mechanics
	# https://www.youtube.com/watch?v=9u59U-DWNJs
	# https://www.youtube.com/watch?v=SGd9TlqkaFU
	# https://www.youtube.com/watch?v=24hXJnwRim0
extends CharacterBody2D

var speed = 50
var gravity = 10
var player_chase = false
var player = null

var playerInAttackRange = false
var playerAttackCooldown = true
var health = 1  #Enemies are currently one hit
var IsEnemyAlive = true

func _ready() -> void:
	$Enemy_Animation.play("enemy") #The animation that causes the enemy to walk back and forth

func _physics_process(delta: float) -> void:
	player_attack()
	if health <= 0:
		IsEnemyAlive = false
		health = 0
		print("Enemy has been killed")
		self.queue_free() #This makes the enemy disappear - there are currently no (death) animations

## This is currently used to determine if the enemy is in the player hitbox
func enemy():
	pass;

func _on_enemy_hit_box_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerInAttackRange = true

func _on_enemy_hit_box_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		playerInAttackRange = false

##Functions that happen while the player is attacking
#This is currently set up so that when the player touches the enemy, the enemy is "attacked". This should be changed to the spell mechanics
func player_attack():
	if playerInAttackRange and playerAttackCooldown == true:
		health = health - 1
		playerAttackCooldown = false
		$Attack_Cooldown_Timer.start()
		print("Enemy took -1 damage")
		print(health)

func _on_attack_cooldown_timer_timeout() -> void:
	playerAttackCooldown = true
