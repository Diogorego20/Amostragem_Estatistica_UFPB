# Análise Inferencial - Agricultura Familiar PB (R)
# Autor: Diogo Rego (modelo)
# Descrição:
#   - Realiza análise descritiva, estimação por IC e testes de hipóteses
#   - Utiliza dados do frame integrado gerado pelo ETL
#   - Gera relatório de análise em Markdown

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(stringr)
  library(ggplot2)
  library(knitr)
})

# ============================================================================
# 1. CARREGAR DADOS
# ============================================================================

# Substitua pelo caminho do seu frame integrado
dados <- read_csv("dados/processed/frame_integrado.csv", 
                  locale = locale(encoding = "UTF-8"),
                  show_col_types = FALSE)

cat("✓ Dados carregados:", nrow(dados), "observações\n")

# ============================================================================
# 2. ANÁLISE DESCRITIVA
# ============================================================================

cat("\n=== ANÁLISE DESCRITIVA ===\n")

# Estatísticas para variáveis numéricas
descritiva_numerica <- dados %>%
  summarise(
    n = n(),
    renda_media = mean(renda_familiar_mensal, na.rm = TRUE),
    renda_mediana = median(renda_familiar_mensal, na.rm = TRUE),
    renda_dp = sd(renda_familiar_mensal, na.rm = TRUE),
    area_media = mean(area_plantada_ha, na.rm = TRUE),
    area_mediana = median(area_plantada_ha, na.rm = TRUE)
  )

print(descritiva_numerica)

# Tabela de frequências para variáveis categóricas
freq_credito <- dados %>%
  count(usa_credito) %>%
  mutate(
    proporcao = n / sum(n),
    percentual = scales::percent(proporcao, accuracy = 0.1)
  )

cat("\nDistribuição de acesso a crédito:\n")
print(freq_credito)

# ============================================================================
# 3. ESTIMAÇÃO POR INTERVALO DE CONFIANÇA
# ============================================================================

cat("\n=== ESTIMAÇÃO POR INTERVALO DE CONFIANÇA ===\n")

# Função para calcular IC de proporção (população finita)
ic_proporcao <- function(x, N = NULL, nivel_confianca = 0.95) {
  # x: vetor binário (0/1, TRUE/FALSE, ou similar)
  # N: tamanho da população (se conhecido)
  
  n <- length(x[!is.na(x)])
  p_hat <- mean(x, na.rm = TRUE)
  
  z <- qnorm((1 + nivel_confianca) / 2)
  
  # Erro padrão
  ep <- sqrt(p_hat * (1 - p_hat) / n)
  
  # Correção para população finita (se N fornecido)
  if (!is.null(N) && N > 0) {
    fpc <- sqrt((N - n) / (N - 1))  # Fator de correção
    ep <- ep * fpc
  }
  
  # Margem de erro
  me <- z * ep
  
  # Intervalo
  ic_inf <- max(0, p_hat - me)
  ic_sup <- min(1, p_hat + me)
  
  return(list(
    estimativa = p_hat,
    ic_inferior = ic_inf,
    ic_superior = ic_sup,
    margem_erro = me,
    nivel_confianca = nivel_confianca
  ))
}

# Exemplo: IC para proporção de agricultores com acesso a crédito
# Assumindo população de 100.000 agricultores familiares na PB
usa_credito_binario <- as.numeric(dados$usa_credito == "Sim")
ic_credito <- ic_proporcao(usa_credito_binario, N = 100000, nivel_confianca = 0.95)

cat("\nIntervalo de Confiança (95%) para Acesso a Crédito:\n")
cat(sprintf("  Estimativa pontual: %.2f%%\n", ic_credito$estimativa * 100))
cat(sprintf("  IC: [%.2f%%, %.2f%%]\n", 
            ic_credito$ic_inferior * 100, 
            ic_credito$ic_superior * 100))
cat(sprintf("  Margem de erro: ±%.2f%%\n", ic_credito$margem_erro * 100))

# Função para IC de média (população finita)
ic_media <- function(x, N = NULL, nivel_confianca = 0.95) {
  n <- length(x[!is.na(x)])
  media <- mean(x, na.rm = TRUE)
  dp <- sd(x, na.rm = TRUE)
  
  # Graus de liberdade
  gl <- n - 1
  t_critico <- qt((1 + nivel_confianca) / 2, gl)
  
  # Erro padrão
  ep <- dp / sqrt(n)
  
  # Correção para população finita
  if (!is.null(N) && N > 0) {
    fpc <- sqrt((N - n) / (N - 1))
    ep <- ep * fpc
  }
  
  # Margem de erro
  me <- t_critico * ep
  
  # Intervalo
  ic_inf <- media - me
  ic_sup <- media + me
  
  return(list(
    estimativa = media,
    ic_inferior = ic_inf,
    ic_superior = ic_sup,
    margem_erro = me,
    nivel_confianca = nivel_confianca
  ))
}

