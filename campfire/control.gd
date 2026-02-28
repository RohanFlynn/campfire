extends Control

var og_pos


func _ready() -> void:
	og_pos = position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += 1
	if position.x >= og_pos + 900:
		reset()
		
	
func reset():
	position.x = og_pos
