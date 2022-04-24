extends KinematicBody

export var speed_walk = 1.34
export var speed_run = 2.23
export var speed_run_min = 0.5
export var gravity = 9.78

var running = false
var velocity = Vector3.ZERO

export var mouse_sensitivity = 0.002

var yaw = 0.0
var pitch = 0.0

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		yaw = fmod(yaw - event.relative.x * mouse_sensitivity, 2.0 * PI)
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, -PI / 2.0, PI / 2.0)
		$Pivot.set_rotation(Vector3(0, yaw, 0))
		$Pivot/Camera.set_rotation(Vector3(pitch, 0, 0))

func _physics_process(delta):
	var direction_view = $Pivot/Camera.global_transform.basis
	var direction_move = Vector3.ZERO
	
	if Input.is_action_pressed("game_move_forward"):
		direction_move -= direction_view[2]
	if Input.is_action_pressed("game_move_back"):
		direction_move += direction_view[2]
	if Input.is_action_pressed("game_move_left"):
		direction_move -= direction_view[0]
	if Input.is_action_pressed("game_move_right"):
		direction_move += direction_view[0]
	running = Input.is_action_pressed("game_move_run")
	
	direction_move.y = 0
	direction_move = direction_move.normalized()
	
	var speed = speed_walk
	if running:
		var speed_run_modifier = speed_run_min - (direction_view[2].dot(direction_move))
		speed_run_modifier = clamp(speed_run_modifier, speed_run_min, 1.0)
		speed += speed_run * speed_run_modifier
	
	velocity = direction_move * speed
	
	move_and_slide(velocity, Vector3.UP)
