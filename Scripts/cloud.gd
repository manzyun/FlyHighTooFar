extends StaticBody3D

func _init() :
	visible = false
func visible_set(is_visible: bool):
	self.visible = is_visible
func set_pos(pos: Vector3, tracking_enabled: bool):
	if tracking_enabled:
		self.position.y = pos.y -2
