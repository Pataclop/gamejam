extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction
var speed = 35
var player
var dist_to_center
var centerPos

# Called when the node enters the scene tree for the first time.
func _ready():
	constant_linear_velocity = Vector2(cos(direction)*speed, sin(direction)*speed)
	centerPos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + Vector2(cos(direction)*delta*speed, sin(direction)*delta*speed)
	dist_to_center = position-centerPos
	


func _on_Ball_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			player._on_Target_is_clicked(self)
