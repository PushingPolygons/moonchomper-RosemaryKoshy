extends Node

# Member variables:
var chomper_ps: PackedScene = preload("res://Chomper/Chomper.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chomper: Chomper = chomper_ps.instance()
	self.add_child(chomper)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
