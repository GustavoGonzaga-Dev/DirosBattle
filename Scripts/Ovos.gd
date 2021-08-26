extends Node

func _ready():
	pass 

func InicioDeTudo():
	pass
	
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
