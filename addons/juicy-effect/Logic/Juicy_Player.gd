@icon("../icons/juicy_player_icon.svg")

extends Node
class_name Juicy_player

signal juice_play()
signal juice_player_end() # call when all juice effect has been played

@export var autoplay : bool
@export_category("Debug")
## pretend these are button on inspector, idk how to make button on inspector
@export var debug_play_button: bool:
	set(value):
		Play()

var child_effect_playing : Array[Juicy_effect]
# Called when the node enters the scene tree for the first time.
func _ready():

	for child in get_children():
		if child is Juicy_effect:
			child.on_stop.connect(func() :
				child_effect_playing.erase(child)
				if child_effect_playing.size() <= 0 :
					juice_player_end.emit()
				)
	
	
	
	if autoplay:
		Play()

func Play():
	juice_play.emit()
	for child in get_children():
		if child is Juicy_effect:
			child_effect_playing.append(child)
			#child.intensity = intensity
			var juicy : Juicy_effect = child
			child.Play()
			if child.stopper :
				await child.on_stop
			



func Stop():
	for child in get_children():
		if child is Juicy_effect:
			var juicy : Juicy_effect = child
			child.Stop()
