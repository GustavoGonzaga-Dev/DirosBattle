extends Node2D

func _on_AnimacaoTransicao_animation_finished(anim_name):
	if anim_name == "Entrando":
		$"godot/godot_logo-Sheet/AnimationPlayer".play("surgirGodot")
	elif anim_name == "saindo":
		get_tree().change_scene("res://Cenas/Menu.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "surgirGodot":
		$"godot/godot_logo-Sheet/AnimationPlayer".play("godot")
	elif anim_name == "godot":
		$"godot/godot_logo-Sheet/AnimationPlayer".play("sumirGodot")
	elif anim_name == "sumirGodot":
		$fantasy/AnimatedSpriteFantasy.play("fantasy")
		


func _on_AnimatedSprite_animation_finished():
		$CanvasLayer/AnimatedSprite.play("paradoDk")
		$"transição/ColorRect/AnimacaoTransicao".play("saindo")


func _on_AnimatedSpriteFantasy_animation_finished():
	$fantasy/AnimatedSpriteFantasy.play("parado")
	$CanvasLayer/AnimatedSprite.play("dk")
