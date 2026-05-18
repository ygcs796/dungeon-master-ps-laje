extends Node
class_name inimigo

var vida: int
var dano: int
signal morreu

# tô usando esse construtor para 
# passar parâmetros para a classe
func _init(p_vida: int = 10, p_dano: int = 10) -> void:
	vida = p_vida
	dano = p_dano
	pass
	
func tomar_dano(dano_tomado: int):
	vida -= dano_tomado
	if vida <= 0:
		emit 
	pass

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
