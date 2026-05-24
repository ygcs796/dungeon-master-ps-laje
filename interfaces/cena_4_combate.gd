extends Control

# Variável que controla a ordem (0 = Guerreiro, 1 = Mago, 2 = Ladino, 3 = Inimigo)
var vez_atual: int = 0

var avancou_no_dialogo = false # variável de controle dos turnos do RPG

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

# Loop automático corrigido para pular personagens mortos instantaneamente
func executar_loop_de_combate() -> void:
	
	while batalha_ativa:
		$dado/Button.disabled = false # inicialmente
		$botoes_mestre.visible = false
		$perda_vida_inimigo.visible = false     
		$caixa_dialogo.visible = false # o diálogo só vai aparecer quando for necessário
		$dado.visible = false # interface do dado invisível
		
		# 1. VERIFICAÇÕES DE FIM DE JOGO
		if InimigoTeste.vida <= 0:
			#$HBoxContainer/MarginContainer2/TextoVez.text = "O Inimigo foi derrotado!"
			$caixa_dialogo.visible = true # diálogo visível
			$caixa_dialogo/PainelTexto/Texto.text = "O Inimigo foi derrotado!"
			batalha_ativa = false
			get_tree().change_scene_to_file("res://interfaces/cena_game_over.tscn")
			break
			
		elif Warrior.vida <= 0 and Mage.vida <= 0 and Rogue.vida <= 0:
			#$HBoxContainer/MarginContainer2/TextoVez.text = "Fim de Jogo! Todos os heróis morreram."
			$caixa_dialogo.visible = true # diálogo visível
			$caixa_dialogo/PainelTexto/Texto.text = "Fim de Jogo! Todos os heróis morreram."
			batalha_ativa = false
			get_tree().change_scene_to_file("res://interfaces/creditos.tscn")
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
				$caixa_dialogo.visible = true # diálogo visível
				$caixa_dialogo/imagemPersonagem.texture = load("res://assets/npc/warrior_falando.png")
				$caixa_dialogo/PainelTexto/Texto.text = "Com minha resistência, você nunca irá me vencer!" #frase inicial
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				var dano = Warrior.atacar() # ele ataca de qualquer jeito, eu só decido o destino do dano que ele dá
				$caixa_dialogo/PainelTexto/Texto.text = "Tome isso!" #frase de ataque
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				$caixa_dialogo/PainelTexto/Texto.text = "Minha vez de rodar o dado!" # frase do dado 
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				$caixa_dialogo.visible = false
				# RODANDO O DADO
				$dado.visible = true # dado aparece na tela
				$dado.rolar_dado()
				var resultado = await $dado.numero_dado
				$caixa_dialogo.visible = true # mostrando o diálogo
				if resultado > 10: # define esse número arbitrariamente
					if resultado == 20:
						dano = dano * 2
					if InimigoTeste.usando_escudo:
						dano /= 2
						InimigoTeste.usando_escudo = false
					InimigoTeste.receber_dano(dano)
					$perda_vida_inimigo.visible = true
					$perda_vida_inimigo.text = "-" + str(dano)
					$caixa_dialogo/PainelTexto/Texto.text = "Sinta a dor!" # frase do dado 
				else:
					if resultado == 1: # se cair, ele dá 20% em algum dos npcs
						# 0 é o índice do guerreiro
						# 1 é o índice do mago
						# 2 é o índice da ladina
						var aliado_atacado = randi() % 3
						match aliado_atacado:
							0:
								Warrior.vida -= dano * 0.2
								$caixa_dialogo/PainelTexto/Texto.text = "Eu enfiei a espada em mim mesmo!"
							1:
								Mage.vida -= dano * 0.2
								$caixa_dialogo/PainelTexto/Texto.text = "Eu ataquei o mago que estava comigo!"
							2: 
								Rogue.vida -= dano * 0.2
								$caixa_dialogo/PainelTexto/Texto.text = "Eu ataquei a ladina que está comigo!"
						await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
					if Warrior.vida > 0:	
						$caixa_dialogo/PainelTexto/Texto.text = "Não acredito que errei" # frase do dado 
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				$dado.visible = false # dado não aparece na tela	
				$perda_vida_inimigo.visible = false
				vez_atual = 1
				
			1:
				# TURNO DO MAGO
				$caixa_dialogo.visible = true # diálogo visível
				$caixa_dialogo/imagemPersonagem.texture = load("res://assets/npc/mage_falando.png")
				$caixa_dialogo/PainelTexto/Texto.text = "Minha magia é muito forte pra você" #frase inicial
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				var dano = Mage.atacar() # ele ataca de qualquer jeito, eu só decido o destino do dano que ele dá
				$caixa_dialogo/PainelTexto/Texto.text = "Tome isso!" #frase de ataque
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				$caixa_dialogo/PainelTexto/Texto.text = "Minha vez de rodar o dado!" # frase do dado 
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				$caixa_dialogo.visible = false
				# RODANDO O DADO
				$dado.visible = true # dado aparece na tela
				$dado.rolar_dado()
				var resultado = await $dado.numero_dado
				$caixa_dialogo.visible = true # mostrando o diálogo
				if resultado > 10: # define esse número arbitrariamente
					if resultado == 20:
						dano = dano * 2
					InimigoTeste.receber_dano(dano)
					$perda_vida_inimigo.visible = true
					$perda_vida_inimigo.text = "-" + str(dano)
					$caixa_dialogo/PainelTexto/Texto.text = "Sinta a dor!" # frase do dado 
				else:
					if resultado == 1: # se cair, ele dá 20% em algum dos npcs
						# 0 é o índice do guerreiro
						# 1 é o índice do mago
						# 2 é o índice da ladina
						var aliado_atacado = randi() % 3
						match aliado_atacado:
							0:
								Warrior.vida -= dano * 0.2
								$caixa_dialogo/PainelTexto/Texto.text = "Minha magia atingiu o guerreiro!"
							1:
								Mage.vida -= dano * 0.2
								$caixa_dialogo/PainelTexto/Texto.text = "Minha magia me atingiu!"
							2: 
								Rogue.vida -= dano * 0.2
								$caixa_dialogo/PainelTexto/Texto.text = "Minha magia atingiu a ladina!"
						await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
					if Mage.vida > 0:	
						$caixa_dialogo/PainelTexto/Texto.text = "Não acredito que errei" # frase do dado 
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				$dado.visible = false # dado não aparece na tela
				$perda_vida_inimigo.visible = false
				vez_atual = 2
				
			2:
				# TURNO DO LADINA
				$caixa_dialogo.visible = true # diálogo visível
				$caixa_dialogo/imagemPersonagem.texture = load("res://assets/npc/rogue_falando.png")
				$caixa_dialogo/PainelTexto/Texto.text = "Furtividade é o meu forte. Prepare-se!" #frase inicial
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				var dano = Rogue.atacar() # ele ataca de qualquer jeito, eu só decido o destino do dano que ele dá
				$caixa_dialogo/PainelTexto/Texto.text = "Tome isso!" #frase de ataque
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				$caixa_dialogo/PainelTexto/Texto.text = "Minha vez de rodar o dado!" # frase do dado 
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				$caixa_dialogo.visible = false
				# RODANDO O DADO
				$dado.visible = true # dado aparece na tela
				$dado.rolar_dado()
				var resultado = await $dado.numero_dado
				$caixa_dialogo.visible = true # mostrando o diálogo
				if resultado > 10: # define esse número arbitrariamente
					if resultado == 20:
						dano = dano * 2
					if InimigoTeste.usando_escudo:
						dano /= 2
						InimigoTeste.usando_escudo = false
					InimigoTeste.receber_dano(dano)
					$perda_vida_inimigo.visible = true
					$perda_vida_inimigo.text = "-" + str(dano)
					$caixa_dialogo/PainelTexto/Texto.text = "Sinta a dor!" # frase do dado 
				else:
					if resultado == 1: # se cair, ele dá 20% em algum dos npcs
						# 0 é o índice do guerreiro
						# 1 é o índice do mago
						# 2 é o índice da ladina
						var aliado_atacado = randi() % 3
						match aliado_atacado:
							0:
								Warrior.vida -= dano * 0.2
								$caixa_dialogo/PainelTexto/Texto.text = "Atingi minhas adagas no guerreiro!"
							1:
								Mage.vida -= dano * 0.2
								$caixa_dialogo/PainelTexto/Texto.text = "Atingi minhas adagas no mago!"
							2: 
								Rogue.vida -= dano * 0.2
								$caixa_dialogo/PainelTexto/Texto.text = "Me feri com minhas próprias armas!"
						await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
					if Rogue.vida > 0:	
						$caixa_dialogo/PainelTexto/Texto.text = "Não acredito que errei" # frase do dado 
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed	
				$dado.visible = false # dado não aparece na tela
				$perda_vida_inimigo.visible = false
				vez_atual = 3
				
			3:
				
				if InimigoTeste.vida > 0:
					# TURNO DO INIMIGO
					$caixa_dialogo.visible = true # diálogo visível
					$caixa_dialogo/imagemPersonagem.texture = load("res://assets/npc/Captura de tela 2026-05-23 020833.png")
					$caixa_dialogo/PainelTexto/Texto.text = "Uma batalha boa para mexer o esqueleto!" #frase inicial
					await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
					$caixa_dialogo/imagemPersonagem.texture = null
					$caixa_dialogo/PainelTexto/Texto.text = "Agora você deve escolher o que o inimigo vai fazer"
					await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
					$caixa_dialogo.visible = false
					await jogar_turno_do_inimigo()
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
	
	# movimentos do inimigo
	# atualizando o texto do botão de ataque especial
	if InimigoTeste.movimentos_certos == 2:
		$botoes_mestre/HBoxContainer/MarginContainer/ataque_especial.text = "USAR ATAQUE ESPECIAL"
	else:
		$botoes_mestre/HBoxContainer/MarginContainer/ataque_especial.text = "USAR ATAQUE ESPECIAL (" + str(InimigoTeste.movimentos_certos) +"/2)"
	
	$botoes_mestre.visible = true
	if InimigoTeste.pode_usar_ataque_especial:
		$botoes_mestre/HBoxContainer/MarginContainer/ataque_especial.disabled = false
	var botao_apertado = await $botoes_mestre.algum_botao_apertado
	$botoes_mestre.visible = false
	
	# diálogo do dado
	$caixa_dialogo.visible = true
	$caixa_dialogo/PainelTexto/Texto.text = "Agora você, {Master}, deve rodar o dado!".format({"Master": Master.nome})
	await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
	$caixa_dialogo.visible = false
	$dado.visible = true # dado aparece na tela
	var resultado = await $dado.numero_dado
	if resultado > 10:
		match botao_apertado:
			1: # ataque simples
				var indice_sorteado = randi() % alvos_vivos.size()
				var alvo_escolhido = alvos_vivos[indice_sorteado]
				
				var dano_do_inimigo = InimigoTeste.dar_dano(false)
				
				if resultado == 20:
					dano_do_inimigo *= 2
				
				match alvo_escolhido:
					"Guerreiro":
						Warrior.vida -= dano_do_inimigo
					"Mago":
						Mage.vida -= dano_do_inimigo
					"Ladino":
						Rogue.vida -= dano_do_inimigo
						
				InimigoTeste.movimentos_certos += 1
				$caixa_dialogo.visible = true
				$caixa_dialogo/PainelTexto/Texto.text = "MORRA!!!"
				await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				
			2: # Ataque especial
				var indice_sorteado = randi() % alvos_vivos.size()
				var alvo_escolhido = alvos_vivos[indice_sorteado]
				
				var dano_do_inimigo = InimigoTeste.dar_dano(true)
				
				if resultado == 20:
					dano_do_inimigo += 10 # aumentando de 20 para 30
				
				match alvo_escolhido:
					"Guerreiro":
						Warrior.vida -= dano_do_inimigo
					"Mago":
						Mage.vida -= dano_do_inimigo
					"Ladino":
						Rogue.vida -= dano_do_inimigo
				
				InimigoTeste.movimentos_certos = 0 # zerando
				InimigoTeste.pode_usar_ataque_especial = false
					
			3: # escudo
				InimigoTeste.usando_escudo = true
				InimigoTeste.movimentos_certos += 1 
	else:
		$caixa_dialogo.visible = true
		$caixa_dialogo/imagemPersonagem.texture = load("res://assets/npc/Captura de tela 2026-05-23 020833.png")
		if resultado == 1:
			match botao_apertado:
				1: # ataque simples
					var dano_do_inimigo = InimigoTeste.dar_dano(false)
					InimigoTeste.vida -= dano_do_inimigo
					$caixa_dialogo/PainelTexto/Texto.text = "Estou tão velho que estou me atacando!"
					await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
				2: # ataque especial
					var dano_do_inimigo = InimigoTeste.dar_dano(true)
					InimigoTeste.vida -= dano_do_inimigo
				3: # escudo
					InimigoTeste.usando_escudo = false
			
		$caixa_dialogo/PainelTexto/Texto.text = "Não é possível, eu errei o meu próprio movimento!"
		await $"caixa_dialogo/PainelTexto/Texto/botão_avancar".pressed
	
	if InimigoTeste.movimentos_certos == 2:
		InimigoTeste.pode_usar_ataque_especial = true
