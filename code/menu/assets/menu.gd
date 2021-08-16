extends Control

class_name Menu

# Called when the menu enters the scene
func _ready():
	$Panel.hide()

func _on_Resume_button_down():
	get_tree().paused = false
	$Panel.hide()


func _on_Restart_button_down():
	get_tree().get_root().get_node("Level")._ready()
	get_tree().get_root().get_node("Level/Moon")._ready()

func _on_Quit_button_down():
	get_tree().quit()
