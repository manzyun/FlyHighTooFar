extends CharacterBody3D

#signal is_enterd
var isenterd: bool = false

func _on_visible_on_screen_notifier_3d_screen_exited():
	print(position)
	queue_free()

func get_enterd():
	return isenterd

func _on_visible_on_screen_notifier_3d_screen_entered() :
	#is_enterd.emit()
	isenterd = true
