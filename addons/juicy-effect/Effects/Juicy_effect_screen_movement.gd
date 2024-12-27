extends Juicy_effect
class_name Juicy_effect_screen_movement

# A texture for animating transition, Black = start, White = end
@export var start_uv_offset : Vector2
@export var target_uv_offset : Vector2
@export var curve : Curve
@export var on_top : bool # will also affect UI
@export var revert_on_exit : bool = true
var shader : Shader = preload("../shader/screen_movement_shader.gdshader")
var texture_rect : ColorRect
func Initialize():
	if curve == null :
		curve = load("res://addons/juicy-effect/Resources/Curves/ease0-1.tres")
	

		#if get_node("movement_rect") == null : return
	
	#transistion_sprite.texture = texture
		

	pass

func Play_Enter():
	texture_rect = ColorRect.new()
	texture_rect.name = "movement_rect"
	texture_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	texture_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	texture_rect.material = ShaderMaterial.new()
	texture_rect.material.shader = shader
	add_child(texture_rect)
	pass

 
func Play_Physic_Process():
	var time = curve.sample(curDuration/duration);
	
	var uv = lerp(start_uv_offset,target_uv_offset,time)
	texture_rect.material.set_shader_parameter("uv_offset",uv)
	pass
	
func Play_Process():
	pass
 
func Play_Exit():
	
	if revert_on_exit :
		if texture_rect == null : return
		texture_rect.queue_free()

	else :
		start_uv_offset = target_uv_offset
	pass
 
