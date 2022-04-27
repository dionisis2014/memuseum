extends Spatial

signal _spectated(spectator)

var matLightsOff = preload("res://assets/materials/ExibitBase001_LightOff_Material.tres")
var matLightsOn = preload("res://assets/materials/ExibitBase001_LightOn_Material.tres")

export var texture: StreamTexture

func _ready():
	var mat = SpatialMaterial.new()
	mat.albedo_texture = texture
	$ExibitPainting001/Plane.material_override = mat
	$Animation.seek(randf() * $Animation.current_animation_length)

func set_light(state):
	if state:
		$LightR.visible = true
		$LightL.visible = true
		$ExibitBase001/RightLight.material_override = matLightsOn
		$ExibitBase001/LeftLight.material_override = matLightsOn
	else:
		$LightR.visible = false
		$LightL.visible = false
		$ExibitBase001/RightLight.material_override = matLightsOff
		$ExibitBase001/LeftLight.material_override = matLightsOff

func _on_Spectator_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("_spectated", $Spectator)
		set_light(true)

func _on_Spectator_body_exited(body):
	if body.is_in_group("player"):
		set_light(false)
