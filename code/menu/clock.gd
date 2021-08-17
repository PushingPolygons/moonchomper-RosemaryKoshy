extends Label

# Declare member variables
var total_t: float = 0.0
var stopped: bool = false

# Called when the node enters the scene tree for the first time
func _ready():
	text = str(total_t)

# Called every frame. delta_t is the elapsed time since the previous frame
func _process(delta_t):
	if not stopped:
		total_t += delta_t
		text = str(total_t)
