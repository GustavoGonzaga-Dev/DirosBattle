extends Node2D

func _ready():
	pass # Replace with function body.



func _on_AnimacaoTransicao_animation_finished(anim_name):
	if anim_name == "Entrando":
		$Fome.Tempo()
	elif anim_name == "Saindo":
		pass


func _on_TimerFome_timeout():
	pass # Replace with function body.
