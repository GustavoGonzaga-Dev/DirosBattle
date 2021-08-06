extends Node

var Sede = 0
var Triste = 0

func Tempo():
	Animar()
	$TimerSede.start()

func ToCuSede():
	if Sede >= 6:
		Triste +=1
	Sede +=1
	print("To com sede")
	$TimerSede.start()
	Animar()

func Comer():
	if Sede < 0:
		print("estou cheio")
		Triste +=1
		Sede = 0
	else:
		Sede -=1

func Animar():
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
			print("<-------MORREU------->")

func _on_TimerSede_timeout():
	$TimerSede.stop()
	ToCuSede()
