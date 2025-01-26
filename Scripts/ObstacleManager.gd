extends Node3D

#生成するシーンをセット
var obstacle_scenes: Array[PackedScene] = [preload("res://Scenes/obstacle_01.tscn"),preload("res://Scenes/obstacle_02.tscn"),preload("res://Scenes/obstacle_03.tscn")]
const BIRD: int = 0
const UFO: int = 1
const ASTEROID: int = 2
var obstacle_type: int

const WIDTH_MIN: int = -3
const WIDTH_MAX: int = 3
#初期位置
@export var start_positions: Array[Vector3] = [Vector3(-5,0,0),Vector3(5,0,0)]

var direction: Vector3 = Vector3.ZERO

#切り返した回数
var flip_count: int = 0
#切り返しの最大数。obstacleのタイプによって変動
var max_flip_count = 0
@export var speed = 2
var obstacle
var is_enterd: bool = false

#生成直後の処理
func initialize(player_pos: Vector3):
	#生成するobstacleを乱数で指定
	#randi()が0からintの最大値までを返すので、3で割った余剰を渡す
	obstacle_type = randi()%3
	var obstacle_scene = obstacle_scenes[obstacle_type]
	match obstacle_type:
		BIRD:
			speed += BIRD
			max_flip_count = 0
		UFO:
			speed += UFO
			max_flip_count = 3
		ASTEROID:
			speed += ASTEROID
			max_flip_count = 0
		_:
			print("error")
	obstacle = obstacle_scene.instantiate()
	#左右どちらに生成するか指定
	#0が左、1が右	
	var start_pos = start_positions[randi()%2]
	var height_dist = randi()%3 + 6
	#生成位置をPlayerの少し上に指定。後で乱数にする
	start_pos.y = player_pos.y + height_dist
	
	position = start_pos
	#初期位置をみて移動方向を指定
	if start_pos.x > WIDTH_MAX:
		direction.x = -speed
	else:
		direction.x = speed
		
	add_child(obstacle)
	print("plyrpos %s" %player_pos.y)
	print("initpos %s" %start_pos.y)
	
func _process(delta: float):
	if self.position.x <= WIDTH_MAX and self.position.x >= WIDTH_MIN:
		is_enterd = true
	if flip_count < max_flip_count and is_enterd:
		if self.position.x < WIDTH_MIN:
			direction.x = speed
			print("left")
			flip_count += 1
		if self.position.x > WIDTH_MAX:
			direction.x = -speed
			print("right")
			flip_count += 1
	global_translate(direction * delta)
	#print(self.position)
