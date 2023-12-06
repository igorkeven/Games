import pygame
import sys
import time
import os

# Inicialização do Pygame
pygame.init()

# Configurações da tela
largura, altura = 800, 600
tela = pygame.display.set_mode((largura, altura))
pygame.display.set_caption("Super Mario World Clone")

# Carregando a imagem do Mario indo para frente
mario_avancando = pygame.image.load("C:/Users/igork/Desktop/automatização/mario03.png")  
novo_tamanho = (100, 100)
# Redimensionando a imagem
mario_avancando_redimensionado = pygame.transform.scale(mario_avancando, novo_tamanho)

# Carregando a imagem do Mario indo para tras
mario_voltando = pygame.image.load("C:/Users/igork/Desktop/automatização/mario_voltando.png")  
novo_tamanho_voltando = (100, 100)
# Redimensionando a imagem
mario_voltando_redimensionado = pygame.transform.scale(mario_voltando, novo_tamanho_voltando)

# Carregando a imagem do Mario parado
mario_parado = pygame.image.load("C:/Users/igork/Desktop/automatização/mario_parado.png")  
novo_tamanho_parado = (100, 100)
# Redimensionando a imagem
mario_parado_redimensionado = pygame.transform.scale(mario_parado, novo_tamanho_parado)

# Carregando a imagem do Mario pulando
mario_pulando = pygame.image.load("C:/Users/igork/Desktop/automatização/mario_pulando.png")  
novo_tamanho_pulando = (100, 100)
# Redimensionando a imagem
mario_pulando_redimensionado = pygame.transform.scale(mario_pulando, novo_tamanho_pulando)

# Carregando a imagem do Mario agachado
mario_agachado = pygame.image.load("C:/Users/igork/Desktop/automatização/mario_agachado3.png")  
novo_tamanho_agachado = (70, 70)
# Redimensionando a imagem
mario_agachado_redimensionado = pygame.transform.scale(mario_agachado, novo_tamanho_agachado)

# Carregando a imagem do Mario ocioso
mario_ocioso = pygame.image.load("C:/Users/igork/Desktop/automatização/mario_ocioso4.png")  
novo_tamanho_ocioso = (100, 100)
# Redimensionando a imagem
mario_ocioso_redimensionado = pygame.transform.scale(mario_ocioso, novo_tamanho_ocioso)


# Carregando a imagem de fundo
fundo_img = pygame.image.load("C:/Users/igork/Desktop/automatização/fundo.jpeg")  
# Redimensionando a imagem
fundo_img_redimensionado = pygame.transform.scale(fundo_img, (largura, altura))

item_img = pygame.image.load("C:/Users/igork/Desktop/automatização/cano2.png")  
novo_tamanho_item = (150, 150)
# Redimensionando a imagem
item_img_redimensionado = pygame.transform.scale(item_img, novo_tamanho_item)
# Posição inicial do Mario
mario_x, mario_y = largura // 2, altura - 190

mario = mario_parado_redimensionado

# Variáveis para o pulo
pulando = False
altura_do_pulo = 10
altura_do_chao = altura - 180
contador = 0
# Lista de itens
itens = []

# Função para adicionar um novo item à direita da tela
def adicionar_item():
    novo_item = pygame.Rect(largura, altura - 230, 50, 50)
    itens.append(novo_item)
    

item_deve_mover = True

def mover_itens():
    global item_deve_mover
    for item in itens:
        if item_deve_mover:
            item.move_ip(-2, 0)
        if item.right < 0:
            itens.remove(item)

ultimo_evento_tecla = pygame.time.get_ticks()

# Defina as coordenadas iniciais do Koopa
pos_x_koopa = -180
pos_y_koopa = altura - 170
velocidade_koopa = 0.1  # Defina a velocidade de movimento do Koopa

# Variável para controlar os quadros da animação do Koopa
quadro_atual_koopa = 0
contador_koopa = 0
trocar_quadro_koopa = 2  # Altere este valor para ajustar a velocidade da animação do Koopa


# Carregando os quadros da animação
quadros_koopa = []
for i in range(2):
    quadro = pygame.image.load(os.path.join('C:/Users/igork/Desktop/automatização/', f'koopa_{i}.png'))
    quadro_redimensionado = pygame.transform.scale(quadro, (90, 100))
    quadros_koopa.append(quadro_redimensionado)



# Carregando os quadros da animação
quadros_voltando = []
for i in range(11):
    quadro = pygame.image.load(os.path.join('C:/Users/igork/Desktop/automatização/mario_voltando', f'mario_andando_{i}.png'))
    quadro_redimensionado = pygame.transform.scale(quadro, (130, 130))
    quadros_voltando.append(quadro_redimensionado)


