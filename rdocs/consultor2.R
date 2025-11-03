source("rdocs/source/packages.R")


# ---------------------------------------------------------------------------- #

#        ______   _____  ________      ________ 
#      |  ____| / ____| |__   __| /\  |__   __|
#     | |__    | (___     | |   /  \    | |   
#    |  __|    \___ \    | |  / /\ \   | |   
#   | |____   ____) |   | |  /____ \  | |   
#  |______   |_____/   |_| /_/    \_\|_|   
#  
#         Consultoria estatística 
#

# ---------------------------------------------------------------------------- #
# ############################## README ###################################### #
# Consultor, favor utilizar este arquivo .R para realizar TODAS as análises
# alocadas a você neste projeto pelo gerente responsável, salvo instrução 
# explícita do gerente para mudança.
#
# Escreva seu código da forma mais clara e legível possível, eliminando códigos
# de teste depreciados, ou ao menos deixando como comentário. Dê preferência
# as funções dos pacotes contidos no Tidyverse para realizar suas análises.
# ---------------------------------------------------------------------------- #
source("packages.R") 


arquivo <- "relatorio_old_town_road.xlsx"

clientes <- read_excel(arquivo, sheet = "infos_clientes")

dados <- clientes %>%
  select(Sex, Age, Weight_lbs, Height_dm, Anual_Income_usd) %>%
  rename(
    sexo = Sex,
    idade = Age,
    peso_lbs = Weight_lbs,
    altura_dm = Height_dm,
    renda_usd = Anual_Income_usd
  ) %>%
  drop_na() %>%
  mutate(
    peso = as.numeric(peso_lbs) * 0.453592,    
    altura = as.numeric(altura_dm) * 10,       
    renda_brl = as.numeric(renda_usd) * 5.31   
  )

correlacao <- cor(dados$peso, dados$altura, use = "complete.obs", method = "pearson")

grafico2 <- ggplot(dados, aes(x = altura, y = peso)) +
  geom_point(color = "#A11D21", alpha = 0.7, size = 3) +
  geom_smooth(method = "lm", se = TRUE, color = "#A11D21", linetype = "dashed") +
  labs(
    title = "Relação entre Peso (kg) e Altura (cm) dos Clientes",
    subtitle = "Dispersão e linha de tendência linear",
    x = "Altura (cm)",
    y = "Peso (kg)"
  ) +
  theme_estat()

teste_cor <- cor.test(dados$peso, dados$altura, method = "pearson")

quadro_altura <- print_quadro_resumo(dados, altura, 
                                     title = "Medidas resumo da variável Altura (cm)",
                                     label = "quad:altura")

quadro_peso <- print_quadro_resumo(dados, peso, 
                                   title = "Medidas resumo da variável Peso (kg)",
                                   label = "quad:peso")


correlacao
teste_cor


