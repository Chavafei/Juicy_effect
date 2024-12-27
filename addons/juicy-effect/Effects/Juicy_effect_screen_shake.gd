extends Juicy_effect
class_name Juicy_effect_screen_shake

# A texture for animating transition, Black = start, White = end
@export var shake_strength : float = 2.0
@export var on_top : bool # will also affect UI
var shake_shader : Shader = preload("../shader/screen_shake.gdshader")
var texture_rect : ColorRect
func Initialize():
	
	
	
	
	pass

func Play_Enter():
	
	texture_rect = ColorRect.new()
	texture_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	texture_rect.name = "shake_rect"
	texture_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	texture_rect.material = ShaderMaterial.new()
	texture_rect.material.shader = shake_shader
	texture_rect.material.set_shader_parameter("ShakeStrength",shake_strength)

	
	add_child(texture_rect)

	
	#transistion_sprite.texture = texture
	
	pass
 
func Play_Physic_Process():
	pass
	
func Play_Process():
	pass
 
func Play_Exit():
	texture_rect.material.set_shader_parameter("ShakeStrength",0.0)

	texture_rect.queue_free()

 
