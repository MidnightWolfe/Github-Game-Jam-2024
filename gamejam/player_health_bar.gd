extends TextureProgressBar

@export var player: Player

func _ready():
	player.healthChanged.connect(update_health) #To update the health changed from damage or healing
	update_health()


func update_health():
	value = player.currentHealth #The value of the players current health
	##Testing things
	#print("This is the value of the health bar")
	#print(value)
	pass
