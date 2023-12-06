import pygame
import random
import time

# Inicializa o Pygame
pygame.init()

# Configurações da tela
largura, altura = 900, 640
tela = pygame.display.set_mode((largura, altura))

# Carregando a imagem de fundo
fundo_img = pygame.image.load("C:/Users/igork/Desktop/automatização/jogos/ludo/tabuleiro.png")

# Redimensionando a imagem
fundo_img_redimensionado = pygame.transform.scale(fundo_img, (largura - 40, altura - 60))

# Preenche a tela com branco para criar a borda
tela.fill((255, 255, 255))

# Variável para armazenar o número do dado
dado = 0

# Variável para controlar o tempo de rolagem do dado
rolando = False
tempo_inicio = 0

# Cores para o fundo do dado
cores = [(255, 0, 0), (0, 255, 0), (255, 255, 0), (0, 0, 255)]  # vermelho, verde, amarelo, azul
cor_atual = random.randint(0, 3)



# Cores dos peões
cor_peao_vermelho = (255, 0, 0)
cor_peao_verde = (0, 255, 0)
cor_peao_amarelo = (255, 255, 0)
cor_peao_azul = (0, 0, 255)



# Posições dos peões (exemplo) larguda  -- altura
peao_vermelho_1 = (150, 500)
peao_vermelho_2 = (250, 500)
peao_vermelho_3 = (150, 430)
peao_vermelho_4 = (250, 430)

peao_verde_1 = (150, 80)
peao_verde_2 = (250, 80)
peao_verde_3 = (150, 150)
peao_verde_4 = (250, 150)

peao_amarelo_1 = (650, 80)
peao_amarelo_2 = (750, 80)
peao_amarelo_3 = (750, 150)
peao_amarelo_4 = (650, 150)

peao_azul_1 = (650, 500)
peao_azul_2 = (750, 500)
peao_azul_3 = (750, 430)
peao_azul_4 = (650, 430)






# Loop principal do jogo
rodando = True
while rodando:


    for evento in pygame.event.get():
        if evento.type == pygame.QUIT:
            rodando = False
        elif evento.type == pygame.MOUSEBUTTONDOWN:
            # Verifica se o clique do mouse foi na área do dado
            x, y = pygame.mouse.get_pos()
            if largura - 100 < x < largura - 20 and altura - 60 < y < altura - 20:
                # Inicia a rolagem do dado
                rolando = True
                tempo_inicio = time.time()

    # Desenha a imagem de fundo no centro da tela
    tela.blit(fundo_img_redimensionado, (20, 0))


        # Dentro do loop principal, desenhe os peões na tela
    pygame.draw.circle(tela, cor_peao_vermelho, peao_vermelho_1, 20)
    pygame.draw.circle(tela, cor_peao_vermelho, peao_vermelho_2, 20)
    pygame.draw.circle(tela, cor_peao_vermelho, peao_vermelho_3, 20)
    pygame.draw.circle(tela, cor_peao_vermelho, peao_vermelho_4, 20)

    pygame.draw.circle(tela, cor_peao_verde, peao_verde_1, 20)
    
   
    pygame.draw.circle(tela, cor_peao_verde, peao_verde_2, 20)
    pygame.draw.circle(tela, cor_peao_verde, peao_verde_3, 20)
    pygame.draw.circle(tela, cor_peao_verde, peao_verde_4, 20)

    pygame.draw.circle(tela, cor_peao_amarelo, peao_amarelo_1, 20)
    pygame.draw.circle(tela, cor_peao_amarelo, peao_amarelo_2, 20)
    pygame.draw.circle(tela, cor_peao_amarelo, peao_amarelo_3, 20)
    pygame.draw.circle(tela, cor_peao_amarelo, peao_amarelo_4, 20)

    pygame.draw.circle(tela, cor_peao_azul, peao_azul_1, 20)
    pygame.draw.circle(tela, cor_peao_azul, peao_azul_2, 20)
    pygame.draw.circle(tela, cor_peao_azul, peao_azul_3, 20)
    pygame.draw.circle(tela, cor_peao_azul, peao_azul_4, 20)



    # Desenha o dado
    pygame.draw.rect(tela, cores[cor_atual], pygame.Rect(largura - 100, altura - 60, 80, 40))
    fonte = pygame.font.Font(None, 36)
    if rolando and time.time() - tempo_inicio < 1:
        # Durante a rolagem, mostra um número aleatório
        dado = random.randint(1, 6)
 
    elif rolando and time.time() - tempo_inicio > 4:
        # Após 4 segundos, muda a cor do fundo do dado
        cor_atual = (cor_atual + 1) % len(cores)
        rolando = False
    texto = fonte.render(str(dado), 1, (000, 000, 000))
    tela.blit(texto, (largura - 80, altura - 50))

    # Atualiza a tela
    pygame.display.flip()

# Finaliza o Pygame
pygame.quit()
