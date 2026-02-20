extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980.0

var is_dodging = false
var dodge_timer = 0.0          # ← counts down instead of using await
const DODGE_DURATION = 0.2    # ← how long the dodge lasts in seconds

func _physics_process(delta):

	# COUNT DOWN DODGE TIMER every frame
	if dodge_timer > 0:
		dodge_timer -= delta
		if dodge_timer <= 0:
			is_dodging = false  # dodge expired, back to normal

	# 1. GRAVITY
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# 2. JUMP
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. DIRECTION
	var direction = Input.get_axis("ui_left", "ui_right")

	# 4. DODGE — Tab key
	if Input.is_action_just_pressed("ui_focus_next") and not is_dodging:
		is_dodging = true
		dodge_timer = DODGE_DURATION
		velocity.x = direction * 600

	# 5. NORMAL MOVEMENT — only when not dodging
	if not is_dodging:
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	# 6. MOVE
	move_and_slide()

	# 7. COLLISION DEBUG
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		print("Collided with: ", col.get_collider().name)
