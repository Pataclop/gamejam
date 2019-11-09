extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var packedBall = preload("res://Ball.tscn")
var spawnPos:Vector2



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _init(spawnPos:Vector2):
	self.spawnPos = spawnPos

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_random():
	var amount_variants = 3
	var random = rng.randi_range(0, amount_variants-1)
	match random:
		0:
			return getNormalAnchor()
		1:
			return getHeavyAnchor()
		2:
			return getAntiGravityAnchor()
		_:
			return getNormalAnchor()
	

func getNormalAnchor():
	var ball = packedBall.instance()
	# gameplay
	ball.position = spawnPos
	ball.direction = rng.randf_range(0.0, 6.3)
	ball.speed = 0.8
	ball.attraction = 0.995
	# aesthetic
	ball.color = Color(0, 0, 1)
	ball.angular_speed = (rng.randf()-0.5)/5 
	return ball
	
func getHeavyAnchor():
	var ball = getNormalAnchor()
	ball.speed = 0.6
	ball.attraction = 0.990
	
	ball.color = Color(1, 0, 0)
	ball.angular_speed /= 2
	return ball
	
func getAntiGravityAnchor():
	var ball = getNormalAnchor()
	ball.speed = 1
	ball.attraction = 1.005
	
	ball.color = Color(0, 1, 0)
	ball.angular_speed *= 2
	return ball
