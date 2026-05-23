extends VBoxContainer

signal algum_botao_apertado(valor_botao: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ataque_especial_button_down() -> void:
	algum_botao_apertado.emit(2)
	pass # Replace with function body.


func _on_escudo_button_down() -> void:
	algum_botao_apertado.emit(3)
	pass # Replace with function body.


func _on_ataque_simples_button_down() -> void:
	algum_botao_apertado.emit(1)
	pass # Replace with function body.
