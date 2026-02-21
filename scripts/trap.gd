extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		# Restart the current level instantly
		get_tree().reload_current_scene()
