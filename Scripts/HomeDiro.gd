extends Node2D

var saveData = {
	
}

var resposta
var AB = 0
var saveGameFileName: String = "res://ArquivosBanco/informacoesDiro.txt"

func _ready():
	self.loadData()
	if saveData.get("lv") !=0:
		$Tocar.visible = not $Tocar.visible
		#$"Tocar/AnimationTocar".play("Sumindo")
	
func loadData() -> void:
	var dataFile = File.new()
	if not dataFile.file_exists(saveGameFileName):
		return 
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
	resposta = saveData.values()
	if anim_name == "Entrando":
		var nn = saveData.get("lv")
		if resposta.front() == "A":
			#print(nn)
			match nn:
				0.0:
					$"Ovos/animacaoDiro".play("AparecendoOvoDia")
				_:
					anima()
		elif resposta.front() == "B":
			#$"Ovos/OVO-VERDE".visible = not $"Ovos/OVO-VERDE".visible
			match nn:
				0.0:
					$"Ovos/animacaoDiro".play("AparecendoOvoNoite")
				_:
					anima()
			
	elif anim_name == "Saindo":
		pass
		
func anima():
	$"Tocar/AnimationTocar".play("Sumindo")
	$"Estatus/AnimationEstatusAparecendo".play("aparecendo")
	if resposta.front() == "A":
		$"Ovos/Primeira-Forma".visible = not $"Ovos/Primeira-Forma".visible
		$"Ovos/animacaoDiro".play("PrimeiraFormaDiaIdle")
	elif resposta.front() == "B":
		$"Ovos/Primeira-Forma-Noite".visible = not $"Ovos/Primeira-Forma-Noite".visible
		$"Ovos/animacaoDiro".play("PrimeiraFormaDiaIdleNOITE")

func _on_animacaoDiro_animation_finished(anim_name):
	match anim_name:
		"AparecendoOvoDia":
			$"Ovos/animacaoDiro".play("MexendoOvoDia")
		"AparecendoOvoNoite":
			$"Ovos/animacaoDiro".play("MexendoOvoNoite")
		"QuebrandoOvoDia":
			anima()
		"QuebrandoOvoNoite":
			anima()

func _on_Save_pressed():
	print("Indo Salvar...")
	$Estatus.Salvar()

func _on_Tocar_pressed():
	AB +=1
	print("infelizmente foi")
	if AB == 5:
		$Tocar.visible = not $Tocar.visible
		if resposta.front() == "A":
			$"Ovos/OVO-BLUE".visible = not $"Ovos/OVO-BLUE".visible
			$"Ovos/animacaoDiro".play("QuebrandoOvoDia")
		elif resposta.front() == "B":
			$"Ovos/OVO-VERDE".visible = not $"Ovos/OVO-VERDE".visible
			$"Ovos/animacaoDiro".play("QuebrandoOvoNoite")

func _on_AnimationEstatusAparecendo_animation_finished(anim_name):
	$Estatus.IniciarTudo()
	#$Estatus.setNivel(saveData)
	#$Estatus.AbrirOvo()
