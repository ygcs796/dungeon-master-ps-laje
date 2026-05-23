extends CharacterBody2D
class_name NPC

@export var constituicao : int
@export var vida: int = 10
@export var forca : int
@export var destreza : int
@export var magia : int
@export var vivo : bool

func receber_dano(quantidade: int):
	vida -= quantidade
	
	if(vida <= 0):
		morre()

func curar(quantidade: int):
	vida += quantidade
	
func atacar(): # cada classe vai ter um bonificador diferente, da pra deixar esse metodo como override
	pass
	
func tomar_decisao(): # pensei em colocar algum tipo de mecânica enovolvendo o nivel de confiança do mestre do jogo
	pass
	
func morre():
	queue_free()
	print("morreu")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
