extends Marker3D

@export var height_dist = 5
func set_pos(position: Vector3):
	self.position.y = position.y + height_dist
