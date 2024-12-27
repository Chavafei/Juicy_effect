extends Juicy_effect
class_name Juicy_effect_position

@export var target_node : Node

## if true, the movement will also affect by collision, the target node need to be a Collisionbody stuff (idk what to call it) 
## this does not support Advance curve yet
@export var affect_by_collision : bool 

# use this in case there are other operation that also change the position of the object, it will try to mix together 
@export var mix_mode : bool

@export var mode : TransformMode = TransformMode.Local
@export var target_position : Vector3 = Vector3(0,0,0) # a scale at curve one
@export var curve : Curve

@export var revert_on_exit : bool = true
var initial_pos;

@export_group("Object based targeting")
## If the Node is assigned, the target position will use the position from this instead. otherwise it just use the normal target_position
@export var target_object_position : Node 


@export_group("Lock Axis")
@export var lock_X : bool
@export var lock_Y : bool
@export var lock_Z : bool

@export_group("Target Position Advance")
## If this is true, the effect will use these curve for specific axis instead.
@export var advance_target_pos : bool
@export var curve_x : Curve
@export var curve_y : Curve
@export var curve_z : Curve

@export_group("Target Position Offset")
## If this is true, the effect will use these curve for specific axis instead.
@export var offset_target_pos : bool
@export var offset_position_at_curve_one : Vector3 = Vector3(0,0,0)
@export var offset_curve_x : Curve
@export var offset_curve_y : Curve
@export var offset_curve_z : Curve

## Effect for moving object. a little buggy
## To do :
### - test out the global transform mode
func Initialize():
	if curve == null :
		curve = load("res://addons/juicy-effect/Resources/Curves/ease0-1.tres")
	
func Play_Enter():

	match mode :
		TransformMode.Global :
			initial_pos = target_node.global_position;

		TransformMode.Local :
			initial_pos = target_node.position;

 
func Play_Physic_Process():
	var tar_s = target_position
	


	var curve_value = curve.sample(curDuration/duration)
		
		

	if !target_node is Node3D :
		tar_s  = Vector2(target_position.x,target_position.y)
	if target_object_position != null :
		tar_s = target_object_position.global_position
		
		
	match mode :
		TransformMode.Global :
			if advance_target_pos:
				
				var curve_val_x = curve_x.sample(curDuration/duration)
				var curve_val_y = curve_y.sample(curDuration/duration)
				var curve_val_z = curve_z.sample(curDuration/duration)
				
				var asd : float
				var cx = lerp(initial_pos.x,tar_s.x,curve_val_x)
				var cy = lerp(initial_pos.y,tar_s.y,curve_val_y)
				var cz = lerp(initial_pos.z,tar_s.z,curve_val_z)
				var v = Vector3(cx,cy,cz)
				#var v = Vector3(target_pos_x,target_pos_y,target_pos_z)
				target_node.global_position = v
				
				
			else : 
				
				if affect_by_collision:
					var target_pos_in_curve = initial_pos.lerp(tar_s,curve_value)
					if target_node is PhysicsBody3D :
						var motion = (target_pos_in_curve - target_node.global_position)
						var motion_to_use = Vector3.ZERO
						if !lock_X : 
							target_node.velocity.x  = motion.x
							motion_to_use.x = motion.x
						if !lock_Y : 
							target_node.velocity.y  = motion.y
							motion_to_use.y = motion.y
						if !lock_Z and target_node is Node3D  :
							target_node.velocity.z = motion.z
							motion_to_use.z = motion.z
						
						#target_node.velocity = motion
						
						
						target_node.move_and_collide(motion_to_use)
						#target_node
					
					
				else :
					var new_pos = initial_pos.lerp(tar_s,curve_value)
					#target_node.global_position = 
					
					if !lock_X : 
						target_node.global_position.x = new_pos.x
					if !lock_Y : 
						target_node.global_position.y = new_pos.y
					if !lock_Z and target_node is Node3D  : 
						target_node.global_position.z = new_pos.z
					if offset_target_pos :
						if target_node is Node3D :
							target_node.global_position += get_offset_on_curve()
						else :
							target_node.global_position += Vector2(get_offset_on_curve().x,get_offset_on_curve().y)

			
			pass
		TransformMode.Local :
			
			
			if advance_target_pos:
				
				var curve_val_x = curve_x.sample(curDuration/duration)
				var curve_val_y = curve_y.sample(curDuration/duration)
				var curve_val_z = curve_z.sample(curDuration/duration)
				
				var target_pos_x = curve_val_x * (tar_s.x - initial_pos.x)
				var target_pos_y = curve_val_y * (tar_s.y - initial_pos.y)
				var target_pos_z = curve_val_z * (tar_s.z - initial_pos.z)
				var v = Vector3(target_pos_x,target_pos_y,target_pos_z)
				target_node.position = initial_pos + v;
			else :
				if affect_by_collision :
					var target_pos_in_curve = initial_pos + (curve_value * tar_s)
					
					if target_node is PhysicsBody3D :
						var motion = (target_pos_in_curve - target_node.global_position)
						target_node.velocity = motion
						var motion_to_use = Vector3.ZERO

						if !lock_X : 
							target_node.velocity.x  = motion.x
							motion_to_use.x = motion.x
						if !lock_Y : 
							target_node.velocity.y  = motion.y
							motion_to_use.y = motion.y
						if !lock_Z and target_node is Node3D  :
							target_node.velocity.z = motion.z
							motion_to_use.z = motion.z
						target_node.move_and_collide(motion_to_use)
						
				else :
					
					var new_pos =  initial_pos + (curve_value * tar_s)
					#target_node.global_position = 
					#target_node.position =
					if !lock_X : 
						target_node.position.x = new_pos.x
					if !lock_Y : 
						target_node.position.y = new_pos.y
					if !lock_Z and target_node is Node3D : 
						target_node.position.z = new_pos.z


		
	
	
	
	
func get_offset_on_curve() -> Vector3 :
	var curve_val_x = 0.0
	var curve_val_y = 0.0
	var curve_val_z = 0.0
	if offset_curve_x != null :
		curve_val_x = offset_curve_x.sample(curDuration/duration)
	if offset_curve_y != null :
		curve_val_y = offset_curve_y.sample(curDuration/duration)
	if offset_curve_z != null :
		curve_val_z = offset_curve_z.sample(curDuration/duration)
	
	var v = Vector3(curve_val_x,curve_val_y,curve_val_z)
	return offset_position_at_curve_one * v

	

 
func Play_Exit():
	if revert_on_exit :
		target_node.position = initial_pos
	pass


enum TransformMode {
	Global,
	Local # works like offset
	}
