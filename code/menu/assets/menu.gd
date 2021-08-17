extends Control
class_name Menu

var level: Node = null
var score: int = 0

# Called when the menu enters the scene
func _ready():
	$Panel.hide()

func initialize(level_node: Node):
	self.level = level_node

func _on_Resume_button_down():
	toggle_pause()


func _on_Restart_button_down():
	# reset Level and Moon
	get_tree().get_root().get_node("Level")._ready()
	get_tree().get_root().get_node("Level/Moon")._ready()
	toggle_pause() # Resume game

func _on_Quit_button_down():
	get_tree().quit()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		$Panel.show()
	else:
		$Panel.hide()

func update_score(delta_s):
	score += delta_s
	$Score.text = "score: " + str(score)