quadros = []
for i in range(11):
    quadro = pygame.image.load(os.path.join('C:/Users/igork/Desktop/automatização/mario_andando', f'mario_andando_{i}.png'))
    quadro_redimensionado = pygame.transform.scale(quadro, (130, 130))
    quadros.append(quadro_redimensionado)
# Variável para acompanhar o quadro atual
quadro_atual = 0



# Loop principal do jogo
while True:
    pos_x_koopa += velocidade_koopa
    mario = mario_parado_redimensionado
    altura_do_chao = altura - 190
      # Variável para verificar se o Mario está colidindo com algum item
    mario_colidindo = False


    # Se o Koopa ultrapassar a borda da tela, faça-o voltar ao outro lado
    if pos_x_koopa > largura:
        pos_x_koopa = -180  # Defina a posição inicial do Koopa novamente fora da tela para reaparecer do lado oposto


    for evento in pygame.event.get():
        if evento.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
    
    # Lógica do movimento do Mario (por exemplo, teclas de seta)
    keys = pygame.key.get_pressed()
    if keys[pygame.K_LEFT] and mario_x > 0:
        altura_do_chao = altura -210
        mario = quadros_voltando[quadro_atual]
        mario_x -= 2
        ultimo_evento_tecla = pygame.time.get_ticks()
   
        

        
    if keys[pygame.K_RIGHT] :
        altura_do_chao = altura -210
        if mario_x < largura // 2:
            mover_itens()
            
            mario = quadros[quadro_atual] 
            mario_x += 2
            ultimo_evento_tecla = pygame.time.get_ticks()   
            
        else:
            mario = quadros[quadro_atual] 
            mover_itens()
            ultimo_evento_tecla = pygame.time.get_ticks()
    
   

    if not(pulando): # impede o movimento para cima ou para baixo enquanto pula
        if keys[pygame.K_UP]:
            mario = mario_pulando_redimensionado
            pulando = True
            ultimo_evento_tecla = pygame.time.get_ticks()
        elif keys[pygame.K_DOWN]:  
            mario = mario_agachado_redimensionado  
            mario_y = altura - 160 
            ultimo_evento_tecla = pygame.time.get_ticks()
        else:
            mario_y = altura_do_chao  
    else:
        if altura_do_pulo >= -10:
            mario = mario_pulando_redimensionado
            mario_y -= (altura_do_pulo * abs(altura_do_pulo)) * 0.3
            altura_do_pulo -= 0.3
            
        else: 
            altura_do_pulo = 10
            pulando = False
        mario = mario_parado_redimensionado        
        
        
    if altura_do_pulo < 10:
        mario = mario_pulando_redimensionado

    # Adicione um novo item se necessário
    if len(itens) < 5:
        adicionar_item()

    # Verifica se nenhuma tecla foi pressionada nos últimos 2 segundos
    if pygame.time.get_ticks() - ultimo_evento_tecla > 4000:
        mario = mario_ocioso_redimensionado
        mario_y = altura_do_chao + 5
        

    # Desenhe o fundo, os itens e o Mario na tela
    tela.blit(fundo_img_redimensionado, (0, 0))
    for item in itens:
        tela.blit(item_img_redimensionado, (item.x, item.y))

        # Verifica se o Mario está colidindo com o item
        if pygame.Rect(mario_x, mario_y, novo_tamanho_item[0] - 50, novo_tamanho_item[1]).colliderect(item):
            mario_x -= 2  # Faz o Mario parar quando chega ao item
            item_deve_mover = False  # Faz o item parar de se mover
            mario_colidindo = True
            if mario_y + novo_tamanho_item[1] < item.top:  # Verifica se o Mario está acima do item
                mario_y = item.top - novo_tamanho_item[1]  # Faz o Mario subir no item
          # Se o Mario não está colidindo com nenhum item, faz os itens voltarem a se mover
    if not mario_colidindo:
        item_deve_mover = True

    tela.blit(mario, (mario_x, mario_y))
    # Atualize o quadro atual a cada 5 iterações
    if contador % 5 == 0:
        
        quadro_atual = (quadro_atual + 1) % 11

    # Incrementa o contador
    contador += 1


# Atualize os quadros da animação do Koopa
    if contador_koopa % trocar_quadro_koopa == 0:
        quadro_atual_koopa = (quadro_atual_koopa + 1) % len(quadros_koopa)

    contador_koopa += 1

    # Desenhe o Koopa na tela com o quadro atual da animação
    tela.blit(quadros_koopa[quadro_atual_koopa], (pos_x_koopa, pos_y_koopa))

    pygame.display.flip()


