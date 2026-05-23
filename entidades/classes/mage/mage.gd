extends NPC

const ESPECIAL_CURA = 1
const ESPECIAL_BARREIRA_PROTETORA = 2
const ESPECIAL_BOLA_DE_FOGO = 3

@export var especial_cura: int
@export var especial_barreira_protetora: int
@export var especial_bola_de_fogo: int
@export var usar_barreira : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func receber_dano(quantidade: int):
	
	if(not usar_barreira):
		vida -= quantidade
		
		if(vida <= 0):
			morre()
	else:
		usar_barreira = false
	
func atacar():
	
	var quantidade_dano = 0
	var rolagem_dados = randi_range(1, 6) # aqui pode ser um metodo criado da classe de dado
	var bonificador = (forca * 0.1 + destreza * 0.2 + magia * 0.7)
	
	quantidade_dano = rolagem_dados + bonificador
	
	return quantidade_dano

func ataque_especial(escolha_ataque: int):
	
	if(escolha_ataque == ESPECIAL_CURA):
		curar(10)
	elif(escolha_ataque == ESPECIAL_BARREIRA_PROTETORA):
		usar_barreira = true
	elif(escolha_ataque == ESPECIAL_BOLA_DE_FOGO):
		return atacar()*2
