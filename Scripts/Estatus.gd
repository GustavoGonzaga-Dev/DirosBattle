extends Node2D

var Fome = 0
var Sede = 0
var Triste = 0
var lv = 0
var lvTxt = "LV. %d"

onready var lblLv = $"LabelLV"


func IniciarTudo():
	Tempo()
	atualizarAnimacao()
	
func Tempo():
	$TimerFome.start()
	$TimerSede.start()

func nextLvl():
	lblLv.text = lvTxt % lv


func atualizarAnimacao():
	nextLvl()
	AnimarEmocao()
	AnimarFome()
	AnimarSede()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		Comer()
		print("seu nivel de fome é: ", Fome)
		atualizarAnimacao()
	if Input.is_action_just_pressed("ui_left"):
		Beber()
		print("seu nivel de sede é: ", Sede)
		atualizarAnimacao()
	if Input.is_action_just_pressed("ui_down"):
		print("OBRIGADO POR CONVERSAR COMIGO.")
		Triste -=1
		atualizarAnimacao()
	if Input.is_action_just_pressed("ui_lv"):
		lv +=1
		atualizarAnimacao()
	
func DiminuirFelicidade():
	Triste +=1
	print("Isso me deixa mais triste...")
	atualizarAnimacao()

func Comer():
	if Fome < 0:
		print("não quero mais comida")
		Triste +=1
		Fome = 0
	else:
		Fome -=1

func Beber():
	if Sede < 0:
		print("Não quero mais agua")
		Triste +=1
		Sede = 0
	else:
		Sede -=1

func ToCuSede():
	if Sede >= 4:
		DiminuirFelicidade()
	Sede +=1
	print("To com sede")
	$TimerSede.start()
	atualizarAnimacao()

func ToCuFome():
	if Fome >= 4:
		DiminuirFelicidade()
	Fome +=1
	print("To com fome")
	$TimerFome.start()
	atualizarAnimacao()

func _on_TimerSede_timeout():
	$TimerSede.stop()
	ToCuSede()

func _on_TimerFome_timeout():
	$TimerFome.stop()
	ToCuFome()

func AnimarSede():
	match Sede:
		0:
			$"Agua-status/AnimationSede".play("1")
		1:
			$"Agua-status/AnimationSede".play("2")
		2:
			$"Agua-status/AnimationSede".play("3")
		3:
			$"Agua-status/AnimationSede".play("4")
		4:
			$"Agua-status/AnimationSede".play("5")
		5:
			$"Agua-status/AnimationSede".play("6")
		6:
			$"Agua-status/AnimationSede".play("7")
		7:
			$"Agua-status/AnimationSede".play("8")
		8:
			$"Agua-status/AnimationSede".stop()
			$TimerSede.stop()
			$"Emocoes-Diro/AnimationPlayer".play("Morri")
			print("<-------MORREU------->")

func AnimarFome():
	match Fome:
		0:
			$"Comida-status/AnimationFome".play("1")
		1:
			$"Comida-status/AnimationFome".play("2")
		2:
			$"Comida-status/AnimationFome".play("3")
		3:
			$"Comida-status/AnimationFome".play("4")
		4:
			$"Comida-status/AnimationFome".play("5")
		5:
			$"Comida-status/AnimationFome".play("6")
		6:
			$"Comida-status/AnimationFome".play("7")
		7:
			$"Comida-status/AnimationFome".play("8")
		8:
			$"Comida-status/AnimationFome".stop()
			$TimerFome.stop()
			$"Emocoes-Diro/AnimationPlayer".play("Morri")
			print("<-------MORREU------->")

func AnimarEmocao():
	print("seu nivel de tristeza é:", Triste)
	match Triste:
		0:
			$"Emocoes-Diro/AnimationPlayer".play("Feliz")
			print("To muito Feliz, muito obrigado")
		1:
			$"Emocoes-Diro/AnimationPlayer".play("Neutro")
			print("Acho que vai melhorar...")
		2:
			$"Emocoes-Diro/AnimationPlayer".play("Bolado")
			print("Você bem que podia fazer alguma coisa pra me ajudar, né papai?")
		3:
			$"Emocoes-Diro/AnimationPlayer".play("PUTO")
			print("É TUDO CULPA SUA, NIGUEM TE SUPORTA SEU LIXO!!!")
		4:
			$"Emocoes-Diro/AnimationPlayer".play("Tite")
			print("é tudo culpa minha, desculpa por ter nascido, logo irei resolver tudo... papai")
		5:
			$"Emocoes-Diro/AnimationPlayer".play("Morri")
			print("SEU DIRO SE MATOU POR CAUSA DA SUA INCOMPETENCIA...")
			print("<-------MORREU------->")
			$TimerFome.stop()
			$TimerSede.stop()
