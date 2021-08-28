extends Node

func _ready():
	pass 

func InicioDeTudo():
	pass
	
var pen = false
var nv

var saveData = {
	
}

func setPenis(penis):
	pen = penis

func Evoluir(lv, ovo):
	match ovo:
		"A":
			if lv == 0:
				AparecendoOvoDia()
			elif lv >=1 and lv <=4:
				AparecendoPrimeiraFormaDia()
			elif lv >= 5:
				AparecendoSegundaFormaDia()
		"B":
			if lv == 0:
				AparecendoOvoNoite()
			elif lv >=1 and lv <=4:
				AparecendoPrimeiraFormaDia()
			elif lv >= 5:
				AparecendoSegundaFormaNoite()
	$"Estatus/AnimationEstatusAparecendo".play("aparecendo")
func AparecendoSegundaFormaDia():
	$"Segunda-Forma-Azul".visible = not $"Segunda-Forma-Azul".visible
	$"Segunda-Forma-Azul/animacaoEvDia".play("Idle")

func AparecendoSegundaFormaNoite():
	$"Segunda-Forma-Noite".visible = not $"Segunda-Forma-Noite".visible
	$"Segunda-Forma-Noite/animacaoEvNoite".play("Idle")

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
		"PrimeiraFormaDiaIdle":
			nv = $Estatus.getNivel()
			if nv == 5:
				$"Primeira-Forma".visible = not $"Primeira-Forma".visible
				AparecendoSegundaFormaDia()
			else:
				$"animacaoDiro".play("PrimeiraFormaDiaIdle")
		"PrimeiraFormaDiaIdleNOITE":
			nv = $Estatus.getNivel()
			if nv == 5:
				$"Primeira-Forma-Noite".visible = not $"Primeira-Forma-Noite".visible
				AparecendoSegundaFormaNoite()
			else:
				$"animacaoDiro".play("PrimeiraFormaDiaIdleNOITE")
		#"Segunda-Forma-Azul":
			#pass
		#"Segunda-Forma-Noite":
			#pass


func _on_AnimationEstatusAparecendo_animation_finished(anim_name):
	if pen == true:
		$Estatus.IniciarTudo()
		#$Estatus.IniciarTudo()
		saveData.lv = 1
		$Estatus.setNivel(saveData)
		$Estatus.Salvar()
	else:
		$Estatus.IniciarTudo()
