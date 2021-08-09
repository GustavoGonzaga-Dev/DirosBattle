extends Node2D

func _ready():
	pass # Replace with function body.
	
func _on_AnimacaoTransicao_animation_finished(anim_name):
	if anim_name == "Entrando":
		$Estatus/AnimationPlayer.play("aparecendo")
		$"Ovos/OVO-VERDE/AnimationOvoVerde".play("Aparecendo")
	elif anim_name == "Saindo":
		pass

func _on_AnimationPlayer_animation_finished(anim_name):
	$Estatus.IniciarTudo()
	$"Ovos/OVO-VERDE/AnimationOvoVerde".play("mexendo")
