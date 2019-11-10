extends MovingElement

var direction
var dist_to_center
var centerPos
var angular_speed = 0


var speed = 0.4

# Called when the node enters the scene tree for the first time.
func _ready():
	centerPos = position
	
func stepForward(gameSpeed:float):	
	get_node("Sprite/AnimationPlayer").play("shine")
	position = position + Vector2(cos(direction)*gameSpeed*speed, sin(direction)*gameSpeed*speed)
	dist_to_center = position-centerPos


