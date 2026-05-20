extends Node2D

@export var ataque_grupo : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VidaGuerreiro.text = "HP: " + str($Warrior.vida)
	$VidaMago.text = "HP: " + str($Mage.vida)
	$VidaLadino.text = "HP: " + str($Rogue.vida)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
