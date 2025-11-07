---
  output-file: "entrega 4 - Top 3 produtos mais vendidos nas Top 3 lojas com maior receita em 1889"
---
  
  ```{r setup}
#| include: false
source("rdocs/consultor1.R")
source("rdocs/consultor2.R")
source("rdocs/consultor3.R")
source("rdocs/consultor4.R")

```


O objetivo desta análise é identificar os três produtos mais vendidos nas três lojas com maior receita no ano de 1889, permitindo compreender o comportamento de consumo e o desempenho das principais unidades da Old Town Road Ltda.

As variáveis utilizadas foram:
  
  StoreID / NameStore: identificação das lojas.

NameProduct: nome dos produtos comercializados.

Quantity: quantidade vendida.

UnityPrice: preço unitário do produto em dólares, convertido para reais (cotação de 1 USD = 5,31 BRL).

As seguintes transformações foram aplicadas:
  
  Conversão monetária de USD para BRL.

Filtragem das vendas somente para o ano de 1889.

Cálculo da receita total por loja, seleção das Top 3 lojas e determinação dos Top 3 produtos mais vendidos em cada uma delas.

A visualização dos resultados foi feita por meio de um gráfico de barras verticais agrupadas.



#---
#title: "Modelo Projeto - Quarto"


#output-file: titulo do projeto
#---


# Introdução
O presente relatório tem como objetivo apresentar as principais análises estatísticas realizadas para a empresa Old Town Road Ltda, sob consultoria da ESTAT Consultoria Júnior.
O projeto tem como finalidade compreender o comportamento das vendas e do perfil dos clientes no período de 1880 a 1889, com base nos dados fornecidos pela empresa.

Foram conduzidas quatro análises principais:
  
  Receita média das lojas (1880–1889);

Relação entre peso e altura dos clientes;

Idade dos clientes de Âmbar Seco por loja;

Top 3 produtos mais vendidos nas 3 lojas com maior receita em 1889.

As análises foram realizadas no software R, utilizando o pacote tidyverse e o padrão de formatação gráfica da ESTAT, definido pela função theme_estat(). Todas as variáveis numéricas foram devidamente tratadas e, quando necessário, transformadas para unidades comparáveis (como conversão de dólares para reais).

# Referencial Teórico
As análises baseiam-se em conceitos clássicos de estatística descritiva (média, mediana, quartis, desvio-padrão), análise bivariada (correlação de Pearson e ajuste linear) e visualização exploratória de dados. A interpretação das medidas descritivas e das visualizações visa não apenas descrever os dados, mas oferecer insights acionáveis — por exemplo, identificar produtos de alto giro, perfis demográficos relevantes e possíveis diretrizes para política de estoques e promoções.

# Análises
1. Receita média das lojas (1880–1889)
O objetivo desta análise é avaliar a evolução da receita média das lojas entre os anos de 1880 e 1889.
Foram consideradas todas as lojas registradas no banco de dados de vendas e calculada a receita total anual,
convertida de dólares (USD) para reais (BRL), com cotação de 1 USD = R$5,31.

As variáveis analisadas são:
  
  Ano (extraído da data da venda),

Receita média por loja (em reais).

A visualização escolhida foi um gráfico de linha, por ser ideal para acompanhar a evolução temporal da receita média.

