extends Node
class_name inimigo

@export var vida: int
@export var dano_ataque: int
signal inimigo_morreu

func tomar_dano(dano_tomado: int):
	vida -= dano_tomado
	if vida <= 0:
		inimigo_morreu.emit()
