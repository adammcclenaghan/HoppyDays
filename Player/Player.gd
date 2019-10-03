extends KinematicBody2D

var motion = Vector2(0,0)
const SPEED = 1500
const GRAVITY = 150
const UP = Vector2(0,-1)
const DOWN = Vector2(0,1)
const JUMP_SPEED = 3500

signal animate

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()

func move():
	motion.y += GRAVITY
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0
	move_and_slide(motion, UP)

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED


func apply_gravity():
	if is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY
		

func animate():
	emit_signal("animate", motion)