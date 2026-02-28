extends CharacterBody2D


const SPEED = 300.0
var JUMP_VELOCITY = -600.0
@onready var asprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var tele: TextureRect = $AnimatedSprite2D/TextureRect
var push = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("w") and is_on_floor():
		jump()
	if Input.is_action_pressed("c"):
		moveobplus()
		tele.visible = true
	elif Input.is_action_pressed("x"):
		moveobminus()
		tele.visible = true
	else: 
		tele.visible = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("a", "d")
	leftright(direction)
	if velocity.x < 0:
		asprite.scale.x = -1
	elif velocity.x > 0:
		asprite.scale.x = 1
	animate()
	move_and_slide()

func leftright(d):
	if d:
		velocity.x = d * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
func animate():
	if velocity.y == 0:	
		if velocity.x != 0:
			asprite.play("walk")
		else:	
			asprite.play("idle")

func jump():
	velocity.y = JUMP_VELOCITY

func moveobplus():
	get_tree().call_group("digle", "rot", push)
	push += 1

func moveobminus():
	get_tree().call_group("digle", "rot", push)
	push -= 1
