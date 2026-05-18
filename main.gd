extends Node2D

@onready var npc = $npc

# só para usar no cálculo
const fator_ganho_perda = 0.1

func _on_dado_numero_dado(numero_dado: int):
	var perda; var ganho
	if numero_dado <= 10: # vai perder vida
		perda = numero_dado * fator_ganho_perda
		# escolhendo de maneira aleatória
		var escolha = randi_range(1,2)
		match escolha: # um comparador
			1: # perda de vida
				npc.perdeu_vida(perda)
			2: # perda de mana
				npc.perdeu_vida(perda)
	else:
		ganho = numero_dado * fator_ganho_perda
		var escolha = randi_range(1,2)
		match escolha: # um comparador
			1: # ganho de vida
				npc.ganhou_vida(ganho)
			2: # ganho de mana
				npc.ganhou_mana(ganho)
	
