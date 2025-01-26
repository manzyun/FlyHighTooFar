extends StaticBody3D

func set_pos(position: Vector3):
	self.position = position

func visible_set():
	self.visible = true
	
func get_visible():
	return visible

func _on_obstacle_detector_body_entered(body: Node3D):
	self.visible = false
	$"../crash".play()
	
	print("collision")
