extends Node2D
class_name Moon

# Member variables:
var Health: int = 0

# Called when the moon enters the scene tree for the first time.
func _ready() -> void:
	Health = 4
	print(Health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
