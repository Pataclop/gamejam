extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var packedCollectible = preload("res://Collectibles.tscn")
var spawnPos:Vector2



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _init(spawnPos:Vector2):
	self.spawnPos = spawnPos
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_random():
	var amount_variants = 6
	var random = rng.randi_range(0, amount_variants-1)
	match random:
		0:
			return getCollectibleBlue()
		1:
			return getCollectibleGreen()
		2:
			return getCollectibleGrey()
		3:
			return getCollectibleOrange()
		4:
			return getCollectiblePink()
		5:
			return getCollectibleYellow()
		_:
			return getCollectibleBlue()
	

func getCollectibleBlue():
	var collectible = packedCollectible.instance()
	collectible.speed = 0.15
	collectible.direction = rng.randf_range(0.0, 6.3)
	collectible.position = spawnPos
	var texture = preload("res://assets/crystal-qubodup-ccby3-32-blue.png")
	collectible.get_node("Sprite").set_texture(texture)
	return collectible
	
func getCollectibleGreen():
	var collectible = packedCollectible.instance()
	collectible.speed = 0.15
	collectible.direction = rng.randf_range(0.0, 6.3)
	collectible.position = spawnPos
	var texture = preload("res://assets/crystal-qubodup-ccby3-32-green.png")
	collectible.get_node("Sprite").set_texture(texture)
	return collectible
	
func getCollectibleGrey():
	var collectible = packedCollectible.instance()
	collectible.speed = 0.15
	collectible.direction = rng.randf_range(0.0, 6.3)
	collectible.position = spawnPos
	var texture = preload("res://assets/crystal-qubodup-ccby3-32-grey.png")
	collectible.get_node("Sprite").set_texture(texture)
	return collectible
	
func getCollectibleOrange():
	var collectible = packedCollectible.instance()
	collectible.speed = 0.15
	collectible.direction = rng.randf_range(0.0, 6.3)
	collectible.position = spawnPos
	var texture = preload("res://assets/crystal-qubodup-ccby3-32-orange.png")
	collectible.get_node("Sprite").set_texture(texture)
	return collectible
	
func getCollectiblePink():
	var collectible = packedCollectible.instance()
	collectible.speed = 0.15
	collectible.direction = rng.randf_range(0.0, 6.3)
	collectible.position = spawnPos
	var texture = preload("res://assets/crystal-qubodup-ccby3-32-pink.png")
	collectible.get_node("Sprite").set_texture(texture)
	return collectible

func getCollectibleYellow():
	var collectible = packedCollectible.instance()
	collectible.speed = 0.15
	collectible.direction = rng.randf_range(0.0, 6.3)
	collectible.position = spawnPos
	var texture = preload("res://assets/crystal-qubodup-ccby3-32-yellow.png")
	collectible.get_node("Sprite").set_texture(texture)
	return collectible
