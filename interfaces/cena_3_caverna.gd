extends Control

# Variável que controla a ordem (0 = Guerreiro, 1 = Mago, 2 = Ladino, 3 = Inimigo)
var vez_atual: int = 0

# Controla se a batalha automática deve continuar rodando
var batalha_ativa: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atualizar_interface()
	# Inicia o loop automático de combate
	executar_loop_de_combate()

# Atualiza os textos de vida e mostra quem irá atacar a seguir
func atualizar_interface() -> void:
	$VBoxContainer/HBoxContainer/VidaGuerreiro.text = "HP: " + str(max(0, Warrior.vida))
	$VBoxContainer/HBoxContainer2/VidaMago.text = "HP: " + str(max(0, Mage.vida))
	$VBoxContainer/HBoxContainer3/VidaLadina.text = "HP: " + str(max(0, Rogue.vida))
	$Inimigo/VidaInimigo.text = "HP: " + str(max(0, InimigoTeste.vida))
	
	# Atualiza o texto informando quem é a vez atual
	match vez_atual:
		0: $HBoxContainer/MarginContainer2/TextoVez.text = "Vez do: Guerreiro"
		1: $HBoxContainer/MarginContainer2/TextoVez.text = "Vez do: Mago"
		2: $HBoxContainer/MarginContainer2/TextoVez.text = "Vez do: Ladino"
		3: $HBoxContainer/MarginContainer2/TextoVez.text = "Vez do: Inimigo"

# Loop automático corrigido para pular personagens mortos instantaneamente
func executar_loop_de_combate() -> void:
	while batalha_ativa:
		
		# 1. VERIFICAÇÕES DE FIM DE JOGO
		if InimigoTeste.vida <= 0:
			$HBoxContainer/MarginContainer2/TextoVez.text = "O Inimigo foi derrotado!"
			batalha_ativa = false
			break
			
		if Warrior.vida <= 0 and Mage.vida <= 0 and Rogue.vida <= 0:
			$HBoxContainer/MarginContainer2/TextoVez.text = "Fim de Jogo! Todos os heróis morreram."
			batalha_ativa = false
			break

		# 2. LOGICA DE FILTRAGEM: Se o personagem do turno atual estiver morto,
		# nós passamos a vez adiante NA MESMA HORA (usando 'continue' para reiniciar o loop sem dar o 'await')
		if vez_atual == 0 and Warrior.vida <= 0:
			vez_atual = 1 # Guerreiro morto -> passa pro Mago
			continue
			
		if vez_atual == 1 and Mage.vida <= 0:
			vez_atual = 2 # Mago morto -> passa pro Ladino
			continue
			
		if vez_atual == 2 and Rogue.vida <= 0:
			vez_atual = 3 # Ladino morto -> passa pro Inimigo
			continue

		# Se chegou até aqui, significa que o personagem da vez está VIVO.
		# Então atualizamos a tela para o jogador ver quem vai agir e esperamos os 2 segundos.
		atualizar_interface()
		await get_tree().create_timer(2.0).timeout

		# 3. EXECUÇÃO DO ATAQUE (Garantido que o atacante está vivo por conta dos filtros acima)
		match vez_atual:
			0:
				# TURNO DO GUERREIRO
				var dano = Warrior.atacar()
				InimigoTeste.receber_dano(dano)
				vez_atual = 1
				
			1:
				# TURNO DO MAGO
				var dano = Mage.atacar()
				InimigoTeste.receber_dano(dano)
				vez_atual = 2
				
			2:
				# TURNO DO LADINO
				var dano = Rogue.atacar()
				InimigoTeste.receber_dano(dano)
				vez_atual = 3
				
			3:
				# TURNO DO INIMIGO
				if InimigoTeste.vida > 0:
					jogar_turno_do_inimigo()
				vez_atual = 0

		# Atualiza a tela logo após o dano ser aplicado (para atualizar as barras/textos de vida)
		atualizar_interface()


# Função para gerenciar o ataque e o sorteio do Inimigo (permanece igual)
func jogar_turno_do_inimigo() -> void:
	var alvos_vivos = []
	if Warrior.vida > 0: alvos_vivos.append("Guerreiro")
	if Mage.vida > 0: alvos_vivos.append("Mago")
	if Rogue.vida > 0: alvos_vivos.append("Ladino")
	
	if alvos_vivos.size() == 0:
		return
		
	var indice_sorteado = randi() % alvos_vivos.size()
	var alvo_escolhido = alvos_vivos[indice_sorteado]
	
	var dano_do_inimigo = InimigoTeste.dar_dano()
	
	match alvo_escolhido:
		"Guerreiro":
			Warrior.vida -= dano_do_inimigo
		"Mago":
			Mage.vida -= dano_do_inimigo
		"Ladino":
			Rogue.vida -= dano_do_inimigo
