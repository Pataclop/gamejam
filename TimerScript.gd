extends MovingElement

class_name TimerScript
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 1
var isPaused
# Called when the node enters the scene tree for the first time.
func _ready():
	isPaused = false
	
func start(time):
	self.time = time
	$Timer.start(time)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func stepForward(gameSpeed:float):
	pass
	if(gameSpeed==0):
		$Timer.stop()
		isPaused = true
	else:
		# //TODO : control time left as well.
		if(isPaused):
			$Timer.start(time)
			isPaused = false
		$Timer.set_wait_time( time/gameSpeed )
