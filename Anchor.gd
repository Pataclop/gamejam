extends MovingElement

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
class_name Anchor
signal is_clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	#self.connect("is_clicked",self.owner.get_node("Player"),"on_is_clicked")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		emit_signal("is_clicked",self)
		
		