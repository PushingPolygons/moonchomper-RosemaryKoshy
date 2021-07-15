extends Node2D
class_name Moon

# Member variables:
var health: int = 4

# Called when Moon enters the scene
func _ready() -> void:
	health = 4
	print("Moon Health: ", health)

