extends TextureProgressBar

@export var player: Player

func _ready():
	player.healthChanged.connect(update_health)
	update_health()


func update_health():
	value = player.currentHealth
	##Testing things
	#print("This is the value of the health bar")
	#print(value)
	pass
