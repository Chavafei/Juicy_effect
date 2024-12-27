extends MarginContainer

var object: Object

func _init(obj: Object, text:String):
	object = obj
	size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	var button := Button.new()
	add_child(button)
	button.size_flags_horizontal = SIZE_EXPAND_FILL
	button.text = text
	print(object.name)
	button.button_down.connect(_on_button_pressed.bind(object, "_on_button_pressed"))
	#button.connect("pressed", button,"_on_button_pressed" )
# FIXME : Fuck you, why the hell can't I connect to the method in inherited class function
func _on_button_pressed(object, function):

	var expr = Expression.new()
	expr.parse(function)
	expr.execute([], object)

