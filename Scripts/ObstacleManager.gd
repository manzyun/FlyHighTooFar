extends Node3D

#生成するシーンをセット
var obstacle_scenes: Array[PackedScene] = [preload("res://Scenes/obstacle_01.tscn"),preload("res://Scenes/obstacle_01.tscn"),preload("res://Scenes/obstacle_01.tscn")]
const BIRD: int = 0
const UFO: int = 1
const ASTEROID: int = 2
var obstacle_type: int

const WIDTH_MIN: int = -2
const WIDTH_MAX: int = 2
#初期位置
@export var start_positions: Array[Vector3] = [Vector3(-3,10,0),Vector3(3,10,0)]

var direction: Vector3 = Vector3.ZERO

#切り返した回数
var flip_count: int = 0
#切り返しの最大数。obstacleのタイプによって変動
var max_flip_count = 0
@export var speed = 4
var obstacle
var is_enterd: bool = false

#生成直後の処理
func initialize(player_pos: Vector3):
	#生成するobstacleを乱数で指定
	#randi()が0からintの最大値までを返すので、3で割った余剰を渡す
	obstacle_type = randi()%3
	var obstacle_scene = obstacle_scenes[obstacle_type]
	obstacle = obstacle_scene.instantiate()
	#左右どちらに生成するか指定
	#0が左、1が右	
	var start_pos = start_positions[randi()%2]
	var height_dist = 0
	#生成位置をPlayerの少し上に指定。後で乱数にする
	start_pos.y = player_pos.y + height_dist
	print("plyrpos %s" %player_pos.y)
	print("initpos %s" %start_pos.y)
	self.position = start_pos
	#初期位置をみて移動方向を指定
	if start_pos.x > WIDTH_MAX:
		direction.x = -speed
	else:
		direction.x = speed
		
	obstacle.position = self.position
	add_child(obstacle)
	
func _process(delta: float):
	
	match obstacle_type:
		BIRD:
			max_flip_count = 0
		UFO:
			max_flip_count = 3
		ASTEROID:
			max_flip_count = 0
		_:
			print("error")
	if self.position.x <= WIDTH_MAX and self.position.x >= WIDTH_MIN:
		is_enterd = true
	if flip_count <= max_flip_count and is_enterd:
		if self.position.x < WIDTH_MIN:
			direction.x = speed
			print("left")
			print(self.position)
			flip_count += 1
		if self.position.x > WIDTH_MAX:
			direction.x = -speed
			print("right")
			print(self.position)
			flip_count += 1
	global_translate(direction * delta)
	#print(self.position)
