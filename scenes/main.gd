extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Exibit1.connect("_spectated", $Player, "_exibit_spectate")
	$Exibit2.connect("_spectated", $Player, "_exibit_spectate")
	$Exibit3.connect("_spectated", $Player, "_exibit_spectate")
	$Exibit4.connect("_spectated", $Player, "_exibit_spectate")
	randomize()
