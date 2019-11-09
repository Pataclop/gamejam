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
	pass
	for elem in movingElementArray:
		elem.stepForward(gameSpeed)
	
func registerMovingElement(element:MovingElement):
	movingElementArray.append(element);
	
	
func _on_Anchor_is_clicked(elementClicked):
	print("elem : ",typeof(elementClicked))
	if elementClicked != self.owner: #it's an anchor
		self.rootAnchor = elementClicked
	pass