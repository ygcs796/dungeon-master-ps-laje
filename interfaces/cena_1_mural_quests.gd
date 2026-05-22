extends Control

var quantidade_cliques : int
var clicou_sim : bool

var texto_mago = [
	"Nossa mesa está sendo desfeita. Desde que o último mestre saiu, não conseguimos outro que fosse à altura e muitos membros já foram embora.",
	"Só restaram nós 3. Qual o seu nome?"
]

var texto_ladina = [
	"Nós nunca daríamos uma chance para alguém como você, {Master}. Sua sorte é que já testamos todos os outros DM's da cidade e você é a nossa última opção. Se você falhar, nós vamos desfazer a mesa.",
	"E talvez depois disso arrumar uma vida real para viver e parar de fugir da realidade através de escapismo fantasioso...",
	"Brincadeira.",
	"Você só não vai ser contratado mesmo. E nós vamos continuar esperando tediosamente até a nossa salvação surgir de algum lugar.",
	"Mas não fique esperançoso. Provavelmente não é você."
]

var texto_guerreiro = [
	"É...",
	"Sua missão é nos derrotar em uma campanha rápida.",
	"Se você não narrar uma boa história, estamos fora. Se a gente ganhar no final, estamos fora.",
	"Mas se você nos der um desafio à altura...",
	"...",
	"Você realmente é um Mestre RPG. Você aceita?"
]

var texto_ladina_resposta_negativa = [
	"É, eu sabia. É muita areia para o seu caminhãozinho."
]

var texto_mago_resposta_negativa = [
	"Eu desisto..."
]

var texto_guerreiro_resposta_positiva = [
	"Obrigado, vamos lá."
]

var texto_mago_resposta_positiva = [
	"Espera! Como é o seu estilo de Mestrar?",
	"É. interessante. Acho que vai rolar. Vamos."
]

