extends Node

class_name GameSpeedControler
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gameSpeed:float = 1.0

var movingElementArray:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func step():
	for elem in movingElementArray:
		if( ! elem.get_ref()):
			movingElementArray.erase(elem)
			print("movingElement unregistered")
		else:
			elem.get_ref().stepForward(gameSpeed)
	
func registerMovingElement(element:MovingElement):
	movingElementArray.append(weakref(element))
	
	
func _on_Anchor_is_clicked(elementClicked):
	if elementClicked != self.owner: #it's an anchor
		pass
	pass