extends Node2D

var saveData = {
	
}

var resposta

var nodeData
# path string
var saveGameFileName: String = "res://ArquivosBanco/informacoesDiro.txt"

func _ready():
	self.loadData()
	
func loadData() -> void:
	var dataFile = File.new()
	
	# make sure our file exists on users system
	if not dataFile.file_exists(saveGameFileName):
		return # File does not exist
	
	# allow reading only for file
	dataFile.open(saveGameFileName, File.READ)
	# loop through file line by line
	while dataFile.get_position() < dataFile.get_len():
		#resposta = dataFile.get_line()
		nodeData = parse_json(dataFile.get_line())
		
		# grab save data
		saveData.ovoEscolhido = nodeData["ovoEscolhido"]

		#print(resposta)
		#saveData.location = nodeData["location"]
	dataFile.close()

func _on_AnimacaoTransicao_animation_finished(anim_name):
	resposta = saveData.values()
	#print(resposta)
	if anim_name == "Entrando":
		$Estatus/AnimationPlayer.play("aparecendo")
		if resposta.front() == "A":
			$"Ovos/OVO-BLUE/AnimationOvoAzul".play("Aparecendo")
		elif resposta.front() == "B":
			$"Ovos/OVO-VERDE/AnimationOvoVerde".play("Aparecendo")
	elif anim_name == "Saindo":
		pass

func _on_AnimationPlayer_animation_finished(anim_name):
	$Estatus.IniciarTudo()

func _on_AnimationOvoAzul_animation_finished(anim_name):
	$"Ovos/OVO-BLUE/AnimationOvoAzul".play("mexendo")

func _on_AnimationOvoVerde_animation_finished(anim_name):
	$"Ovos/OVO-VERDE/AnimationOvoVerde".play("mexendo")