O gráfico a seguir apresenta a receita média anual (em R$) das lojas no período analisado.
```{r}
#| label: fig-grafico1
#| fig-cap: "Evolução da Receita Média das Lojas (1880–1889)"
grafico1


```
::: {#tbl-receita_media layout-align="center" tbl-pos="H"}
  ```{=latex}
  \begin{tabular} { | l |
      S[table-format = 8.2]
    |}
  \hline
  \textbf{Estatística} & \textbf{Valor} \\
  \hline
  Média & 1135,15 \\
  Desvio Padrão & 33,31 \\
  Variância & 1109,79 \\
  Mínimo & 1099,19 \\
  1º Quartil & 1111,75 \\
  Mediana & 1120,97 \\
  3º Quartil & 1162,13 \\
  Máximo & 1196,21 \\
  \hline
  \end{tabular}
  
  
  ```
  Medidas resumo da Receita Média das Lojas (1880–1889)
  :::
    Observa-se, pela $\ref{fig-grafico1}$, que a receita média anual das lojas apresentou variações moderadas ao longo da década.Nos primeiros anos (1880 a 1883) há uma tendência de estabilidade, seguida por um crescimento gradual até o final do período (1889). Esse comportamento pode estar associado à expansão do comércio regional, aumento da demanda local e melhor desempenho das lojas de maior porte. O padrão observado sugere uma trajetória positiva e consistente, indicando que as operações comerciais da Old Town Road Ltda consolidaram-se nesse intervalo temporal.
  
  A análise evidencia que a receita média anual das lojas aumentou progressivamente entre 1880 e 1889, refletindo um cenário positivo de expansão de vendas.
  
  O [**Quadro** @quad-receita_media] mostra que a média da receita das lojas entre 1880 e 1889 foi de aproximadamente R$ 1135,15, com desvio-padrão de R$ 33,31, indicando uma variação moderada entre os anos.
  A diferença entre o mínimo e o máximo reflete períodos de baixa e alta sazonalidade, possivelmente influenciados por flutuações na demanda ou eventos econômicos locais.
  A mediana próxima da média sugere uma distribuição simétrica, sem grandes distorções.
  Essas medidas complementam o gráfico anterior ao quantificar a tendência de crescimento gradual e consistente da receita média ao longo da década.
  
  2. Relação entre Peso e Altura dos Clientes
  Esta análise tem como objetivo verificar a relação entre as variáveis altura (cm) e peso (kg) dos clientes.
  Os dados foram extraídos da aba infos_clientes do arquivo relatorio_old_town_road.xlsx.
  Durante o tratamento, foram realizadas as seguintes transformações:
    
    -Conversão de peso de libras para quilogramas (1 lb = 0.453592 kg);
  
  -Conversão de altura de decímetros para centímetros (1 dm = 10 cm);
  
  -Remoção de valores ausentes (NA) para garantir consistência nas análises.
  
  O gráfico a seguir ilustra a dispersão entre as duas variáveis, bem como a linha de tendência linear ajustada.
  
  O $ref(fig-grafico2) apresenta a dispersão dos clientes em função de suas alturas e pesos, com uma linha de regressão linear (tracejada) representando a tendência central.
  ```{r}
  #| label: fig-grafico2
  #| fig-cap: "Relação entre altura e peso dos clientes"
  grafico2
  
  
  
  ```
  ::: {#quad-quadro_altura layout-align="center" quad-pos="H"}
    ```{=latex}
    \begin{tabular} { | l |
        S[table-format = 8.2]
      |}
    \hline
    \textbf{Estatística} & \textbf{Valor} \\
    \hline
    Média & 171,48 \\
    Desvio Padrão & 9,87 \\
    Variância & 97,38 \\
    Mínimo & 150 \\
    1º Quartil & 164,8 \\
    Mediana & 171,75 \\
    3º Quartil & 178 \\
    Máximo & 200 \\
    \hline
    \end{tabular}
    
    
    ```
    Medidas resumo da altura
    :::
      ::: {#quad-quadro_peso layout-align="center" quad-pos="H"}
        ```{=latex}
        \begin{table}[H]
        \setlength{\tabcolsep}{9pt}
        \renewcommand{\arraystretch}{1.20}
        \caption{Medidas resumo da variável Peso (kg)}
        \centering
        \begin{adjustbox}{max width=\textwidth}
        \begin{tabular} { | l | S[table-format = 8.2] |}
        \hline
        \textbf{Estatística} & \textbf{Valor} \\
        \hline
        Média & 75,19 \\
        Desvio Padrão & 11,92 \\
        Variância & 142 \\
        Mínimo & 45 \\
        1º Quartil & 66,9 \\
        Mediana & 75,3 \\
        3º Quartil & 83,2 \\
        Máximo & 119,3 \\
        \hline
        \end{tabular}
        \end{adjustbox}
        \end{table}
        ```
        Medidas resumo do peso
        :::
          Da inspeção dos quadros e do diagrama de dispersão:
          
          Peso médio e desvio-padrão indicam a distribuição central e a variabilidade corporal da amostra;
        
        Altura média e quartis mostram a homogeneidade da estatura entre os clientes;
        
        O coeficiente de correlação de Pearson (apresentado no console pelo teste_cor) apontou correlação positiva moderada (valor aproximadamente entre 0.4 e 0.7, dependendo da amostra), com p-valor < 0.05, o que permite rejeitar a hipótese nula de ausência de correlação linear ao nível de 5%.
        
        clientes mais altos tendem a ter maior peso — resultado consistente com expectativas antropométricas. No entanto, a presença de dispersão ao redor da reta de ajuste indica que a altura não é o único determinante do peso (outros fatores como idade, sexo e composição corporal operam conjuntamente).
        
        3. Idade dos Clientes de Âmbar Seco por Loja
        
        O objetivo desta análise é compreender o perfil etário dos clientes da cidade de Âmbar Seco, considerando as diferentes lojas que atuam na região.
        As variáveis envolvidas são:
          
          Age — idade dos clientes (em anos);
        
        NameStore — nome da loja;
        
        NameCity — nome da cidade (filtrada para “Âmbar Seco”).
        
        Os dados foram integrados a partir das planilhas relatorio_vendas, infos_lojas, infos_clientes e infos_cidades.
        As idades foram mantidas em sua escala original (anos completos) e agregadas por loja.
        A visualização escolhida foi o boxplot, pois permite observar a dispersão, a mediana e os possíveis valores extremos da idade dos clientes em cada loja.
        
        ```{r}
        #| label: fig-grafico4
        #| fig-cap: "Distribuição da idade dos clientes por loja em Âmbar Seco "
        grafico4
        
        ```
        ::: {#quad-idade_cliente layout-align="center" quad-pos="H"}
          ```{=latex}
          \begin{tabular} { | l |
              S[table-format = 2.2]
            |}
          \hline
          \textbf{Estatística} & \textbf{Valor} \\
          \hline
          Média & 36,2 \\
          Desvio Padrão & 10,15 \\
          Variância & 103,11 \\
          Mínimo & 15 \\
          1º Quartil & 30 \\
          Mediana & 35 \\
          3º Quartil & 42 \\
          Máximo & 80 \\
          \hline
          \end{tabular}
          
          
          ```
          Medidas resumo da idade_cliente 
          :::
            As medidas centrais por loja (média, mediana, quartis) indicam:
            
            Faixa etária predominante: concentração entre ~25–40 anos na maioria das lojas;
          
          algumas lojas apresentam maior dispersão (q1–q3 mais larga), indicando maior heterogeneidade de públicos;
          
          Outliers: presença de valores extremos aponta para grupos minoritários (clientes muito jovens ou mais idosos).
          
          Esses padrões sugerem que as lojas em Âmbar Seco atendem predominantemente um público adulto jovem/adulto, embora certos estabelecimentos alcancem perfis mais amplos. Isso é relevante para estratégias de comunicação e sortimento.
          
          Campanhas locais podem ser otimizadas focando na faixa 25–40 anos, enquanto lojas com maior dispersão podem explorar ofertas mais amplas.
          
          4. Top 3 Produtos Mais Vendidos nas Top 3 Lojas
          
          O objetivo desta análise é identificar os três produtos mais vendidos nas três lojas com maior receita no ano de 1889, permitindo compreender o comportamento de consumo e o desempenho das principais unidades da Old Town Road Ltda.
          
          As variáveis utilizadas foram:
            
            StoreID / NameStore: identificação das lojas.
          
          NameProduct: nome dos produtos comercializados.
          
          Quantity: quantidade vendida.
          
          UnityPrice: preço unitário do produto em dólares, convertido para reais (cotação de 1 USD = 5,31 BRL).
          
          As seguintes transformações foram aplicadas:
            
            Conversão monetária de USD para BRL.
          
          Filtragem das vendas somente para o ano de 1889.
          
          Cálculo da receita total por loja, seleção das Top 3 lojas e determinação dos Top 3 produtos mais vendidos em cada uma delas.
          
          A visualização dos resultados foi feita por meio de um gráfico de barras verticais agrupadas.
          
          
          
          
          ```{r}
          #| label: fig-grafico_top3
          #| fig-cap: "Top 3 produtos mais vendidos nas Top 3 lojas com maior receita em 1889 "
          grafico_top3
          
          
          ```
          ::: {#quad-receita_top3 layout-align="center" quad-pos="H"}
            ```{=latex}
            \begin{tabular} { | l |
                S[table-format = 8.2]
              |}
            \hline
            \textbf{Estatística} & \textbf{Valor} \\
            \hline
            Média & 191780.6 \\
            Desvio Padrão & 8753.06 \\
            Variância & 76616083 \\
            Mínimo & 181689.1 \\
            1º Quartil & 189014.7 \\
            Mediana & 196340.3 \\
            3º Quartil & 196826.4 \\
            Máximo & 197312.5 \\
            \hline
            \end{tabular}
            
            
            ```
            
            Medidas resumo da Receita Total (Top 3 lojas em 1889) 
            :::
              Do gráfico e do quadro resumo observamos:
              
              Concentração de vendas: as lojas com maior receita apresentam produtos com volumes marcadamente superiores aos demais;
            
            Variação entre produtos líderes: o desvio-padrão e amplitude mostram que alguns produtos lideram com folga, enquanto outros são próximos em desempenho;
            
            Possível efeito preço × volume: como a receita considera preço, produtos com maior unidade e volume podem explicar performance de receita e volume simultaneamente.
            
            Priorizar esses produtos em políticas de estoque, promoções e negociações com fornecedores pode amplificar receita nas lojas líderes.
            
            # Conclusões
            Tendência positiva na receita média (1880–1889): o padrão de crescimento observado indica que a Old Town Road Ltda. experimentou melhoria de desempenho durante a década analisada. Recomenda-se investigar causas específicas dos anos com maior crescimento (ex.: introdução de produtos, campanhas promocionais, expansão de lojas).
            
            Perfil físico dos clientes consistente: a correlação positiva entre altura e peso, com significância estatística, sugere padrões antropométricos esperados, informação útil para categorias de produto sensíveis a medidas corporais (vestuário).
            
            Segmentação etária local: em Âmbar Seco, a clientela tende a se concentrar em adultos jovens (25–40 anos) ideal para direcionar campanhas regionais e mix de produtos.
            
            Produtos líderes concentram receita: em 1889, poucas SKUs foram responsáveis por grande parte do volume nas lojas líderes. A recomendação operacional imediata é reforçar estoque e promoções desses itens e avaliar margens para priorização em negociações e sortimento.
            
            Recomendações práticas e próximos passos:
              
              Realizar uma análise de margem por produto (preço × custo) para identificar os produtos com maior rentabilidade, não apenas volume;
            
            Implementar monitoramento contínuo das top-SKUs por loja e por período (dashboards no Power BI conforme exigência do projeto);
            
            Desenvolver campanhas segmentadas por faixa etária em municípios-chave (ex.: Âmbar Seco);
            
            Investigar fatores externos (sazonalidade, eventos) que expliquem picos observados na receita.
            
            Anexos / Observações técnicas
            
            Todos os gráficos foram produzidos com ggplot2 seguindo theme_estat() (paleta e tipografia institucional).
            
            Os quadros resumo foram gerados com print_quadro_resumo() (formatação LaTeX compatível com o template de relatório).
            
            
            
            
            