extends Juicy_effect
class_name Juicy_effect_position

@export var target_node : Node

@export var mode : TransformMode = TransformMode.Local
@export var target_position : Vector3 = Vector3(0,0,0) # a scale at curve one
@export var curve : Curve

@export var revert_on_exit : bool = true
var initial_pos;


@export_group("Target Position Advance")
## If this is true, the effect will use these curve for specific axis instead.
@export var advance_target_pos : bool
@export var curve_x : Curve
@export var curve_y : Curve
@export var curve_z : Curve

## Effect for moving object. a little buggy
## To do :
### - test out the global transform mode

func Play_Enter():
	initial_pos = target_node.position;
	
	pass
 
func Play_Physic_Process():
	var tar_s = target_position

	if !advance_target_pos :
		var curve_value = curve.sample(curDuration/duration)
		
		

		if !target_node is Node3D :
			tar_s  = Vector2(target_position.x,target_position.y)
		
		
		match mode :
			TransformMode.Global :
				pass
			TransformMode.Local :
				target_node.position = initial_pos + (curve_value * tar_s)
		
		
	if advance_target_pos:
		
		var curve_val_x = curve_x.sample(curDuration/duration)
		var curve_val_y = curve_y.sample(curDuration/duration)
		var curve_val_z = curve_z.sample(curDuration/duration)
		
		var target_pos_x = curve_val_x * (tar_s.x - initial_pos.x)
		var target_pos_y = curve_val_y * (tar_s.y - initial_pos.y)
		var target_pos_z = curve_val_z * (tar_s.z - initial_pos.z)
		var v = Vector3(target_pos_x,target_pos_y,target_pos_z)
		target_node.position = initial_pos + v;
		
		
		pass
		
	
	
	
	
	
	pass
	
func Play_Process():
	pass
 
func Play_Exit():
	if revert_on_exit :
		target_node.position = initial_pos
	pass


enum TransformMode {
	Global,
	Local # works like offset
	}

