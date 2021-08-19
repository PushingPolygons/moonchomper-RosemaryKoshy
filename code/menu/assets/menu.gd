extends Control
class_name Menu

var level: Node = null
const min_score: int = -1000
var score: int = min_score

# Called when the menu enters the scene
func _ready():
	$Panel.hide()
	update_score(0)

func initialize(level_node: Node):
	self.level = level_node

func _on_Resume_button_down():
	toggle_pause()

func _on_Restart_button_down():
	# reset Level, Moon, and score
	get_node('/root/Level')._ready()
	get_node('/root/Level/Moon')._ready()
	score = min_score
	toggle_pause() # Resume game

func _on_Quit_button_down():
	get_tree().quit()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		$Clock.stopped = true
		$Panel.show()
	else:
		$Clock.stopped = false
		$Panel.hide()

func update_score(delta_s):
	score += delta_s
	$Score.text = 'score: ' + str(score)
