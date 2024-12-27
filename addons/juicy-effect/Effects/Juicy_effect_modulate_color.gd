extends Juicy_effect
class_name Juicy_effect_modulate_color

@export var target_node : Node
@export var target_color : Color # a scale at curve one
@export var curve : Curve
@export var revert_on_exit : bool
@export var type : modulate_type
var initial_color
 # this will call right away when the scene start
func Initialize():
	pass
	
 # this will call right away regardless of delay
func Pre_Enter():
	pass

# this will call when the effect start playing
func Play_Enter(): 
	match type :
		modulate_type.modulate :
			initial_color = target_node.modulate
		modulate_type.self_modulate :
			initial_color = target_node.self_modulate
	
	pass
 
func Play_Physic_Process():
	var curve_value = curve.sample(curDuration/duration)
	
	match type :
		modulate_type.modulate :
			target_node.modulate = lerp(initial_color,target_color,curve_value)
		modulate_type.self_modulate :
			target_node.self_modulate = lerp(initial_color,target_color,curve_value)
	pass
	
func Play_Process():
	pass
	
 # this will call when the effect stop playing
func Play_Exit(): 
	if revert_on_exit :
		match type :
			modulate_type.modulate :
				target_node.modulate = initial_color
			modulate_type.self_modulate :
				target_node.self_modulate = initial_color
		
		
	pass

enum modulate_type {
	modulate,
	self_modulate
}
	
