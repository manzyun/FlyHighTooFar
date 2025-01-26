extends Label

func _process(delta: float) :
	text = "Score: %s m" %GameManager.score
