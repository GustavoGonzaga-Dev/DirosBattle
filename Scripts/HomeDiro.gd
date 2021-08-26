extends Node2D

var saveData = {
	
}

var penis
var resposta
var AB = 0
var saveGameFileName: String = "res://ArquivosBanco/informacoesDiro.txt"

func _ready():
	self.loadData()
	if saveData.get("lv") !=0:
		$Tocar.visible = not $Tocar.visible
	
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
		print("chegou ate aqui")
		var nn = saveData.get("lv")
		var esc = saveData.get("ovoEscolhido")
		if esc == "A":
			match nn:
				0.0:
					$Ovos.AparecendoOvoDia()
				_:
					anima()
		elif esc == "B":
			print("chegou ate aqui2")
			match nn:
				0.0:
					$Ovos.AparecendoOvoNoite()
				_:
					print("chegou ate aqui3")
					anima()
	elif anim_name == "Saindo":
		pass
		
func anima():
	$"Estatus/AnimationEstatusAparecendo".play("aparecendo")
	if resposta.front() == "A":
		$Ovos.AparecendoPrimeiraFormaDia()
	elif resposta.front() == "B":
		$Ovos.AparecendoPrimeiraFormaNoite()

func _on_Save_pressed():
	print("Indo Salvar...")
	$Estatus.Salvar()

func _on_Tocar_pressed():
	AB +=1
	print("infelizmente foi")
	if AB == 5:
		$Tocar.visible = not $Tocar.visible
		$"Estatus/AnimationEstatusAparecendo".play("aparecendo")
		penis = true
		if resposta.front() == "A":
			$Ovos.QuebrandoOvoDia()
		elif resposta.front() == "B":
			$Ovos.QuebrandoOvoNoite()

func _on_AnimationEstatusAparecendo_animation_finished(anim_name):
	if penis == true:
		$Estatus.IniciarTudo()
		saveData.lv = 1
		$Estatus.setNivel(saveData)
		$Estatus.Salvar()
	else:
		$Estatus.IniciarTudo()
