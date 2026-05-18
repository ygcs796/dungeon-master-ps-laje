extends Node2D

@onready var texto_dado = $dado_texto

signal numero_dado(valor_dado: int)

func _process(delta: float) -> void:
	pass
	
func _on_button_button_down() -> void:
	var numero_escolhido
	for i in range(6): # quantidade de segundos
		for j in range(4): # números por segundo
			numero_escolhido = randi_range(1, 20)
			texto_dado.text = str(numero_escolhido)
			await get_tree().create_timer(0.25).timeout
	numero_dado.emit(numero_escolhido)
