extends MovingElement

var direction
var centerPos
var angular_speed = 0

const distOfRatio1 = 300

var speed = 0.4

# Called when the node enters the scene tree for the first time.
func _ready():
	centerPos = position
	
	
func is_type(type): return type == "Collectible" or .is_type(type)

func stepForward(gameSpeed:float):	
	get_node("Sprite/AnimationPlayer").play("shine")
	position = position + Vector2(cos(direction)*gameSpeed*speed, sin(direction)*gameSpeed*speed)

	
	var distFromCenter = position.length()
	var scalarScale = max(0.15 , distFromCenter / distOfRatio1)
	self.scale = Vector2(scalarScale,scalarScale)


