extends NPC

const ESPECIAL_ADAGAS_ENVENENADAS = 1
const ESPECIAL_INVISIBILIDADE = 2
const ESPECIAL_ARCO_E_FLECHA = 3

@export var especial_adagas_envenenadas : int
@export var especial_invisibilidade : int
@export var especial_arco_e_flecha : int
@export var adagas : bool
@export var arco_e_flecha : bool
@export var usar_invisibilidade : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func receber_dano(quantidade: int):
	
	if(not usar_invisibilidade):
		vida -= quantidade
		
		if(vida <= 0):
			morre()
	else:
		usar_invisibilidade = false
		
func atacar():
	
	var quantidade_dano = 0
	var rolagem_dados = randi_range(1, 6) # aqui pode ser um metodo criado da classe de dado
	var bonificador = (forca * 0.3 + destreza * 0.6 + magia * 0.2)
	
	quantidade_dano = rolagem_dados + bonificador
	
	return quantidade_dano

func ataque_especial(escolha_ataque: int):
	
	if(escolha_ataque == ESPECIAL_ADAGAS_ENVENENADAS):
		var rolagem_de_dados = randi_range(1, 6)
		var perda_constituicao_oponente = round(rolagem_de_dados/2)
		return perda_constituicao_oponente
	elif(escolha_ataque == ESPECIAL_INVISIBILIDADE):
		usar_invisibilidade = true
	elif(escolha_ataque == ESPECIAL_ARCO_E_FLECHA):
		return atacar()*2
