extends inimigo

signal nao_sofreu_ataque

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vida = 6
	dano_ataque = 2
	pass # Replace with function body.

# ataque básico
func tiro_1_flecha(vida_npc: int) -> int:
	vida_npc -= dano_ataque
	return vida_npc

# ataque crítico
func tiro_varias_flechas(vida_npc: int) -> int:
	vida_npc -= dano_ataque * 2
	return vida_npc

# defesa - vou considerar o esqueleto mais inteligente que o zumbi
func desviar() -> void:
	# emitiindo o sinal para que outro arquivo leia
	nao_sofreu_ataque.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
