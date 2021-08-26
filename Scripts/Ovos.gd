extends Node

func _ready():
	pass 

func InicioDeTudo():
	pass
	
var pen = false

var saveData = {
	
}

func setPenis(penis):
	pen = penis

func Evoluir(lv, ovo):
	match ovo:
		"A":
			if lv >= 5:
				$"Segunda-Forma-Azul".visible = not $"Segunda-Forma-Azul".visible
				$"Segunda-Forma-Azul/animacaoEvDia".play("Idle")
		"B":
			if lv >= 5:
				$"Segunda-Forma-Noite".visible = not $"Segunda-Forma-Noite".visible
		

func AparecendoOvoDia():
	$"animacaoDiro".play("AparecendoOvoDia")

func AparecendoOvoNoite():
	$"animacaoDiro".play("AparecendoOvoNoite")

func QuebrandoOvoDia():
	$"OVO-BLUE".visible = not $"OVO-BLUE".visible
	$"animacaoDiro".play("QuebrandoOvoDia")

func QuebrandoOvoNoite():
	$"OVO-VERDE".visible = not $"OVO-VERDE".visible
	$"animacaoDiro".play("QuebrandoOvoNoite")

func AparecendoPrimeiraFormaDia():
	$"Primeira-Forma".visible = not $"Primeira-Forma".visible
	$"animacaoDiro".play("PrimeiraFormaDiaIdle")

func AparecendoPrimeiraFormaNoite():
	$"Primeira-Forma-Noite".visible = not $"Primeira-Forma-Noite".visible
	$"animacaoDiro".play("PrimeiraFormaDiaIdleNOITE")

func _on_animacaoDiro_animation_finished(anim_name):
	match anim_name:
		"AparecendoOvoDia":
			$"animacaoDiro".play("MexendoOvoDia")
		"AparecendoOvoNoite":
			$"animacaoDiro".play("MexendoOvoNoite")
		"QuebrandoOvoDia":
			AparecendoPrimeiraFormaDia()
			#anima()
		"QuebrandoOvoNoite":
			AparecendoPrimeiraFormaNoite()
			#anima()


func _on_AnimationEstatusAparecendo_animation_finished(anim_name):
	if pen == true:
		$Estatus.IniciarTudo()
		#$Estatus.IniciarTudo()
		saveData.lv = 1
		$Estatus.setNivel(saveData)
		$Estatus.Salvar()
	else:
		$Estatus.IniciarTudo()
