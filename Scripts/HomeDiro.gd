extends Node2D

var saveData = {
	
}

var penis
var resposta
var AB = 0
var saveGameFileName: String = "res://ArquivosBanco/informacoesDiro.txt"

func _ready():
	self.loadData()
	#$Ovos.Evoluir(saveData.get("lv"), saveData.get("ovoEscolhido"))
	if saveData.get("lv") !=0:
		$Tocar.visible = not $Tocar.visible
		#$Ovos.Evoluir(saveData.get("lv"), saveData.get("ovoEscolhido"))
	$Timer.start()
	
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
		$Ovos.Evoluir(saveData.get("lv"), saveData.get("ovoEscolhido"))
		pass
		#print("chegou ate aqui")
		#var nn = saveData.get("lv")
		#var esc = saveData.get("ovoEscolhido")
		#if esc == "A":
			#match nn:
				#0.0:
					#$Ovos.AparecendoOvoDia()
				#_:
					#anima()
		#elif esc == "B":
			#print("chegou ate aqui2")
			#match nn:
				#0.0:
					#$Ovos.AparecendoOvoNoite()
				#_:
					#print("chegou ate aqui3")
					#anima()
	elif anim_name == "Saindo":
		pass
		
#func anima():
	#$"Ovos/Estatus/AnimationEstatusAparecendo".play("aparecendo")
	#$"Estatus/AnimationEstatusAparecendo".play("aparecendo")
	#if resposta.front() == "A":
		#$Ovos.AparecendoPrimeiraFormaDia()
	#elif resposta.front() == "B":
		#$Ovos.AparecendoPrimeiraFormaNoite()

func _on_Save_pressed():
	print("Indo Salvar...")
	$Ovos/Estatus.Salvar()

func _on_Tocar_pressed():
	AB +=1
	print("infelizmente foi")
	if AB == 5:
		$Tocar.visible = not $Tocar.visible
		$"Ovos/Estatus/AnimationEstatusAparecendo".play("aparecendo")
		#$"Estatus/AnimationEstatusAparecendo".play("aparecendo")
		penis = true
		$Ovos.setPenis(penis)
		if resposta.front() == "A":
			$Ovos.QuebrandoOvoDia()
		elif resposta.front() == "B":
			$Ovos.QuebrandoOvoNoite()

#func _on_AnimationEstatusAparecendo_animation_finished(anim_name):
	#if penis == true:
		#$Ovos/Estatus.IniciarTudo()
		#$Estatus.IniciarTudo()
		#saveData.lv = 1
		#$Ovos/Estatus.setNivel(saveData)
		#$Ovos/Estatus.Salvar()
	#else:
		#$Ovos/Estatus.IniciarTudo()

func AtualizarComBanco():
	loadData()

func SalvarAutomatico():
	$Ovos/Estatus.Salvar()

func _on_Mapa_pressed():
	get_tree().change_scene("res://Cenas/Mapa.tscn")


func _on_Timer_timeout():
	SalvarAutomatico()
	AtualizarComBanco()
	if saveData.get("lv") == 5:
		$Mapa.visible = not $Mapa.visible
