extends Node2D
class_name Inimigo

# Atributos básicos do inimigo
@export var nome: String = "Reston"
@export var vida: int = 50
@export var dano_base: int = 10
@export var dano_ataque_especial: int = 20
@export var movimentos_certos = 0
@export var pode_usar_ataque_especial = false
@export var usando_escudo = false # o escudo vai diminuir metade do dano
var quer_usar_ataque_especial

# Função para o inimigo CAUSAR dano em alguém
func dar_dano(quer_usar_ataque_especial:bool) -> int:
	if quer_usar_ataque_especial:
		return dano_ataque_especial 
	return dano_base

# Função para o inimigo RECEBER dano dos heróis
func receber_dano(quantidade: int) -> void:
	vida -= quantidade
