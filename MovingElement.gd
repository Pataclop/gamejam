extends Node2D

class_name MovingElement
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func is_type(type): return type == "MovingElement" or type == "Node2D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func stepForward(gameSpeed:float):
	pass