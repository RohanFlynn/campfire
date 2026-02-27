extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var asprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	leftright(direction)
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
