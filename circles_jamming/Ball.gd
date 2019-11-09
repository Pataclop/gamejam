extends MovingElement

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction
var speed = 0.8
var player
var dist_to_center
var centerPos
var angular_speed

enum anchor_variants {RED, GREEN, BLUE}
var anchor_type

# Called when the node enters the scene tree for the first time.
func _ready():
	centerPos = position
	print(anchor_type)


func stepForward(gameSpeed:float):
	
	position = position + Vector2(cos(direction)*gameSpeed*speed, sin(direction)*gameSpeed*speed)
	dist_to_center = position-centerPos
	self.rotate(angular_speed)
	

func color(ball_color):
	self.modulate = ball_color
	pass



func _on_Ball_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			player._on_Target_is_clicked(self, true)
		if event.is_pressed() and event.button_index == BUTTON_RIGHT:
			player._on_Target_is_clicked(self, false)
