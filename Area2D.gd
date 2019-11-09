extends Area2D


const BALL_SPEED = 100

var angle = 0
var rng = RandomNumberGenerator.new()
var direction = Vector2(cos(angle), sin(angle))
func _ready():
	rng.randomize()
	angle = rng.randf_range(0.0, 6.3)
	print(angle)
	print(cos(angle))
	direction = Vector2(cos(angle), sin(angle))



var speed = BALL_SPEED

onready var initial_pos = self.position

func _process(delta):
	var width = get_viewport_rect().size[0]
	var heigth = get_viewport_rect().size[1]
	position.x +=direction[0] 
	position.y += direction[1]

	
	
