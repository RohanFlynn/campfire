extends Button

@export var pause_menu: Control

func _on_texture_button_pressed() -> void:
	pause_menu.open()
