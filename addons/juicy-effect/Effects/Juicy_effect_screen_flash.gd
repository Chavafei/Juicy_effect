extends Juicy_effect
class_name  Juicy_effect_screen_flash

@export var startColor : Color = Color.WHITE
@export var endColor : Color = Color.TRANSPARENT

var color_rect : ColorRect
func Initialize():
	
	
	pass
 # this will call right away regardless of delay
func Pre_Enter():
	pass

# this will call when the effect start playing
func Play_Enter(): 
	
	color_rect = ColorRect.new()
	color_rect.name = "FlashRect"
	color_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	color_rect.z_index = 10
	color_rect.color = startColor
	add_child(color_rect)

	pass
 
func Play_Physic_Process():
	var time = curDuration/duration
	color_rect.color = lerp(startColor,endColor,time)
	pass
	
func Play_Process():
	pass
	
 # this will call when the effect stop playing
func Play_Exit(): 
	#remove_child(color_rect)
	color_rect.queue_free()
	pass
