extends Node2D

@export var ataque_grupo : bool

@onready var guerreiro = $Warrior
@onready var mago = $Mage
@onready var ladino = $Rogue


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$VidaGuerreiro.text = "HP: " + str($Warrior.vida)
	#$VidaMago.text = "HP: " + str($Mage.vida)
	#$VidaLadino.text = "HP: " + str($Rogue.vida)
	pass

# para as ações dos NPC's
func sorteador_acoes() -> int:
	
	# pelo o que eu entendi, os ataques especiais começam em 1
	# Tô considerando o ataque normal como zero
	var numero_escolhido = randi_range(0, 3)
	
	return numero_escolhido

func acao_guerreiro() -> void:
	# verificando se está vivo ou não. Se não, o nó é apagado da cena
	if (is_instance_valid(guerreiro)): 
		var acao_escolhida = sorteador_acoes()
		match (acao_escolhida):
			0:
				print("Ataque 0") # só para fins de debug
				if(is_instance_valid(mago) or is_instance_valid(ladino)):
					var dano = guerreiro.atacar()
					if is_instance_valid(mago): # verificando se está vivo
						mago.receber_dano(dano)
					if is_instance_valid(ladino): # verificando se está vivo
						ladino.receber_dano(dano)
			1:
				print("Ataque 1") # só para fins de debug
				guerreiro.ataque_especial(1) # escudo
			2: 
				print("Ataque 2") # só para fins de debug
				if(is_instance_valid(mago) or is_instance_valid(ladino)):
					var dano = guerreiro.ataque_especial(2) # ESPECIAL_ATAQUE
					if is_instance_valid(mago): # verificando se está vivo
						mago.receber_dano(dano)
					if is_instance_valid(ladino): # verificando se está vivo
						ladino.receber_dano(dano)
			3:
				print("Ataque 3") # só para fins de debug
				guerreiro.ataque_especial(3) # CHAMAR INIMIGOS
	return			
	
func acao_mago() -> void:
	# verificando se está vivo ou não. Se não, o nó é apagado da cena
	if (is_instance_valid(mago)): 
		var acao_escolhida = sorteador_acoes()
		match (acao_escolhida):
			0:
				print("Ataque 0") # só para fins de debug
				if(is_instance_valid(guerreiro) or is_instance_valid(ladino)):
					var dano = mago.atacar()
					if is_instance_valid(guerreiro): # verificando se está vivo
						guerreiro.receber_dano(dano)
					if is_instance_valid(ladino): # verificando se está vivo
						ladino.receber_dano(dano)
			1:
				print("Ataque 1") # só para fins de debug
				mago.ataque_especial(1) # escudo
			2: 
				print("Ataque 2") # só para fins de debug
				if(is_instance_valid(guerreiro) or is_instance_valid(ladino)):
					var dano = mago.ataque_especial(2) # ESPECIAL_ATAQUE
					if is_instance_valid(guerreiro): # verificando se está vivo
						guerreiro.receber_dano(dano)
					if is_instance_valid(ladino): # verificando se está vivo
						ladino.receber_dano(dano)
			3:
				print("Ataque 3") # só para fins de debug
				mago.ataque_especial(3) # CHAMAR INIMIGOS
	return 
	
func acao_ladino() -> void:
	# verificando se está vivo ou não. Se não, o nó é apagado da cena
	if (is_instance_valid(ladino)): 
		var acao_escolhida = sorteador_acoes()
		match (acao_escolhida):
			0:
				print("Ataque 0") # só para fins de debug
				if(is_instance_valid(mago) or is_instance_valid(guerreiro)):
					var dano = ladino.atacar()
					if is_instance_valid(mago): # verificando se está vivo
						mago.receber_dano(dano)
					if is_instance_valid(guerreiro): # verificando se está vivo
						guerreiro.receber_dano(dano)
			1:
				print("Ataque 1") # só para fins de debug
				ladino.ataque_especial(1) # escudo
			2: 
				print("Ataque 2") # só para fins de debug
				if(is_instance_valid(mago) or is_instance_valid(guerreiro)):
					var dano = ladino.ataque_especial(2) # ESPECIAL_ATAQUE
					if is_instance_valid(mago): # verificando se está vivo
						mago.receber_dano(dano)
					if is_instance_valid(guerreiro): # verificando se está vivo
						guerreiro.receber_dano(dano)
			3:
				print("Ataque 3") # só para fins de debug
				ladino.ataque_especial(3) # CHAMAR INIMIGOS
	return			
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# FOR só para testar
	for i in range(3):
		# esperar um tempo para começar as batalhas
		await get_tree().create_timer(5.0).timeout
		match i:
			1: 	# Quem ataca primeiro é o guerreiro
				acao_guerreiro()
			2: 	# Depois o mago 
				acao_mago()
			3: 	# Depois o ladino
				acao_ladino()

	pass


