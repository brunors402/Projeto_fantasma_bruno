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
# ----------------------------------------------------
# ENTREGA 3 — Idade dos clientes de Âmbar Seco por Loja
# Projeto Fantasma - Old Town Road Ltda
# ----------------------------------------------------


pacman::p_load(tidyverse, readxl)


arquivo <- "dados/relatorio_old_town_road.xlsx" 

clientes <- read_excel(arquivo, sheet = "infos_clientes")
vendas   <- read_excel(arquivo, sheet = "relatorio_vendas")
lojas    <- read_excel(arquivo, sheet = "infos_lojas")
cidades  <- read_excel(arquivo, sheet = "infos_cidades")


#Filtrar apenas cidade de Âmbar Seco

nome_cidade <- "Âmbar Seco"

lojas_amber <- lojas %>%
  left_join(cidades, by = "CityID") %>%
  filter(NameCity == nome_cidade)


#Obter os clientes que compraram nessas lojas

clientes_amber <- vendas %>%
  filter(StoreID %in% lojas_amber$StoreID) %>%
  left_join(clientes, by = c("ClientID" = "Cli3ntID")) %>%
  left_join(lojas_amber, by = "StoreID") %>%
  select(StoreName, Age) %>%
  drop_na()


glimpse(clientes_amber)

#Boxplot — Distribuição da idade por loja

grafico4 <- ggplot(clientes_amber, aes(x = StoreName, y = Age)) +
  geom_boxplot(fill = "#A11D21", alpha = 0.8) +
  stat_summary(fun = "mean", geom = "point", size = 3, color = "black") +
  labs(
    title = "Distribuição da Idade dos Clientes por Loja — Âmbar Seco",
    x = "Loja",
    y = "Idade (anos)"
  ) +
  theme_minimal()

grafico_idade


# Medidas resumo por loja

medidas_idade <- clientes_amber %>%
  group_by(StoreName) %>%
  summarise(
    media = round(mean(Age), 2),
    mediana = median(Age),
    min = min(Age),
    max = max(Age),
    sd = round(sd(Age), 2),
    q1 = quantile(Age, 0.25),
    q3 = quantile(Age, 0.75),
    n = n()
  )

medidas_idade
