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

if("CityID" %in% names(cidades)) cidades$CityID <- as.character(cidades$CityID)
if("CityID" %in% names(lojas)) lojas$CityID <- as.character(lojas$CityID)
if("StoreID" %in% names(vendas)) vendas$StoreID <- as.character(vendas$StoreID)
if("ClientID" %in% names(vendas)) vendas$ClientID <- as.character(vendas$ClientID)
if("ClientID" %in% names(clientes)) clientes$ClientID <- as.character(clientes$ClientID)

lojas$StoreID <- as.character(lojas$StoreID)
vendas$StoreID <- as.character(vendas$StoreID)
lojas_amber <- lojas %>%
  left_join(cidades, by = "CityID") %>%
  filter(NameCity == "Âmbar Seco")

clientes_amber <- vendas %>%
  filter(StoreID %in% lojas_amber$StoreID) %>%
  left_join(clientes, by = "ClientID") %>%
  left_join(lojas_amber, by = "StoreID") %>%
  select(NameStore, Age) %>%
  drop_na()

clientes_amber <- vendas %>%
  filter(StoreID %in% lojas_amber$StoreID) %>%
  left_join(clientes, by = "ClientID") %>%
  left_join(lojas_amber, by = "StoreID") %>%
  select(NameStore, Age) %>%
  drop_na()

glimpse(clientes_amber)

grafico4 <- ggplot(clientes_amber, aes(x = NameStore, y = Age)) +
  geom_boxplot(fill = "#A11D21", alpha = 0.8) +
  stat_summary(fun = mean, geom = "point", size = 3, color = "black") +
  labs(
    title = "Distribuição da Idade dos Clientes por Loja — Âmbar Seco",
    x = "Loja",
    y = "Idade (anos)"
  ) +
  theme_minimal()

grafico4

medidas_idade <- clientes_amber %>%
  group_by(NameStore) %>%
  summarise(
    media = round(mean(Age), 2),
    mediana = median(Age),
    min = min(Age),
    max = max(Age),
    sd = round(sd(Age), 2),
    q1 = quantile(Age, 0.25),
    q3 = quantile(Age, 0.75),
    n = n(),
    .groups = "drop"
  )

medidas_idade