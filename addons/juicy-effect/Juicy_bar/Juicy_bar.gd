#@tool

extends Node
class_name Juicy_bar
signal update_bar()

@export var progress_bar : TextureProgressBar 
var delay_bar
@export var delay_bar_add_color : Color = Color.GREEN
@export var delay_bar_subtract_color : Color = Color.RED

@export_category("Delay Ease")
@export var easeType : Tween.TransitionType
@export var delay_time : float = 0.1

#var tween : Tween
# Called when the node enters the scene tree for the first time.
func _ready():
	if progress_bar == null :
		progress_bar = $TextureProgressBar
	delay_bar = progress_bar.duplicate()
	add_child(delay_bar)
	move_child(delay_bar, 0)
	delay_bar.texture_over = null
	delay_bar.texture_under = null
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
var tween : Tween
func updateBar(new_value : float, max_value : float = 0.0):
	update_bar.emit()
	if tween != null :
		#progress_bar.value = new_value
		#tween.custom_step(1.0)
		pass
	if max_value != 0.0 :
		progress_bar.max_value = max_value
		delay_bar.max_value = max_value
	
	if new_value < progress_bar.value :
		progress_bar.value = new_value
		delay_bar.tint_progress = delay_bar_subtract_color
		
		await get_tree().create_timer(delay_time).timeout
		tween = create_tween()
		tween.tween_property(delay_bar, "value", new_value, delay_time).set_trans(easeType)
		
	if new_value > progress_bar.value :
		delay_bar.value = new_value
		delay_bar.tint_progress = delay_bar_add_color
		tween = create_tween()
		tween.tween_property(progress_bar, "value", new_value, delay_time).set_trans(easeType)
	#value = new_value
	
	pass

func setBar(new_value : float, max_value : float = 0.0):
	update_bar.emit()
	progress_bar.max_value = max_value
	progress_bar.value = new_value
	delay_bar.max_value = max_value
	delay_bar.value = new_value
	
