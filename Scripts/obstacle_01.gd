extends CharacterBody3D

func _on_visible_on_screen_notifier_3d_screen_exited():
	print(position)
	queue_free()
