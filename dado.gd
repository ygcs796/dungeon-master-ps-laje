extends Node2D

@onready var texto_dado = $dado_texto

signal numero_dado(valor_dado: int)

func _process(delta: float) -> void:
	pass

func rolar_dado() -> void:
	$Button.disabled = true
	var numero_escolhido
	for i in range(2): # quantidade de segundos
		for j in range(4): # números por segundo
			numero_escolhido = randi_range(1, 20)
			if numero_escolhido < 10:
				texto_dado.text = "0" + str(numero_escolhido)
			else:
				texto_dado.text = str(numero_escolhido)
			await get_tree().create_timer(0.25).timeout
	numero_dado.emit(numero_escolhido)

func _on_button_button_down() -> void:
	await rolar_dado()
