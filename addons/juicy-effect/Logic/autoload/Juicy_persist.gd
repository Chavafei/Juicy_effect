extends Node
class_name Juicy_persist

# this is the autoload script for holding a singular object

var global_camera_3d : Camera3D # for camera transition
var global_camera_3d_initial_fov : float = 45.0


func _ready():
	if get_viewport().get_camera_3d() : global_camera_3d_initial_fov = get_viewport().get_camera_3d().fov
