extends MovingElement

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction
var speed = 1
var player
var dist_to_center
var centerPos
var angular_speed

var color
var anchor_variant

signal is_clicked




# Called when the node enters the scene tree for the first time.
func _ready():
	centerPos = position
	#apply_variant(anchor_variant)# TODO typage de l'ancre
	


func stepForward(gameSpeed:float):
	position = position + Vector2(cos(direction)*gameSpeed*speed, sin(direction)*gameSpeed*speed)
	dist_to_center = position-centerPos
	self.rotate(angular_speed)
	

func color(ball_color):
	self.modulate = ball_color
	pass



func _on_Ball_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if(event.is_pressed()):
			match event.button_index:
				BUTTON_LEFT:
					emit_signal("is_clicked",self,true)
				BUTTON_RIGHT:
					emit_signal("is_clicked",self,false)
				_:
					pass

