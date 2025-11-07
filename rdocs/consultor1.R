
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

vendas <- read_excel(arquivo, sheet = "relatorio_vendas")
lojas  <- read_excel(arquivo, sheet = "infos_lojas")


if("Stor3ID" %in% names(lojas)) lojas <- lojas %>% rename(StoreID = Stor3ID)


dados_completos <- vendas %>%
  left_join(lojas, by = "StoreID") %>%
  mutate(
    Ano = as.numeric(format(as.Date(Date), "%Y")),
    Receita_BRL = Quantity * 5.31  # usa Quantity como proxy, sem preço
  )


dados_periodo <- dados_completos %>%
  filter(Ano >= 1880 & Ano <= 1889)


receita_media_ano <- dados_periodo %>%
  group_by(Ano) %>%
  summarise(Receita_Media_BRL = mean(Receita_BRL, na.rm = TRUE))

grafico1 <- ggplot(receita_media_ano, aes(x = Ano, y = Receita_Media_BRL, group = 1)) +
  geom_line(color = "#A11D21", size = 1.2) +
  geom_point(color = "#A11D21", size = 3) +
  labs(
    title = "Receita média das lojas (1880–1889)",
    subtitle = "Valores convertidos para reais (R$)",
    x = "Ano",
    y = "Receita média por loja (R$)"
  ) +
  theme_estat()
grafico1

receita_media_ano <- print_quadro_resumo(
  data = receita_media_ano,
  var_name = Receita_Media_BRL,
  title = "Medidas resumo da Receita Média Anual (1880–1889)",
)



#grafico1 <- ggplot(receita_media_ano, aes(x = Ano, y = Receita_Media)) +
#geom_col(fill = cores_estat[1], width = 0.6) +
#geom_text(aes(label = scales::comma(Receita_Media, big.mark = ".", decimal.mark = ",")),
#vjust = -0.5, size = 3) +
#labs(
#title = "Receita média anual das lojas (1880–1889)",
#subtitle = "Valores convertidos para reais (R$)",
#x = "Ano",
#y = "Receita média (R$)"
#) +
#theme_estat()


#print_quadro_resumo(receita_media, Receita_Media_BRL,
#title = "Medidas resumo da Receita Média das Lojas (1880–1889)",
#label = "quad:receita_media_ano")

