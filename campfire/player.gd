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
var og_scale

func _ready() -> void:
	camera.zoom.x = 1
	camera.zoom.y = 1
	og_scale = global_scale
	
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
	if is_dashing:
		velocity.x = dash_direction * dash_speed
		velocity.y = 0
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			scale = og_scale
	animate()
	check_cam()
	move_and_slide()

func leftright(d):
	if d:
		velocity.x = d * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("n") and not is_on_floor():
		if dashes > 0: 
			is_dashing = true
			dash_timer = dash_time
			dash_direction = sign(velocity.x)
			dashes -= 1
			scale -= Vector2(0.2, 0.2)
			if dash_direction == 0:
				dash_direction = asprite.scale.x
	
func check_cam():
	if camera.limit_right <= position.x:
		camera.limit_right += 1000
		camera.limit_left += 1000
	if camera.limit_left >= position.x:
		camera.limit_left -= 1000
		camera.limit_right -= 1000
	if camera.limit_bottom <= position.y:
		camera.limit_bottom += 640
		camera.limit_top += 640
	if camera.limit_top >= position.y:
		camera.limit_top -= 640
		camera.limit_bottom -= 640
	
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
