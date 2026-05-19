extends inimigo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# essas duas variáveis vieram da classe "inimigo"
	vida = 10
	dano_ataque = 1
	pass # Replace with function body.

# ataque padrão
func soco(vida_npc: int) -> int:
	vida_npc -= dano_ataque
	return vida_npc
	
# ataque crítico
func mordida(vida_npc: int) -> int:
	vida_npc -= dano_ataque * 2
	return vida_npc
	
# o zumbi não vai ter defesa

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
