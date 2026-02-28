extends Control

var lines = ["hey big dawg!!!", "...", "big dawg you gotta help me my ship crashed", "sure twin dw"];
var line = 0
var turn = false
@onready var m1: Label = $man1/Label
@onready var m2: Label = $man2/Label
@onready var ms1: AnimatedSprite2D = $man1/AnimatedSprite2D
@onready var ms2: AnimatedSprite2D = $man2/AnimatedSprite2D
@onready var mh1: TextureRect = $man1/mh1
@onready var mh2: TextureRect = $man2/mh1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	m1.text = ""
	m2.text = ""
	mh1.visible = true
	mh2.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if line != len(lines):
			if turn:
				m2.text = lines[line]
				ms2.play("default")
				ms1.pause()
				line += 1
				turn = false
				mh1.visible = true
				mh2.visible = false
			else:
				m1.text = lines[line]
				ms1.play("default")
				ms2.pause()
				line += 1
				turn = true
				mh1.visible = false
				mh2.visible = true
