extends Node2D

#var existe
var btn

var saveData = {
	
}

# path string
var saveGameFileName: String = "res://ArquivosBanco/informacoesDiro.txt"

func _ready():
	loadData()

func loadData() -> void:
	var dataFile = File.new()
	if not dataFile.file_exists(saveGameFileName):
		#existe = false
		print("Não Existe Arquivo")
		#return 
	else:
		#existe = true
		print("Existe Arquivo")
		#$botao/TextureButton.visible = not $botao/TextureButton.visible
		dataFile.open(saveGameFileName, File.READ)
		while dataFile.get_position() < dataFile.get_len():
			var nodeData = parse_json(dataFile.get_line())
			saveData.ovoEscolhido = nodeData["ovoEscolhido"]
			saveData.Fome = nodeData["Fome"]
			saveData.Sede = nodeData["Sede"]
			saveData.Triste = nodeData["Triste"]
			saveData.lv = nodeData["lv"]
	dataFile.close()

func _on_AnimacaoTransicao_animation_finished(anim_name):
	if anim_name == "Saindo":
		if btn == 1:
			get_tree().change_scene("res://Cenas/Dialogo.tscn")
		elif btn == 2:
			get_tree().change_scene("res://Cenas/HomeDiro.tscn")
	else:
		$"Fundo/animaçao/logoAnima".play("logo")
	
func _on_logoAnima_animation_finished(anim_name):
	$"Fundo/animaçao2/animaLogo2".play("Logo2")

func _on_animaLogo2_animation_finished(anim_name):
	if anim_name == "Logo2":
		$"Fundo/animaçao2/animaLogo2".play("batebate")
	elif anim_name == "batebate":
		$Fundo/planetas/planeta1/AnimationPlayerPlaneta.play("surgindopraneta")
		if saveData.get("ovoEscolhido") == "C":
			#$botao/TextureButton/AnimationPlayerBotao.play("aparecerBotao")
			$botao/Iniciar/AnimationPlayerBotao.play("aparecerBotao")
		else:
			$botao/Voltando/AnimationPlayerBotao2.play("aparecerBotao")
			#$botao/BotaoContinue/AnimationPlayer.play("aparecendo")

func _on_AnimationPlayerPlaneta_animation_finished(anim_name):
	$Fundo/planetas/planeta1/AnimationPlayerPlaneta.play("RodaRodaJequiti")

func _on_Timer_timeout():
	if saveData.get("ovoEscolhido") == "C":
		$botao/Iniciar.visible = not $botao/Iniciar.visible
	else:
		$botao/Voltando.visible = not $botao/Voltando.visible

func _on_AnimationPlayerBotao_animation_finished(anim_name):
	$botao/btndd.visible = not $botao/btndd.visible
	$Timer.start()

func _on_AnimationPlayerBotao2_animation_finished(anim_name):
	$botao/btndd.visible = not $botao/btndd.visible
	$Timer.start()

func _on_btndd_pressed():
	if saveData.get("ovoEscolhido") == "C":
		btn = 1
		$"transição/ColorRect/AnimacaoTransicao".play("Saindo")
	else:
		btn = 2
		$"transição/ColorRect/AnimacaoTransicao".play("Saindo")
