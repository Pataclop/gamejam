extends MovingElement

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

class_name Ball

var direction


var speed = 0
var angular_speed
var color setget set_color
var attraction = 1

signal is_clicked

const selectedColor = Color(0.1, 0.1, 0.1)

const distOfRatio1 = 300



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

	#apply_variant(anchor_variant)# TODO typage de l'ancre
	

func is_type(type): return type == "Ball" or .is_type(type)

func stepForward(gameSpeed:float):
	position = position + Vector2(cos(direction)*gameSpeed*speed, sin(direction)*gameSpeed*speed)
	if angular_speed != null:
		self.rotate(angular_speed * gameSpeed)
	var distFromCenter = position.length()
	var scalarScale = max(0.15 , 0.5 * distFromCenter / distOfRatio1)
	self.scale = Vector2(scalarScale,scalarScale)
	
	
	
func reset_color():
	self.modulate = color
	get_node("CollisionShape2D/Node2D/Outside").modulate = color


func set_color(ball_color):
	color = ball_color
	self.modulate = ball_color
	
	
func change_color(ball_color):
	if(ball_color)==selectedColor:
		var outer_sprite = get_node("CollisionShape2D/Node2D/Outside")
		outer_sprite.modulate = ball_color
	else:
		self.modulate = ball_color



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

