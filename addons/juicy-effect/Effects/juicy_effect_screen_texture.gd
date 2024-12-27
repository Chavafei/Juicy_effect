extends Juicy_effect
class_name juicy_effect_screen_texture
## an effect in which will show a texture on screen for a duration

# A texture for animating transition, Black = start, White = end
@export var texture : Texture
var texture_rect : TextureRect
@export var color_modulation : Color = Color.WHITE

func Initialize():
	
	
	
	
	pass

func Play_Enter():
	texture_rect = TextureRect.new()
	texture_rect.name = "texture_rect"
	texture_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	texture_rect.modulate = color_modulation
	texture_rect.texture = texture
	add_child(texture_rect)
	#transistion_sprite.texture = texture
	
	pass
 
func Play_Physic_Process():

	pass
	
func Play_Process():
	pass
 
func Play_Exit():
	texture_rect.queue_free()
	pass
 
