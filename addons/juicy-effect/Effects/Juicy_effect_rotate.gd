extends Juicy_effect
class_name Juicy_effect_rotate

@export var target_node : Node3D

## Global don't work for now, I will only update it once I find a use for global rotation
@export var mode : TransformMode = TransformMode.Local
@export var target_mode : TargetMode = TargetMode.Aboslute
@export var initial_rotation : Vector3 = Vector3(0,0,0) # a scale at curve one
@export var target_rotation : Vector3 = Vector3(0,0,0) # a scale at curve one
@export var curve : Curve

@export var revert_on_exit : bool = true
var initial;

## Effect for moving object. a little buggy
## To do :
### - test out the global transform mode
var start_point
func Play_Enter():
	initial = target_node.rotation_degrees;


	
	match target_mode :
		TargetMode.Aboslute: # will rotate from initial_rotation to target_rotation, so the start point is initial_rotation
			start_point =  initial_rotation
			pass
		TargetMode.Additive : # will rotate from the target node current rotation to target_rotation, so the start point is initial
			start_point = initial
			pass
	
	
	#target_node.rotation_degrees = start_point
	pass
 
func Play_Physic_Process():
	var curve_value = curve.sample(curDuration/duration)
	var tar_s = target_rotation
	

	if !target_node is Node3D :
		tar_s  = Vector2(target_rotation.x,target_rotation.y)
	
	

	match mode :
		TransformMode.Global :
			
			pass
		TransformMode.Local : 
			#target_node.rotate_y(curve_value * tar_s.y)
			target_node.rotation_degrees = (start_point - (curve_value * start_point)) + (curve_value * tar_s)
		
	
	
	
	
	
	pass
	
func Play_Process():
	pass
 
func Play_Exit():
	if revert_on_exit :
		target_node.rotation_degrees = initial
	pass


enum TransformMode {
	Global,
	Local
	}
	
enum TargetMode {
	Aboslute,
	Additive 
	}
