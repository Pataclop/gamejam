extends MovingElement

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rootAnchor = self.owner

var basseRotationAmount = PI/150
var baseRopeDecay = 0.99

"""
rotationAmount : angle in rad travelled during this step
ropeDecay : [0.0,1.0] the amount of the rope lost 
	relative to the total length (0 means no decay)
"""
func stepForward(gameSpeed:float):
	var rotationAmount = basseRotationAmount * gameSpeed
	var ropeDecay = baseRopeDecay * gameSpeed
	
	position.x -= rootAnchor.x
	position.y -= rootAnchor.y
	
	var newX = cos(rotationAmount)*position.x - sin(rotationAmount)*position.y
	var newY = sin(rotationAmount)*position.x + cos(rotationAmount)*position.y
	
	position.x = newX
	position.y = newY
	
	position.x += rootAnchor.x*(1-ropeDecay)
	position.y += rootAnchor.y*(1-ropeDecay)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Anchor_is_clicked(elementClicked):
	print("elem : ",typeof(elementClicked))
	if elementClicked != self.owner: #it's an anchor
		self.rootAnchor = elementClicked
	pass
