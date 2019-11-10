extends MovingElement

class_name TimerScript
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
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
	else:
		# //TODO : control time left as well.
		if($Timer.paused):
			$Timer.start(time)
		$Timer.set_wait_time( time/gameSpeed )
