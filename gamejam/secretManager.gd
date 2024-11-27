extends Node2D

func process_secrets():
	for secret in get_children():
		if secret.has_method("process_secret"):
			secret.process_secret()
