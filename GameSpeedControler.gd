extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gameSpeed:float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func step():
	pass
	
func registerMovingElement(element:MovingElement):
	
	element.stepForward(gameSpeed)
	# //TODO
	
func _on_Anchor_is_clicked(elementClicked):
	print("elem : ",typeof(elementClicked))
	if elementClicked != self.owner: #it's an anchor
		self.rootAnchor = elementClicked
	pass