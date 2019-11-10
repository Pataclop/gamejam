extends MovingElement

class_name ParticleScript
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ptcles
var ptcles2

# Called when the node enters the scene tree for the first time.
func _ready():
	ptcles = get_node("Particles2D")
	ptcles.position = position
	ptcles2 = get_node("Particles2D2")
	ptcles2.position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func stepForward(gameSpeed:float):
	ptcles.speed_scale = gameSpeed
	ptcles2.speed_scale = gameSpeed
