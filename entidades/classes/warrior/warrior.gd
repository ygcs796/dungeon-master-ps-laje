extends NPC

const ESPECIAL_DEFESA = 1
const ESPECIAL_ATAQUE = 2
const ESPECIAL_CHAMAR_INIMIGOS = 3

@export var especial_defesa: int
@export var especial_ataque: int
@export var especial_chamar_inimigos: int
@export var usar_escudo: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func receber_dano(quantidade: int):
	
	if(not usar_escudo):
		vida -= quantidade
		
		if(vida <= 0):
			morre()
	else:
		usar_escudo = false
	
func atacar():
	
	var quantidade_dano = 0
	var rolagem_dados = randi_range(1, 6) # aqui pode ser um metodo criado da classe de dado
	var bonificador = (forca * 0.7 + destreza * 0.2 + magia * 0.1)
	
	quantidade_dano = rolagem_dados + bonificador
	
	return quantidade_dano

func ataque_especial(escolha_ataque: int):
	
	if(escolha_ataque == ESPECIAL_DEFESA):
		usar_escudo = true
	elif(escolha_ataque == ESPECIAL_ATAQUE):
		return atacar()*2
	elif(escolha_ataque == ESPECIAL_CHAMAR_INIMIGOS):
		return true
