extends Node2D

var saveData = {
	
}

var resposta
var saveGameFileName: String = "res://ArquivosBanco/informacoesDiro.txt"

func _ready():
	self.loadData()
	
func loadData() -> void:
	var dataFile = File.new()
	if not dataFile.file_exists(saveGameFileName):
		return 
	dataFile.open(saveGameFileName, File.READ)
	while dataFile.get_position() < dataFile.get_len():
		var nodeData = parse_json(dataFile.get_line())
		saveData.ovoEscolhido = nodeData["ovoEscolhido"]
	dataFile.close()

func _on_AnimacaoTransicao_animation_finished(anim_name):
	resposta = saveData.values()
	if anim_name == "Entrando":
		$Estatus/AnimationPlayer.play("aparecendo")
		if resposta.front() == "A":
			#$"Ovos/OVO-BLUE".visible = not $"Ovos/OVO-BLUE".visible
			$"Ovos/animacaoDiro".play("AparecendoOvoDia")
		elif resposta.front() == "B":
			#$"Ovos/OVO-VERDE".visible = not $"Ovos/OVO-VERDE".visible
			$"Ovos/animacaoDiro".play("AparecendoOvoNoite")
	elif anim_name == "Saindo":
		pass

func _on_AnimationPlayer_animation_finished(anim_name):
	$Estatus.IniciarTudo()

func _on_animacaoDiro_animation_finished(anim_name):
	match anim_name:
		"AparecendoOvoDia":
			$"Ovos/animacaoDiro".play("MexendoOvoDia")
		"AparecendoOvoNoite":
			$"Ovos/animacaoDiro".play("MexendoOvoNoite")
