extends TextureProgressBar

@export var player: Player

func _ready():
	player.manaChanged.connect(update_mana)
	update_mana()

func update_mana():
	value = player.currentMana
