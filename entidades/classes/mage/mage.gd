extends NPC

const ESPECIAL_DARDOS_MAGICOS = 1
const ESPECIAL_ESCUDO_MAGICO = 2
const ESPECIAL_BOLA_DE_FOGO = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func atacar():
	
	var quantidade_dano = 0
	var rolagem_dados = randi_range(1, 6) # aqui pode ser um metodo criado da classe de dado
	var bonificador = (forca * 0.1 + destreza * 0.2 + magia * 0.7)
	
	quantidade_dano = rolagem_dados * bonificador
	
	return quantidade_dano

func ataque_especial(escolha_ataque: int):
	
	if(escolha_ataque == ESPECIAL_DARDOS_MAGICOS):
		pass
	elif(escolha_ataque == ESPECIAL_ESCUDO_MAGICO):
		pass
	elif(escolha_ataque == ESPECIAL_BOLA_DE_FOGO):
		pass
