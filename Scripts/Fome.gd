extends Node

var Fome = 0
var Triste = 0

func Tempo():
	Animar()
	$TimerFome.start()

func ToCuFome():
	if Fome >= 6:
		Triste +=1
	Fome +=1
	print("To com fome")
	$TimerFome.start()
	Animar()

func Comer():
	if Fome < 0:
		print("estou cheio")
		Triste +=1
		Fome = 0
	else:
		Fome -=1

func Animar():
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
			print("<-------MORREU------->")

func _on_TimerFome_timeout():
	$TimerFome.stop()
	ToCuFome()
