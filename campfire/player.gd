extends CharacterBody2D


const SPEED = 300.0
var JUMP_VELOCITY = -600.0
@onready var asprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D

var is_dashing := false
var dash_timer := 0.0
var dash_direction := 0
@export var dash_speed := 800.0
@export var dash_time := 0.2
var jumps = Jamount
var dashes = Damount
const Jamount = 2
const Damount = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps = Jamount
		dashes = Damount
		JUMP_VELOCITY = -600.0

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jumps > 0:
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	leftright(direction)
	if velocity.x < 0:
		asprite.scale.x = -2
	elif velocity.x > 0:
		asprite.scale.x = 2
	animate()
	check_cam()
	move_and_slide()

func leftright(d):
	if d:
		velocity.x = d * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
func check_cam():
	if camera.limit_right <= position.x:
		camera.limit_right += 1000
		camera.limit_left += 1000
	if camera.limit_left >= position.x:
		camera.limit_left -= 1000
		camera.limit_right -= 1000
	
func animate():
	if not is_dashing:
		if velocity.y == 0:	
			if velocity.x != 0:
				asprite.play("run")
			else:	
				asprite.play("idle")
		elif velocity.y > 0:
			asprite.play("jump")
		elif velocity.y < 0:
			asprite.play("fall")
	else:
		asprite.play("dash")

func jump():
	velocity.y = JUMP_VELOCITY
	jumps -= 1
	JUMP_VELOCITY += 200
