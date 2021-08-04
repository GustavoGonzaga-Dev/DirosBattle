extends Node2D

func _on_AnimacaoTransicao_animation_finished(anim_name):
	if anim_name == "Saindo":
		get_tree().change_scene("res://Cenas/Dialogo.tscn")
	else:
		$"Fundo/animaçao/logoAnima".play("logo")
	
func _on_logoAnima_animation_finished(anim_name):
	$"Fundo/animaçao2/animaLogo2".play("Logo2")

func _on_animaLogo2_animation_finished(anim_name):
	if anim_name == "Logo2":
		$"Fundo/animaçao2/animaLogo2".play("batebate")
	elif anim_name == "batebate":
		$Fundo/planetas/planeta1/AnimationPlayerPlaneta.play("surgindopraneta")
		$botao/TextureButton/AnimationPlayerBotao.play("aparecerBotao")

func _on_AnimationPlayerPlaneta_animation_finished(anim_name):
	$Fundo/planetas/planeta1/AnimationPlayerPlaneta.play("RodaRodaJequiti")

func _on_Timer_timeout():
	$botao/TextureButton.visible = not $botao/TextureButton.visible


func _on_AnimationPlayerBotao_animation_finished(anim_name):
	$botao/TouchScreenButton.visible = not $botao/TouchScreenButton.visible
	$Timer.start()


func _on_TouchScreenButton_pressed():
	$Timer.stop()
	$"transição/ColorRect/AnimacaoTransicao".play("Saindo")