# Exemplo: IC para renda média
ic_renda <- ic_media(dados$renda_familiar_mensal, N = 100000, nivel_confianca = 0.95)

cat("\nIntervalo de Confiança (95%) para Renda Familiar Mensal:\n")
cat(sprintf("  Estimativa pontual: R$ %.2f\n", ic_renda$estimativa))
cat(sprintf("  IC: [R$ %.2f, R$ %.2f]\n", 
            ic_renda$ic_inferior, 
            ic_renda$ic_superior))

# ============================================================================
# 4. TESTES DE HIPÓTESES
# ============================================================================

cat("\n=== TESTES DE HIPÓTESES ===\n")

# Exemplo 1: Teste T para comparar renda entre duas regiões
# H0: média_regiao_A = média_regiao_B
# H1: média_regiao_A ≠ média_regiao_B

# Filtrar dados por região (exemplo)
regiao_A <- dados %>% filter(regiao == "Cariri") %>% pull(renda_familiar_mensal)
regiao_B <- dados %>% filter(regiao == "Litoral") %>% pull(renda_familiar_mensal)

teste_t <- t.test(regiao_A, regiao_B, var.equal = FALSE)

cat("\nTeste T: Comparação de Renda entre Cariri e Litoral\n")
cat(sprintf("  Estatística t: %.3f\n", teste_t$statistic))
cat(sprintf("  p-valor: %.4f\n", teste_t$p.value))
cat(sprintf("  IC 95%% da diferença: [%.2f, %.2f]\n", 
            teste_t$conf.int[1], 
            teste_t$conf.int[2]))

if (teste_t$p.value < 0.05) {
  cat("  Conclusão: Rejeita-se H0. Há diferença significativa entre as rendas.\n")
} else {
  cat("  Conclusão: Não se rejeita H0. Não há evidência de diferença significativa.\n")
}

# Exemplo 2: Teste de proporções (Qui-quadrado)
# H0: A proporção de uso de crédito é igual entre as regiões
# H1: A proporção de uso de crédito difere entre as regiões

tabela_contingencia <- table(dados$regiao, dados$usa_credito)
teste_qui <- chisq.test(tabela_contingencia)

cat("\nTeste Qui-quadrado: Uso de Crédito por Região\n")
cat(sprintf("  Estatística χ²: %.3f\n", teste_qui$statistic))
cat(sprintf("  p-valor: %.4f\n", teste_qui$p.value))

if (teste_qui$p.value < 0.05) {
  cat("  Conclusão: Rejeita-se H0. O uso de crédito difere entre regiões.\n")
} else {
  cat("  Conclusão: Não se rejeita H0. Não há evidência de diferença.\n")
}

# ============================================================================
# 5. VISUALIZAÇÕES
# ============================================================================

cat("\n=== GERANDO VISUALIZAÇÕES ===\n")

