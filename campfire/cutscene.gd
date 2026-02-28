extends Control

var lines = ["hey big dawg!!!", "...", "big dawg you gotta help me my ship crashed"];
var line = 0
var turn = false
@onready var m1: Label = $man1/Label
@onready var m2: Label = $man2/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if line != len(lines):
			if turn:
				m2.text = lines[line]
				line += 1
				turn = false
			else:
				m1.text = lines[line]
				line += 1
				turn = true
			
