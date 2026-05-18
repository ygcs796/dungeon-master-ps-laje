extends Node2D

@onready var vida = $texto_vida
@onready var mana = $texto_mana 

var vida_maxima = 10
var nivel_vida = vida_maxima
var mana_maxima = 10
var nivel_mana = mana_maxima

func perdeu_vida(quantidade):
	nivel_vida -= quantidade
	vida.text = "Vida: " + str(nivel_vida)
	
func perdeu_mana(quantidade):
	nivel_mana -= quantidade
	mana.text = "Mana: " + str(nivel_mana)
	
func ganhou_vida(quantidade):
	nivel_vida += quantidade
	vida.text = "Vida: " + str(nivel_vida)
	
func ganhou_mana(quantidade):
	nivel_mana += quantidade
	mana.text = "Mana: " + str(nivel_mana)
