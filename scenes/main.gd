extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Exibit1.connect("_spectated", $Player, "_exibit_spectate")
	$Exibit2.connect("_spectated", $Player, "_exibit_spectate")
	$Exibit3.connect("_spectated", $Player, "_exibit_spectate")
	$Exibit4.connect("_spectated", $Player, "_exibit_spectate")
	randomize()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("player_action_click") and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
