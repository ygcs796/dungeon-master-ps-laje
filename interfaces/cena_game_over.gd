extends Control

func _on_texture_button_button_down() -> void:
	# reiniciando as variáveis
	InimigoTeste.vida = 50
	InimigoTeste.movimentos_certos = 0
	InimigoTeste.pode_usar_ataque_especial = false
	InimigoTeste.usando_escudo = false # o escudo vai diminuir metade do dano
	
	$NPC.vida = 25
	
	Master.contador_silencio = 0
	Master.criatividade = 0
	Master.narrativa = 0
	Master.nome = ""
	Master.persuasao = 0
	Master.pontos_disponiveis = 3
	Master.sorte = 0
	
	get_tree().change_scene_to_file("res://interfaces/menu_principal.tscn")