# Gráfico 1: Distribuição de renda por região
p1 <- ggplot(dados, aes(x = regiao, y = renda_familiar_mensal, fill = regiao)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Distribuição de Renda Familiar por Região",
    x = "Região",
    y = "Renda Familiar Mensal (R$)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("docs/img/renda_por_regiao.png", p1, width = 8, height = 6, dpi = 300)
cat("✓ Gráfico salvo: docs/img/renda_por_regiao.png\n")

# Gráfico 2: Proporção de uso de crédito
p2 <- ggplot(freq_credito, aes(x = usa_credito, y = proporcao, fill = usa_credito)) +
  geom_col(alpha = 0.8) +
  geom_text(aes(label = percentual), vjust = -0.5) +
  labs(
    title = "Proporção de Agricultores com Acesso a Crédito",
    x = "Usa Crédito",
    y = "Proporção"
  ) +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("docs/img/uso_credito.png", p2, width = 8, height = 6, dpi = 300)
cat("✓ Gráfico salvo: docs/img/uso_credito.png\n")

# ============================================================================
# 6. GERAR RELATÓRIO MARKDOWN
# ============================================================================

cat("\n=== GERANDO RELATÓRIO ===\n")

relatorio <- sprintf("# Relatório de Análise Inferencial

**Projeto:** Levantamento Amostral - Agricultura Familiar PB  
**Data:** %s  
**Autor:** Diogo Da Silva Rego

---

## 1. Resumo Executivo

Este relatório apresenta os resultados da análise inferencial realizada sobre os dados do levantamento amostral de agricultores familiares da Paraíba. A amostra compreende **%d observações** coletadas através do processo de integração de dados (ETL) descrito no manual técnico.

---

## 2. Análise Descritiva

### 2.1 Variáveis Numéricas

A renda familiar mensal média observada na amostra foi de **R$ %.2f**, com mediana de **R$ %.2f** e desvio padrão de **R$ %.2f**. A área plantada média foi de **%.2f hectares**.

### 2.2 Variáveis Categóricas

A distribuição de acesso a crédito rural na amostra foi:

| Usa Crédito | Frequência | Percentual |
|-------------|------------|------------|
| Sim         | %d         | %.1f%%     |
| Não         | %d         | %.1f%%     |

---

## 3. Estimação por Intervalo de Confiança

### 3.1 Proporção de Agricultores com Acesso a Crédito

Utilizando um estimador para populações finitas (N = 100.000) e considerando um nível de confiança de 95%%, a proporção estimada de agricultores com acesso a crédito na população é:

- **Estimativa pontual:** %.2f%%
- **Intervalo de confiança (95%%):** [%.2f%%, %.2f%%]
- **Margem de erro:** ±%.2f%%

**Interpretação:** Com 95%% de confiança, estima-se que entre %.1f%% e %.1f%% dos agricultores familiares da Paraíba têm acesso a crédito rural.

### 3.2 Renda Familiar Mensal Média

A renda familiar mensal média estimada para a população é:

- **Estimativa pontual:** R$ %.2f
- **Intervalo de confiança (95%%):** [R$ %.2f, R$ %.2f]

---

## 4. Testes de Hipóteses

### 4.1 Comparação de Renda entre Regiões (Cariri vs. Litoral)

**Hipótese Nula (H₀):** A renda média no Cariri é igual à renda média no Litoral.  
**Hipótese Alternativa (H₁):** A renda média no Cariri é diferente da renda média no Litoral.

**Resultado do Teste T:**
- Estatística t: %.3f
- p-valor: %.4f
- Conclusão: %s

### 4.2 Uso de Crédito por Região

**Hipótese Nula (H₀):** A proporção de uso de crédito é igual entre as regiões.  
**Hipótese Alternativa (H₁):** A proporção de uso de crédito difere entre as regiões.

**Resultado do Teste Qui-quadrado:**
- Estatística χ²: %.3f
- p-valor: %.4f
- Conclusão: %s

---

## 5. Visualizações

### 5.1 Distribuição de Renda por Região

![Renda por Região](img/renda_por_regiao.png)

### 5.2 Proporção de Uso de Crédito

![Uso de Crédito](img/uso_credito.png)

---

## 6. Conclusões e Recomendações

Os resultados da análise inferencial indicam que:

1. A proporção de agricultores com acesso a crédito na Paraíba está entre %.1f%% e %.1f%% (IC 95%%).
2. %s
3. %s

**Recomendações:**
- Expandir políticas de acesso a crédito para regiões com menor cobertura.
- Investigar as causas das disparidades regionais identificadas.
- Realizar estudos longitudinais para acompanhar a evolução desses indicadores.

---

**Desenvolvido por:** Diogo Da Silva Rego  
**Ferramentas:** R 4.2+, dplyr, ggplot2
",
  format(Sys.Date(), "%%d/%%m/%%Y"),
  nrow(dados),
  descritiva_numerica$renda_media,
  descritiva_numerica$renda_mediana,
  descritiva_numerica$renda_dp,
  descritiva_numerica$area_media,
  freq_credito$n[freq_credito$usa_credito == "Sim"],
  freq_credito$proporcao[freq_credito$usa_credito == "Sim"] * 100,
  freq_credito$n[freq_credito$usa_credito == "Não"],
  freq_credito$proporcao[freq_credito$usa_credito == "Não"] * 100,
  ic_credito$estimativa * 100,
  ic_credito$ic_inferior * 100,
  ic_credito$ic_superior * 100,
  ic_credito$margem_erro * 100,
  ic_credito$ic_inferior * 100,
  ic_credito$ic_superior * 100,
  ic_renda$estimativa,
  ic_renda$ic_inferior,
  ic_renda$ic_superior,
  teste_t$statistic,
  teste_t$p.value,
  ifelse(teste_t$p.value < 0.05, 
         "Rejeita-se H₀. Há diferença significativa entre as rendas das duas regiões (p < 0.05).",
         "Não se rejeita H₀. Não há evidência estatística de diferença significativa."),
  teste_qui$statistic,
  teste_qui$p.value,
  ifelse(teste_qui$p.value < 0.05,
         "Rejeita-se H₀. O uso de crédito difere significativamente entre as regiões (p < 0.05).",
         "Não se rejeita H₀. Não há evidência de diferença no uso de crédito entre regiões."),
  ic_credito$ic_inferior * 100,
  ic_credito$ic_superior * 100,
  ifelse(teste_t$p.value < 0.05,
         "Existem diferenças estatisticamente significativas na renda média entre as regiões do Cariri e do Litoral.",
         "Não foram encontradas diferenças significativas na renda média entre regiões."),
  ifelse(teste_qui$p.value < 0.05,
         "O acesso a crédito varia significativamente entre as regiões do estado.",
         "O acesso a crédito é relativamente homogêneo entre as regiões.")
)

writeLines(relatorio, "docs/relatorio_inferencia.md")
cat("✓ Relatório salvo: docs/relatorio_inferencia.md\n")

cat("\n=== ANÁLISE CONCLUÍDA COM SUCESSO ===\n")
