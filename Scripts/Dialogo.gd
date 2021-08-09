extends Node2D

const velocidadeLeitura = 0.15
onready var textboxContainer = $TextBox/TextBoxContainer
onready var startS = $TextBox/TextBoxContainer/MarginContainer/HBoxContainer/Start
onready var endS = $TextBox/TextBoxContainer/MarginContainer/HBoxContainer/End
onready var lblText = $TextBox/TextBoxContainer/MarginContainer/HBoxContainer/Label
onready var Ovo_Verde_Animation = $"Ovos/OVO-VERDE/AnimationOvoVerde"
onready var Ovo_Verde = $"Ovos/OVO-VERDE"
onready var Ovo_Azul_Animation = $"Ovos/OVO-BLUE/AnimationOvoAzul"
onready var Ovo_Azul = $"Ovos/OVO-BLUE"
onready var textboxTween = $TextBox/Tween
onready var textboxBtn = $TextBox/btn
onready var textboxProximo = $TextBox/Proximo
onready var textboxAnimationProximo = $TextBox/Proximo/AnimeProximo
onready var textboxAnimationPlayer = $TextBox/TextBoxContainer/AnimationPlayerTxtBox
onready var colorReacAnimacaoTransicao = $"transição/ColorRect/AnimacaoTransicao"
onready var animationPlayerPlaneta = $planeta/planeta1/AnimationPlayerPlaneta
onready var animationPlayerBotoes = $TextBox/Botoes/AnimationPlayerBotoes
onready var TouchDia = $TextBox/Botoes/ButtonDia
onready var TouchNoite = $TextBox/Botoes/ButtonNoite
onready var Rosto_Movendo = $"Rosto-do-Criador/Bigode/AnimationPlayer"


enum State{
	READY,
	READING,
	FINISHED
}

var stadoAtual = State.READY
var textQueue = []
var bt = 1
var ovo

func _ready():
	hide_TextBox()
	
	FtextQueue("Ola")
	FtextQueue("EU, O TODO PODEROSO E MAGNIF...")
	FtextQueue("COF..  COF..")
	FtextQueue("TU! Fostes o escolhido,")
	FtextQueue("Para fazer parte deste novo mundo,")
	FtextQueue("...")
	FtextQueue("Mas antes eu preciso saber de algo...")
	FtextQueue("O que você Prefere?")
	FtextQueue("Muito bom, aqui está o seu OVODIRO...")
	FtextQueue("CUIDE MUITO BEM DELE.")

func _process(delta):
	match stadoAtual:
		State.READY:
			if !textQueue.empty():
				bt = 1
				Display_text()
		State.READING:
			if bt == 2:
				lblText.percent_visible = 1.0
				textboxTween.stop_all()
				endS.text = ">"
				changeState(State.FINISHED)
		State.FINISHED:
			if bt == 3:
				changeState(State.READY)
				hide_TextBox()

func FtextQueue(nextText):
	textQueue.push_back(nextText)

func hide_TextBox():
	startS.text = ""
	endS.text = ""
	lblText.text = ""
	textboxContainer.hide()

func show_TextBox():
	startS.text = "*"
	textboxContainer.show()

func Display_text():
	var nextText = textQueue.pop_front()
	if nextText == "O que você Prefere?":
		textboxBtn.visible = not textboxBtn.visible
		textboxProximo.visible = not textboxProximo.visible
		textboxAnimationPlayer.play("subindo")
	if nextText == "Muito bom, aqui está o seu OVODIRO...":
		textboxProximo.visible = not textboxProximo.visible
		textboxBtn.visible = not textboxBtn.visible
	if nextText == "CUIDE MUITO BEM DELE.":
		textboxAnimationProximo.play("Sumindo")
		if ovo == "A":
			Ovo_Azul_Animation.play("Sumindo")
		elif ovo == "B":
			Ovo_Verde_Animation.play("Sumindo")
		colorReacAnimacaoTransicao.play("Saindo")
	lblText.text = nextText
	lblText.percent_visible = 0.0
	changeState(State.READING)
	show_TextBox()
	textboxTween.interpolate_property(lblText, "percent_visible", 0.0, 1.0, len(nextText) * velocidadeLeitura, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	textboxTween.start()

func _on_Tween_tween_all_completed():
	endS.text = ">"
	_on_btn_pressed()
	changeState(State.FINISHED)

func changeState(nextState):
	stadoAtual = nextState

func _on_AnimacaoTransicao_animation_finished(anim_name):
	if anim_name == "Entrando":
		Rosto_Movendo.play("Rosto_movendo")
		animationPlayerPlaneta.play("RodaRodaJequiti")

	elif anim_name == "Saindo":
		get_tree().change_scene("res://Cenas/HomeDiro.tscn")

func _on_AnimationPlayerTxtBox_animation_finished(anim_name):
	TouchDia.visible = not TouchDia.visible
	TouchNoite.visible = not TouchNoite.visible
	animationPlayerBotoes.play("surgindoBotoes")
	Rosto_Movendo.play("Apaga")


func _on_btn_pressed():
	bt += 1

func _on_AnimationOvoAzul_animation_finished(anim_name):
	if anim_name == "Aparecendo":
		Ovo_Azul_Animation.play("mexendo")


func _on_AnimationOvoRosa_animation_finished(anim_name):
	if anim_name == "Aparecendo":
		Ovo_Verde_Animation.play("mexendo")

func _on_ButtonDia_pressed():
	ovo = "A"
	TouchDia.visible = not TouchDia.visible
	TouchNoite.visible = not TouchNoite.visible
	_on_btn_pressed()
	_on_btn_pressed()
	changeState(State.FINISHED)
	Ovo_Azul.visible = not Ovo_Azul.visible
	Ovo_Azul_Animation.play("Aparecendo")

func _on_ButtonNoite_pressed():
	ovo = "B"
	TouchDia.visible = not TouchDia.visible
	TouchNoite.visible = not TouchNoite.visible
	_on_btn_pressed()
	_on_btn_pressed()
	changeState(State.FINISHED)
	Ovo_Verde.visible = not Ovo_Verde.visible
	Ovo_Verde_Animation.play("Aparecendo")
