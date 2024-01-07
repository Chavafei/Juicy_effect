extends Juicy_effect
class_name Juicy_effect_player

@export var target_Player : Juicy_player

func Initialize():
	pass

func Play_Enter():
	target_Player.Play()
	pass
 
func Play_Physic_Process():
	pass
	
func Play_Process():
	pass
 
func Play_Exit():
	pass
