extends KinematicBody

export var speed_walk = 1.34
export var speed_run = 2.23
export var gravity = 9.78
export var speed_jump = 2.7

export var mouse_sensitivity = 0.001

var state_running = false
var state_jumping = false
export var state_enabled = true
export var state_cam_enabled = true

export var velocity = Vector3.ZERO

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if state_cam_enabled:
			var yaw = fmod($Pivot.rotation[1] - event.relative.x * mouse_sensitivity, PI * 2.0)
			var pitch = clamp($Pivot/Camera.rotation[0] - event.relative.y * mouse_sensitivity, -PI * 179.0 / 360.0, PI * 179.0 / 360.0)
			$Pivot.set_rotation(Vector3(0.0, yaw, 0.0))
			$Pivot/Camera.set_rotation(Vector3(pitch, 0.0, 0.0))

func get_input():
	var direction: Vector3
	var view = $Pivot/Camera.global_transform.basis
	
	if Input.is_action_pressed("player_move_forward"):
		direction -= view[2]
	if Input.is_action_pressed("player_move_back"):
		direction += view[2]
	if Input.is_action_pressed("player_move_left"):
		direction -= view[0]
	if Input.is_action_pressed("player_move_right"):
		direction += view[0]
	state_running = Input.is_action_pressed("player_action_run")
	state_jumping = Input.is_action_pressed("player_move_jump")
	
	return direction

func _physics_process(delta):
	if state_enabled:
		var velocity_move = get_input()
		
		velocity_move.y = 0
		velocity_move = velocity_move.normalized()
		if state_running:
			velocity_move *= speed_run
		else:
			velocity_move *= speed_walk
		velocity.x = velocity_move.x
		velocity.z = velocity_move.z
		
		if state_jumping and is_on_floor():
			velocity.y = speed_jump
		velocity.y -= gravity * delta
	
	velocity = move_and_slide(velocity, Vector3.UP)
