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


##Análise 1

##código pra limpar o banco




arquivo <- "relatorio_old_town_road.xlsx" 
vendas <- read_excel(arquivo, sheet = "relatorio_vendas")
lojas  <- read_excel(arquivo, sheet = "infos_lojas")

lojas <- lojas %>% rename(StoreID = Stor3ID)



vendas <- vendas %>%
  mutate(Ano = lubridate::year(Date)) %>%
  filter(Ano >= 1880 & Ano <= 1889) %>%
  left_join(lojas, by = "StoreID")


receita_media <- vendas %>%
  mutate(Receita_BRL = Quantity * 5.31) %>%  
  group_by(Ano) %>%
  summarise(Receita_Media_BRL = mean(Receita_BRL, na.rm = TRUE))


print(receita_media)


grafico1 <- ggplot(receita_media, aes(x = Ano, y = Receita_Media_BRL, group = 1)) +
  geom_line(color = "#A11D21", size = 1.2) +
  geom_point(color = "#003366", size = 3) +
  labs(
    title = "Receita média das lojas (1880–1889)",
    subtitle = "Valores convertidos para reais (R$)",
    x = "Ano",
    y = "Receita média por loja (R$)"
  ) +
  theme_estat()


print_quadro_resumo(receita_media, Receita_Media_BRL,
                    title = "Medidas resumo da Receita Média das Lojas (1880–1889)",
                    label = "quad:receita_media")
