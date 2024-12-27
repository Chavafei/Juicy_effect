extends Juicy_effect
class_name Juicy_effect_scale

@export var target_node : Node

## The target scale when the curve value is 1
@export var target_scale : Vector3 = Vector3(1,1,1) # a scale at curve one

@export var mode : transformtype = transformtype.Additive


@export var curve : Curve

## will force revert back to the original scale when the effect is finished.
@export var revert_on_exit : bool = true

@export_group("Target Scale Advance")
## If this is true, the effect will use these curve for specific axis instead.
@export var advance_target_scale : bool
@export var curve_x : Curve
@export var curve_y : Curve
@export var curve_z : Curve

var initial_scale;

func Play_Enter():
	initial_scale = target_node.scale;
	
	
	pass
 

func Play_Physic_Process():
	var tar_s = target_scale
	if !target_node is Node3D :
		tar_s  = Vector2(target_scale.x,target_scale.y)
	
	if mode == transformtype.Additive :
	
		if !advance_target_scale :
			var curve_value = curve.sample(curDuration/duration)
			target_node.scale = initial_scale + (curve_value * (tar_s - initial_scale));
		
		if advance_target_scale:
			
			var curve_val_x = curve_x.sample(curDuration/duration)
			var curve_val_y = curve_y.sample(curDuration/duration)
			var curve_val_z = curve_z.sample(curDuration/duration)
			
			var target_scale_x = curve_val_x * (tar_s.x - initial_scale.x)
			var target_scale_y = curve_val_y * (tar_s.y - initial_scale.y)
			var target_scale_z = curve_val_z * (tar_s.z - initial_scale.z)
			var v = Vector3(target_scale_x,target_scale_y,target_scale_z)
			target_node.scale = initial_scale + v;
			
			
			pass
		
	elif mode == transformtype.Absolute :
		if !advance_target_scale :
			var curve_value = curve.sample(curDuration/duration)
			#target_node.scale = initial_scale + (curve_value * (tar_s - initial_scale));
			target_node.scale = lerp(target_node.scale,tar_s,curve_value)
		
		if advance_target_scale:
			
			var curve_val_x = curve_x.sample(curDuration/duration)
			var curve_val_y = curve_y.sample(curDuration/duration)
			var curve_val_z = curve_z.sample(curDuration/duration)
			
			var target_scale_x = curve_val_x * (tar_s.x - initial_scale.x)
			var target_scale_y = curve_val_y * (tar_s.y - initial_scale.y)
			var target_scale_z = curve_val_z * (tar_s.z - initial_scale.z)
			var v = Vector3(target_scale_x,target_scale_y,target_scale_z)
			#target_node.scale = initial_scale + v;
			target_node.scale.x = lerp(target_node.scale.x,tar_s.x,curve_val_x)
			target_node.scale.y = lerp(target_node.scale.y,tar_s.y,curve_val_y)
			target_node.scale.z = lerp(target_node.scale.z,tar_s.z,curve_val_z)
			
			
			pass
	
	pass
	
func Play_Process():
	pass
 
func Play_Exit():
	if revert_on_exit :
		target_node.scale = initial_scale
	pass


#idk how to use this yet
enum transformtype {
	Absolute,
	Additive
	
	
}
