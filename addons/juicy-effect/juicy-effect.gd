@tool
extends EditorPlugin

var inspector_plugin
func _enter_tree():
	if Engine.is_editor_hint():
		# Add our custom Go button!
		inspector_plugin = preload("res://addons/juicy-effect/Editor/inspector_button_plugin.gd").new()
		add_inspector_plugin(inspector_plugin)
	# Initialization of the plugin goes here.
	pass


func _exit_tree():
	remove_inspector_plugin(inspector_plugin)
	# Clean-up of the plugin goes here.
	pass
	
func _init():
	var is_editor: bool = Engine.is_editor_hint()
	if is_editor:
		add_autoload_singleton("JuicyPersist", "res://addons/juicy-effect/Logic/autoload/Juicy_persist.gd")
