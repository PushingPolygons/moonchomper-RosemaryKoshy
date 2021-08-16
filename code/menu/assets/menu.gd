extends Control

class_name Menu

var level: Node

func initialize(level_node: Node):
	self.level = level_node

# Called when the menu enters the scene
func _ready():
	self.hide()

func _on_Resume_button_down():
	toggle_pause()


func _on_Restart_button_down():
	get_tree().get_root().get_node("Level")._ready()
	get_tree().get_root().get_node("Level/Moon")._ready()

func _on_Quit_button_down():
	get_tree().quit()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		self.show()
	else:
		self.hide()
