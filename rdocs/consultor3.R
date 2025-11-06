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

arquivo <- "relatorio_old_town_road.xlsx"


cidades <- read_excel(arquivo, sheet = "infos_cidades")
lojas    <- read_excel(arquivo, sheet = "infos_lojas")
clientes <- read_excel(arquivo, sheet = "infos_clientes")
vendas   <- read_excel(arquivo, sheet = "relatorio_vendas")


if(!"CityID" %in% names(cidades) & "C1tyID" %in% names(cidades)) {
  cidades <- cidades %>% rename(CityID = C1tyID)
}

if(!"StoreID" %in% names(lojas) & "Stor3ID" %in% names(lojas)) {
  lojas <- lojas %>% rename(StoreID = Stor3ID)
}

if(!"ClientID" %in% names(clientes) & "Cli3ntID" %in% names(clientes)) {
  clientes <- clientes %>% rename(ClientID = Cli3ntID)
}


cidades$CityID  <- as.character(cidades$CityID)
lojas$CityID    <- as.character(lojas$CityID)
lojas$StoreID   <- as.character(lojas$StoreID)
vendas$StoreID  <- as.character(vendas$StoreID)
vendas$ClientID <- as.character(vendas$ClientID)
clientes$ClientID <- as.character(clientes$ClientID)


dados_ambar <- lojas %>%
  left_join(cidades, by = "CityID") %>%
  filter(NameCity == "Âmbar Seco") %>%
  left_join(vendas, by = "StoreID") %>%
  left_join(clientes, by = "ClientID") %>%
  select(NameCity, NameStore, Age) %>%
  drop_na()


glimpse(dados_ambar)


grafico4 <- ggplot(dados_ambar, aes(x = NameStore, y = Age)) +
  geom_boxplot(fill = "#A11D21", alpha = 0.8) +
  stat_summary(fun = mean, geom = "point", size = 3, color = "black") +
  labs(
    title = "Distribuição da Idade dos Clientes por Loja — Âmbar Seco",
    x = "Loja",
    y = "Idade (anos)"
  ) +
  theme_estat()

grafico4


idade_cliente <- print_quadro_resumo(
  dados_ambar,
  Age,
  title = "Medidas resumo da idade dos clientes em Âmbar Seco",
  label = "quad:idade_ambar"
)