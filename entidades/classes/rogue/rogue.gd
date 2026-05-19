extends NPC

const ESPECIAL_ADAGAS_ENVENENADAS = 1
const ESPECIAL_INVISIBILIDADE = 2
const ESPECIAL_ARCO_E_FLECHA = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func atacar():
	
	var quantidade_dano = 0
	var rolagem_dados = randi_range(1, 6) # aqui pode ser um metodo criado da classe de dado
	var bonificador = (forca * 0.3 + destreza * 0.6 + magia * 0.2)
	
	quantidade_dano = rolagem_dados * bonificador
	
	return quantidade_dano

func ataque_especial(escolha_ataque: int):
	
	if(escolha_ataque == ESPECIAL_ADAGAS_ENVENENADAS):
		pass
	elif(escolha_ataque == ESPECIAL_INVISIBILIDADE):
		pass
	elif(escolha_ataque == ESPECIAL_ARCO_E_FLECHA):
		pass
