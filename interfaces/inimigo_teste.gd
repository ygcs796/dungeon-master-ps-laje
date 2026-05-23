extends Node2D
class_name Inimigo

# Atributos básicos do inimigo
@export var nome: String = "Globin"
@export var vida: int = 100
@export var dano_base: int = 15

# Função para o inimigo CAUSAR dano em alguém
func dar_dano() -> int:
	print(nome, " preparou o ataque!")
	return dano_base

# Função para o inimigo RECEBER dano dos heróis
func receber_dano(quantidade: int) -> void:
	vida -= quantidade
	print(nome, " recebeu ", quantidade, " de dano. Vida restante: ", vida)
	
	# Se a vida zerar ou negativar, ele morre
	if vida <= 0:
		print(nome, " foi derrotado!")
		queue_free() # Apaga o inimigo da cena