func _on_warrior_attack_pressed() -> void:
	var dano = 0
	dano = $Warrior.atacar()
	
	$Mage.receber_dano(dano)
	$VidaMago.text = "HP: " + str($Mage.vida)
	
	$Rogue.receber_dano(dano)
	$VidaLadino.text = "HP: " + str($Rogue.vida)


func _on_mage_attack_pressed() -> void:
	var dano = 0
	dano = $Mage.atacar()
	$Warrior.receber_dano(dano)
	$VidaGuerreiro.text = "HP: " + str($Warrior.vida)

func _on_rogue_attack_pressed() -> void:
	var dano = 0
	dano = $Rogue.atacar()
	$Warrior.receber_dano(dano)
	$VidaGuerreiro.text = "HP: " + str($Warrior.vida)

func _on_ataque_especial_pressed() -> void:
	
	if($Warrior.especial_ataque):
		var dano = 0
		dano = $Warrior.ataque_especial($Warrior.ESPECIAL_ATAQUE)
		$Mage.receber_dano(dano)
		$VidaMago.text = "HP: " + str($Mage.vida)
		
		$Rogue.receber_dano(dano)
		$VidaLadino.text = "HP: " + str($Rogue.vida)
		
		$Warrior.especial_ataque -= 1

func _on_defesa_pressed() -> void:
	
	if($Warrior.especial_defesa):
		$Warrior.ataque_especial($Warrior.ESPECIAL_DEFESA)
		
		$Warrior.especial_defesa -= 1

func _on_chamar_inimigos_pressed() -> void:
	
	if($Warrior.especial_chamar_inimigos):
		ataque_grupo = $Warrior.ataque_especial($Warrior.ESPECIAL_CHAMAR_INIMIGOS)
		$Warrior.especial_chamar_inimigos -= 1


func _on_cura_pressed() -> void:
	
	if($Mage.especial_cura):
		$Mage.ataque_especial($Mage.ESPECIAL_CURA)
		$Mage.especial_cura -= 1
		$VidaMago.text = "HP: " + str($Mage.vida)

func _on_barreira_protetora_pressed() -> void:
	
	if($Mage.especial_barreira_protetora):
		$Mage.ataque_especial($Mage.ESPECIAL_BARREIRA_PROTETORA)
		$Mage.especial_barreira_protetora -= 1

func _on_bola_de_fogo_pressed() -> void:
	
	if($Mage.especial_bola_de_fogo):
		var dano = 0
		dano = $Mage.ataque_especial($Mage.ESPECIAL_BOLA_DE_FOGO)
		$Warrior.receber_dano(dano)
		$VidaGuerreiro.text = "HP: " + str($Warrior.vida)
		$Mage.especial_bola_de_fogo -= 1

func _on_adagas_envenenadas_pressed() -> void:
	
	if($Rogue.especial_adagas_envenenadas and $Rogue.adagas):
		var perda_constituicao_oponente = $Rogue.ataque_especial($Rogue.ESPECIAL_ADAGAS_ENVENENADAS)
		$Warrior.constituicao -= perda_constituicao_oponente
		$ConstituicaoGuerreiro.text = "Constituição: " + str($Warrior.constituicao)
		$Rogue.especial_adagas_envenenadas -= 1


func _on_invisibilidade_pressed() -> void:
	
	if($Rogue.especial_invisibilidade):
		$Rogue.ataque_especial($Rogue.ESPECIAL_INVISIBILIDADE)
		$Rogue.especial_invisibilidade -= 1


func _on_arco_e_flecha_pressed() -> void:
	
	if($Rogue.especial_arco_e_flecha and $Rogue.arco_e_flecha):
		var dano = 0
		dano = $Rogue.ataque_especial($Rogue.ESPECIAL_ARCO_E_FLECHA)
		$Warrior.receber_dano(dano)
		$VidaGuerreiro.text = "HP: " + str($Warrior.vida)
		$Rogue.especial_arco_e_flecha -= 1