var texto_ladina_resposta_positiva = [
	"Vamos ver do que você realmente é capaz."
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quantidade_cliques = 0
	$BarraDialogo/PainelTexto.visible = false
	$JanelaInserirNome.visible = false
	$JanelaEscolha.visible = false
	$FadeOutTela.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_botao_anuncio_pressed() -> void:
	$BarraDialogo/ImagemPersonagem.texture = load("res://assets/npc/mage.png")
	$BarraDialogo/PainelTexto.visible = true
	$BarraDialogo/PainelTexto/TextoDialogo.text = texto_mago[0]
	$ContainerGameOver.visible = false

func _on_botao_texto_pressed() -> void:
	
	quantidade_cliques += 1
	match quantidade_cliques:
		
		1:
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_mago[1]
		2:
			$JanelaInserirNome.popup()
		3:
			$BarraDialogo/ImagemPersonagem.texture = load("res://assets/npc/rogue.png")
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_ladina[0].format({"Master": Master.nome})
		4:
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_ladina[1]
		5:
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_ladina[2]
		6:
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_ladina[3]
		7:
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_ladina[4]
		8:
			$BarraDialogo/ImagemPersonagem.texture = load("res://assets/npc/warrior.png")
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_guerreiro[0]
		9:
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_guerreiro[1]
		10:
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_guerreiro[2]
		11:
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_guerreiro[3]
		12:
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_guerreiro[4]
		13:
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_guerreiro[5]
		14:
			$JanelaEscolha.popup()
		15:
			if(clicou_sim):
				$BarraDialogo/PainelTexto/TextoDialogo.text = texto_guerreiro_resposta_positiva[0]
			else:
				$BarraDialogo/ImagemPersonagem.texture = load("res://assets/npc/rogue.png")
				$BarraDialogo/PainelTexto/TextoDialogo.text = texto_ladina_resposta_negativa[0]
		16:
			if(clicou_sim):
				$BarraDialogo/ImagemPersonagem.texture = load("res://assets/npc/rogue.png")
				$BarraDialogo/PainelTexto/TextoDialogo.text = texto_ladina_resposta_positiva[0]
			else:
				$BarraDialogo/ImagemPersonagem.texture = load("res://assets/npc/mage.png")
				$BarraDialogo/PainelTexto/TextoDialogo.text = texto_mago_resposta_negativa[0]
		17:
			if(clicou_sim):
				$BarraDialogo/ImagemPersonagem.texture = load("res://assets/npc/mage.png")
				$BarraDialogo/PainelTexto/TextoDialogo.text = texto_mago_resposta_positiva[0]
			else:
				$ContainerGameOver.visible = true
		18:
			Master.pontos_disponiveis = 3
			$JanelaDistribuicaoAtributos.popup()
		19:
			$BarraDialogo/PainelTexto/TextoDialogo.text = texto_mago_resposta_positiva[1]
			
			$FadeOutTela.visible = true
			$FadeOutTela/FadeOutAnimacao.play("fade_out")
			
			await $FadeOutTela/FadeOutAnimacao.animation_finished
			
			get_tree().change_scene_to_file("res://interfaces/cena_2_mapa.tscn")
		20:
			get_tree().change_scene_to_file("res://interfaces/cena_2_mapa.tscn")
			
				

func _on_botao_confirmar_nome_pressed() -> void:
	Master.nome = $JanelaInserirNome/ImagemInserirNome/BarraInserirNome/MarginContainer/InputInserirNome.text
	$JanelaInserirNome.queue_free()
	_on_botao_texto_pressed()
	


func _on_botao_nao_pressed() -> void:
	
	$JanelaEscolha.queue_free()
	_on_botao_texto_pressed()


func _on_botao_sim_pressed() -> void:
	
	$JanelaEscolha.queue_free()
	clicou_sim = true
	_on_botao_texto_pressed()


func _on_botao_game_over_pressed() -> void:
	get_tree().change_scene_to_file("res://interfaces/menu_principal.tscn")

func _on_botao_confirmar_atributos_mestre_pressed() -> void:
	
	$JanelaDistribuicaoAtributos.queue_free()
	_on_botao_texto_pressed()

###########################################################
## Sinais das setas da janela de atribuição de atributos ##
###########################################################

# --- NARRATIVA ---

func _on_seta_cima_narrativa_pressed() -> void:
	
	if(Master.pontos_disponiveis > 0):
		Master.narrativa += 1
		Master.pontos_disponiveis -= 1
		$JanelaDistribuicaoAtributos/HBoxContainer/VBoxContainer/MarginContainer2/GridContainer/NumeroNarrativa.text = str(Master.narrativa)

func _on_seta_baixo_narrativa_pressed() -> void:
	
	if(Master.narrativa > 0):
		Master.narrativa -= 1
		Master.pontos_disponiveis += 1
		$JanelaDistribuicaoAtributos/HBoxContainer/VBoxContainer/MarginContainer2/GridContainer/NumeroNarrativa.text = str(Master.narrativa)

# --- PERSUASÃO ---
func _on_seta_cima_pesuasao_pressed() -> void:
	
	if(Master.pontos_disponiveis > 0):
		Master.persuasao += 1
		Master.pontos_disponiveis -= 1
		$JanelaDistribuicaoAtributos/HBoxContainer/VBoxContainer/MarginContainer2/GridContainer/NumeroPersuasao.text = str(Master.persuasao)

func _on_seta_baixo_persuasao_pressed() -> void:
	
	if(Master.persuasao > 0):
		Master.persuasao -= 1
		Master.pontos_disponiveis += 1
		$JanelaDistribuicaoAtributos/HBoxContainer/VBoxContainer/MarginContainer2/GridContainer/NumeroPersuasao.text = str(Master.persuasao)

# --- CRIATIVIDADE ---
func _on_seta_cima_criatividade_pressed() -> void:
	
	if(Master.pontos_disponiveis > 0):
		Master.criatividade += 1
		Master.pontos_disponiveis -= 1
		$JanelaDistribuicaoAtributos/HBoxContainer/VBoxContainer/MarginContainer2/GridContainer/NumeroCriatividade.text = str(Master.criatividade)

func _on_seta_baixo_criatividade_pressed() -> void:
	
	if(Master.criatividade > 0):
		Master.criatividade -= 1
		Master.pontos_disponiveis += 1
		$JanelaDistribuicaoAtributos/HBoxContainer/VBoxContainer/MarginContainer2/GridContainer/NumeroCriatividade.text = str(Master.criatividade)

# --- SORTE ---
func _on_seta_cima_sorte_pressed() -> void:
	
	if(Master.pontos_disponiveis > 0):
		Master.sorte += 1
		Master.pontos_disponiveis -= 1
		$JanelaDistribuicaoAtributos/HBoxContainer/VBoxContainer/MarginContainer2/GridContainer/NumeroSorte.text = str(Master.sorte)

func _on_seta_baixo_sorte_pressed() -> void:
	
	if(Master.sorte > 0):
		Master.sorte -= 1
		Master.pontos_disponiveis += 1
		$JanelaDistribuicaoAtributos/HBoxContainer/VBoxContainer/MarginContainer2/GridContainer/NumeroSorte.text = str(Master.sorte)
