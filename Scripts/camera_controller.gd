extends Marker3D

@export var height_dist = 2
func set_pos(pos: Vector3):

	self.position.y = pos.y + height_dist
