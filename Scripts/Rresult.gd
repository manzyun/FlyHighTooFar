extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_just_pressed("click"):
		GameManager.load_title_scene()
