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

arquivo <- "relatorio_old_town_road.xlsx"

vendas    <- read_excel(arquivo, sheet = "relatorio_vendas")
infos_vendas <- read_excel(arquivo, sheet = "infos_vendas")
produtos  <- read_excel(arquivo, sheet = "infos_produtos")
lojas     <- read_excel(arquivo, sheet = "infos_lojas")


dados_completos <- vendas %>%
  left_join(infos_vendas, by = c("SaleID" = "Sal3ID")) %>%
  left_join(produtos, by = c("ItemID" = "Ite3ID")) %>%
  left_join(lojas, by = c("StoreID" = "Stor3ID")) %>%
  mutate(
    Ano = as.numeric(format(as.Date(Date), "%Y")),
    Receita_USD = Quantity * UnityPrice,
    Receita_BRL = Receita_USD * 5.31
  )


dados_1889 <- dados_completos %>% filter(Ano == 1889)


top3_lojas <- dados_1889 %>%
  group_by(NameStore) %>%
  summarise(Receita_Total = sum(Receita_BRL, na.rm = TRUE)) %>%
  arrange(desc(Receita_Total)) %>%
  slice_head(n = 3)


top3_produtos <- dados_1889 %>%
  filter(NameStore %in% top3_lojas$NameStore) %>%
  group_by(NameStore, NameProduct) %>%
  summarise(Quantidade_Total = sum(Quantity, na.rm = TRUE)) %>%
  arrange(NameStore, desc(Quantidade_Total)) %>%
  group_by(NameStore) %>%
  slice_head(n = 3) %>%
  ungroup()


grafico_top3 <- ggplot(top3_produtos, aes(x = reorder(NameProduct, Quantidade_Total), 
                                          y = Quantidade_Total, 
                                          fill = NameStore)) +
  geom_col(show.legend = TRUE, width = 0.7) +
  coord_flip() +
  labs(
    title = "Top 3 produtos mais vendidos nas Top 3 lojas (1889)",
    subtitle = "Análise da Old Town Road Ltda. — Projeto Fantasma",
    x = "Produto",
    y = "Quantidade vendida"
  ) +
  theme_estat() +
  theme(legend.title = element_blank())

grafico_top3


print_quadro_resumo(
  data = top3_lojas,
  var_name = Receita_Total,
  title = "Medidas resumo da Receita Total (Top 3 lojas em 1889)",
  label = "quad:receita_top3"
)