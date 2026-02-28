extends Control

func _ready():
	visible = false

func open():
	visible = true
	get_tree().paused = true

func close():
	visible = false
	get_tree().paused = false

func _on_resume_button_pressed():
	close()
