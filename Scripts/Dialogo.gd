extends Node2D

const velocidadeLeitura = 0.15
onready var textboxContainer = $TextBox/TextBoxContainer
onready var startS = $TextBox/TextBoxContainer/MarginContainer/HBoxContainer/Start
onready var endS = $TextBox/TextBoxContainer/MarginContainer/HBoxContainer/End
onready var lblText = $TextBox/TextBoxContainer/MarginContainer/HBoxContainer/Label

enum State{
	READY,
	READING,
	FINISHED
}

var stadoAtual = State.READY
var textQueue = []

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
	FtextQueue("CUIDE BEM DELE.")

func _process(delta):
	match stadoAtual:
		State.READY:
			if !textQueue.empty():
				Display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				lblText.percent_visible = 1.0
				$TextBox/Tween.stop_all()
				endS.text = ">"
				changeState(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
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
		$TextBox/TextBoxContainer/AnimationPlayerTxtBox.play("subindo")
	if nextText == "CUIDE BEM DELE.":
		$"transição/ColorRect/AnimacaoTransicao".play("Saindo")
	lblText.text = nextText
	lblText.percent_visible = 0.0
	changeState(State.READING)
	show_TextBox()
	$TextBox/Tween.interpolate_property(lblText, "percent_visible", 0.0, 1.0, len(nextText) * velocidadeLeitura, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$TextBox/Tween.start()

func _on_Tween_tween_all_completed():
	endS.text = ">"
	changeState(State.FINISHED)

func changeState(nextState):
	stadoAtual = nextState
	
func _on_AnimacaoTransicao_animation_finished(anim_name):
	if anim_name == "Entrando":
		$planeta/planeta1/AnimationPlayerPlaneta.play("RodaRodaJequiti")
	elif anim_name == "Saindo":
		get_tree().change_scene("res://Cenas/HomeDiro.tscn")

func _on_AnimationPlayerTxtBox_animation_finished(anim_name):
	$Botoes/AnimationPlayerBotoes.play("surgindoBotoes")


func _on_TouchDia_pressed():
	$Botoes/TouchDia.visible = not $Botoes/TouchDia.visible
	$Botoes/TouchNoite.visible = not $Botoes/TouchNoite.visible
	changeState(State.FINISHED)
	$"Ovos/OVO-BLUE".visible = not $"Ovos/OVO-BLUE".visible
	$"Ovos/OVO-BLUE/AnimationOvoAzul".play("mexendo")

func _on_TouchNoite_pressed():
	$Botoes/TouchDia.visible = not $Botoes/TouchDia.visible
	$Botoes/TouchNoite.visible = not $Botoes/TouchNoite.visible
	changeState(State.FINISHED)
	$"Ovos/OVO-ROSA".visible = not $"Ovos/OVO-ROSA".visible
	$"Ovos/OVO-ROSA/AnimationOvoRosa".play("mexendo")
