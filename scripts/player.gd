extends CharacterBody2D

const SPEED = 300.0          # Runner moves automatically
const JUMP_VELOCITY = -450.0
const GRAVITY = 980.0

func _physics_process(delta):
	# Auto-run to the right (endless runner style)
	velocity.x = SPEED

	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()
