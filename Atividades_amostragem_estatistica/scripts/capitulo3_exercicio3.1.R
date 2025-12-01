################################################################################
# EXERCÍCIO 3.1 - POPULAÇÃO DE DOMICÍLIOS
################################################################################
#
# Disciplina: Amostragem Estatística
# Capítulo: 3 - Visão Geral da Amostragem e Estimação
# Fonte: Livro "Amostragem: Teoria e Prática usando R"
# Data: 24/11/2025
# Autor: Diogo Rego
#
# Descrição:
#   Este script resolve o Exercício 3.1 sobre uma população de N=6 domicílios,
#   calculando parâmetros populacionais, enumerando amostras possíveis,
#   implementando o estimador Horvitz-Thompson e comparando dois planos
#   amostrais em termos de eficiência.
#
# Objetivos:
#   1. Calcular parâmetros populacionais (total, média, variância)
#   2. Enumerar todas as amostras possíveis de tamanho 2
#   3. Analisar Plano A (15 amostras equiprováveis)
#   4. Analisar Plano B (5 amostras específicas)
#   5. Comparar eficiência dos planos amostrais
#   6. Gerar visualizações comparativas
#
################################################################################

# Configuração inicial --------------------------------------------------------

# Limpar ambiente
rm(list = ls())

# Carregar pacotes necessários
if (!require("pacman")) install.packages("pacman")
pacman::p_load(
  tidyverse,    # Manipulação e visualização de dados
  knitr,        # Geração de tabelas
  kableExtra,   # Formatação de tabelas
  scales,       # Formatação de números
  gridExtra     # Arranjo de gráficos
)

# Definir diretórios
data_dir <- here::here("data")
output_fig_dir <- here::here("output", "figuras")
output_tab_dir <- here::here("output", "tabelas")

# Criar diretórios se não existirem
if (!dir.exists(output_fig_dir)) dir.create(output_fig_dir, recursive = TRUE)
if (!dir.exists(output_tab_dir)) dir.create(output_tab_dir, recursive = TRUE)

# Configurar tema para gráficos
theme_set(theme_minimal(base_size = 12) +
            theme(plot.title = element_text(hjust = 0.5, face = "bold"),
                  plot.subtitle = element_text(hjust = 0.5)))


# Carregar dados da população --------------------------------------------------

cat("\n")
cat("================================================================================\n")
cat("EXERCÍCIO 3.1 - POPULAÇÃO DE DOMICÍLIOS\n")
cat("================================================================================\n\n")

# Carregar dados
populacao <- read.csv(file.path(data_dir, "populacao_domicilios.csv"))

# Exibir dados
cat("DADOS DA POPULAÇÃO (N = 6 domicílios)\n")
cat(rep("-", 80), "\n", sep = "")
print(kable(populacao, 
            format = "simple",
            col.names = c("Domicílio", "Renda (R$)", "Moradores", "Trabalhadores")))

# Calcular totais
totais <- colSums(populacao[, -1])
cat("\nTOTAIS POPULACIONAIS:\n")
cat(sprintf("  Renda: R$ %s\n", format(totais[1], big.mark = ".")))
cat(sprintf("  Moradores: %d\n", totais[2]))
cat(sprintf("  Trabalhadores: %d\n\n", totais[3]))

# Extrair variáveis
N <- nrow(populacao)
renda <- populacao$renda
moradores <- populacao$moradores
trabalhadores <- populacao$trabalhadores


# QUESTÃO 1: Parâmetros Populacionais ------------------------------------------

cat("\n")
cat("================================================================================\n")
cat("QUESTÃO 1: PARÂMETROS POPULACIONAIS\n")
cat("================================================================================\n\n")

#' Calcular parâmetros populacionais
#'
#' @param x Vetor numérico com os valores da variável
#' @return Lista com total, média, variância e desvio padrão
calcular_parametros <- function(x) {
  list(
    total = sum(x),
    media = mean(x),
    variancia = var(x) * (length(x) - 1) / length(x),  # Variância populacional
    desvio_padrao = sqrt(var(x) * (length(x) - 1) / length(x))
  )
}

# Calcular para cada variável
param_renda <- calcular_parametros(renda)
param_moradores <- calcular_parametros(moradores)
param_trabalhadores <- calcular_parametros(trabalhadores)

# Criar tabela de parâmetros
parametros_df <- data.frame(
  Variavel = c("Renda (R$)", "Moradores", "Trabalhadores"),
  Total = c(param_renda$total, param_moradores$total, param_trabalhadores$total),
  Media = c(param_renda$media, param_moradores$media, param_trabalhadores$media),
  Variancia = c(param_renda$variancia, param_moradores$variancia, 
                param_trabalhadores$variancia),
  Desvio_Padrao = c(param_renda$desvio_padrao, param_moradores$desvio_padrao, 
                    param_trabalhadores$desvio_padrao)
)

cat("PARÂMETROS POPULACIONAIS\n")
cat(rep("-", 80), "\n", sep = "")
print(kable(parametros_df, 
            format = "simple",
            digits = 2,
            col.names = c("Variável", "Total", "Média", "Variância", "Desvio Padrão")))
cat("\n")


# QUESTÃO 2: Conjunto S de amostras possíveis ----------------------------------

cat("\n")
cat("================================================================================\n")
cat("QUESTÃO 2: CONJUNTO S DE AMOSTRAS POSSÍVEIS (n=2)\n")
cat("================================================================================\n\n")

# Gerar todas as combinações de 2 domicílios
S <- combn(1:N, 2, simplify = FALSE)
num_amostras <- length(S)

cat(sprintf("Número total de amostras possíveis: C(6,2) = %d\n\n", num_amostras))

cat("CONJUNTO S:\n")
cat(rep("-", 80), "\n", sep = "")
for (i in seq_along(S)) {
  cat(sprintf("%2d. (%d, %d)\n", i, S[[i]][1], S[[i]][2]))
}
cat("\n")


# QUESTÃO 3: Plano Amostral A (Equiprovável) ----------------------------------

cat("\n")
cat("================================================================================\n")
cat("QUESTÃO 3: PLANO AMOSTRAL A (EQUIPROVÁVEL)\n")
cat("================================================================================\n\n")

cat("Todas as 15 amostras têm probabilidade igual: p(s) = 1/15\n\n")

# 3a. Probabilidades de inclusão das unidades
cat("3a. PROBABILIDADES DE INCLUSÃO π_i\n")
cat(rep("-", 80), "\n", sep = "")

#' Calcular probabilidades de inclusão
#'
#' @param S Lista de amostras
#' @param N Tamanho da população
#' @return Vetor com probabilidades de inclusão
calcular_prob_inclusao <- function(S, N) {
  prob <- numeric(N)
  for (i in 1:N) {
    count <- sum(sapply(S, function(s) i %in% s))
    prob[i] <- count / length(S)
  }
  return(prob)
}

prob_inclusao_A <- calcular_prob_inclusao(S, N)

for (i in 1:N) {
  cat(sprintf("π_%d = %.4f\n", i, prob_inclusao_A[i]))
}
cat("\n")

# 3b. Probabilidades de inclusão de pares
cat("3b. PROBABILIDADES DE INCLUSÃO DE PARES π_ij\n")
cat(rep("-", 80), "\n", sep = "")

cat("Cada par (i,j) aparece em exatamente 1 amostra:\n")
cat("π_ij = 1/15 ≈ 0.0667 para todos os pares i ≠ j\n\n")

# 3c. Estimador Horvitz-Thompson
cat("3c. ESTIMADOR HORVITZ-THOMPSON DO TOTAL (RENDA)\n")
cat(rep("-", 80), "\n", sep = "")

#' Calcular estimador Horvitz-Thompson
#'
#' @param amostra Vetor com índices da amostra
#' @param y Vetor com valores da variável
#' @param pi Vetor com probabilidades de inclusão
#' @return Estimativa do total
estimador_HT <- function(amostra, y, pi) {
  sum(y[amostra] / pi[amostra])
}

# Calcular para todas as amostras do Plano A
estimativas_HT_A <- sapply(S, estimador_HT, y = renda, pi = prob_inclusao_A)

# Criar tabela de resultados
resultados_A <- data.frame(
  Amostra = sapply(S, function(s) paste0("(", s[1], ",", s[2], ")")),
  Domicilios = sapply(S, function(s) paste(s[1], s[2], sep = ", ")),
  Renda = sapply(S, function(s) paste(renda[s[1]], renda[s[2]], sep = ", ")),
  Estimativa_HT = estimativas_HT_A
)

cat("\nAmostra | Domicílios | Renda (R$) | Estimativa HT (R$)\n")
cat(rep("-", 80), "\n", sep = "")
for (i in 1:nrow(resultados_A)) {
  cat(sprintf("%-8s | %-10s | %-12s | %s\n",
              resultados_A$Amostra[i],
              resultados_A$Domicilios[i],
              resultados_A$Renda[i],
              format(resultados_A$Estimativa_HT[i], big.mark = ".", decimal.mark = ",")))
}
cat("\n")

# 3d. Valor esperado e variância
cat("3d. VALOR ESPERADO E VARIÂNCIA DO ESTIMADOR HT (PLANO A)\n")
cat(rep("-", 80), "\n", sep = "")

E_T_hat_A <- mean(estimativas_HT_A)
Var_T_hat_A <- var(estimativas_HT_A) * (length(estimativas_HT_A) - 1) / 
  length(estimativas_HT_A)
DP_T_hat_A <- sqrt(Var_T_hat_A)
CV_A <- 100 * DP_T_hat_A / E_T_hat_A

cat(sprintf("\nValor Esperado E[T̂_HT]: R$ %s\n", 
            format(E_T_hat_A, big.mark = ".", decimal.mark = ",")))
cat(sprintf("Total Populacional (T_y): R$ %s\n", 
            format(param_renda$total, big.mark = ".", decimal.mark = ",")))
cat(sprintf("Viés: R$ %.2f\n", E_T_hat_A - param_renda$total))
cat(sprintf("\nVariância Var[T̂_HT]: %s\n", 
            format(Var_T_hat_A, big.mark = ".", decimal.mark = ",")))
cat(sprintf("Desvio Padrão: R$ %s\n", 
            format(DP_T_hat_A, big.mark = ".", decimal.mark = ",")))
cat(sprintf("Coeficiente de Variação: %.2f%%\n\n", CV_A))

cat("CONCLUSÃO: O estimador é NÃO VICIADO (Viés = 0)\n\n")


# QUESTÃO 4: Plano Amostral B (5 amostras específicas) ------------------------

cat("\n")
cat("================================================================================\n")
cat("QUESTÃO 4: PLANO AMOSTRAL B (5 AMOSTRAS ESPECÍFICAS)\n")
cat("================================================================================\n\n")

# Definir amostras do Plano B
S_B <- list(c(1,2), c(2,3), c(2,4), c(2,5), c(2,6))
num_amostras_B <- length(S_B)

cat(sprintf("Conjunto S_B com %d amostras:\n", num_amostras_B))
cat(rep("-", 80), "\n", sep = "")
for (i in seq_along(S_B)) {
  cat(sprintf("%d. (%d,%d) com probabilidade 1/5 = 0.2000\n", 
              i, S_B[[i]][1], S_B[[i]][2]))
}
cat("\n")

# 4a. Probabilidades de inclusão
cat("4a. PROBABILIDADES DE INCLUSÃO π_i (PLANO B)\n")
cat(rep("-", 80), "\n", sep = "")

prob_inclusao_B <- calcular_prob_inclusao(S_B, N)

for (i in 1:N) {
  count <- sum(sapply(S_B, function(s) i %in% s))
  cat(sprintf("π_%d = %d × 0.2000 = %.4f\n", i, count, prob_inclusao_B[i]))
}
cat("\nOBSERVAÇÃO: O domicílio 2 tem probabilidade de inclusão = 1 (certeza!)\n\n")

# 4b. Probabilidades de pares
cat("4b. PROBABILIDADES DE INCLUSÃO DE PARES π_ij (PLANO B)\n")
cat(rep("-", 80), "\n", sep = "")

cat("Apenas os pares que aparecem em S_B têm probabilidade não nula:\n")
cat("π_12 = π_23 = π_24 = π_25 = π_26 = 0.2000\n")
cat("Todos os outros pares: π_ij = 0\n\n")

# 4c. Estimador HT (Plano B)
cat("4c. ESTIMADOR HORVITZ-THOMPSON DO TOTAL (PLANO B)\n")
cat(rep("-", 80), "\n", sep = "")

estimativas_HT_B <- sapply(S_B, estimador_HT, y = renda, pi = prob_inclusao_B)

resultados_B <- data.frame(
  Amostra = sapply(S_B, function(s) paste0("(", s[1], ",", s[2], ")")),
  Domicilios = sapply(S_B, function(s) paste(s[1], s[2], sep = ", ")),
  Renda = sapply(S_B, function(s) paste(renda[s[1]], renda[s[2]], sep = ", ")),
  Pi = sapply(S_B, function(s) paste(prob_inclusao_B[s[1]], 
                                      prob_inclusao_B[s[2]], sep = " / ")),
  Estimativa_HT = estimativas_HT_B
)

cat("\nAmostra | Domicílios | Renda (R$) | π_i / π_j | Estimativa HT (R$)\n")
cat(rep("-", 80), "\n", sep = "")
for (i in 1:nrow(resultados_B)) {
  cat(sprintf("%-8s | %-10s | %-12s | %-9s | %s\n",
              resultados_B$Amostra[i],
              resultados_B$Domicilios[i],
              resultados_B$Renda[i],
              resultados_B$Pi[i],
              format(resultados_B$Estimativa_HT[i], big.mark = ".", decimal.mark = ",")))
}
cat("\n")

# 4d. Valor esperado e variância (Plano B)
cat("4d. VALOR ESPERADO E VARIÂNCIA DO ESTIMADOR HT (PLANO B)\n")
cat(rep("-", 80), "\n", sep = "")

E_T_hat_B <- mean(estimativas_HT_B)
Var_T_hat_B <- var(estimativas_HT_B) * (length(estimativas_HT_B) - 1) / 
  length(estimativas_HT_B)
DP_T_hat_B <- sqrt(Var_T_hat_B)
CV_B <- 100 * DP_T_hat_B / E_T_hat_B

cat(sprintf("\nValor Esperado E[T̂_HT]: R$ %s\n", 
            format(E_T_hat_B, big.mark = ".", decimal.mark = ",")))
cat(sprintf("Total Populacional (T_y): R$ %s\n", 
            format(param_renda$total, big.mark = ".", decimal.mark = ",")))
cat(sprintf("Viés: R$ %.2f\n", E_T_hat_B - param_renda$total))
cat(sprintf("\nVariância Var[T̂_HT]: %s\n", 
            format(Var_T_hat_B, big.mark = ".", decimal.mark = ",")))
cat(sprintf("Desvio Padrão: R$ %s\n", 
            format(DP_T_hat_B, big.mark = ".", decimal.mark = ",")))
cat(sprintf("Coeficiente de Variação: %.2f%%\n\n", CV_B))

cat("CONCLUSÃO: O estimador também é NÃO VICIADO no Plano B\n\n")


# QUESTÃO 5: Gráficos Comparativos --------------------------------------------

cat("\n")
cat("================================================================================\n")
cat("QUESTÃO 5: GRÁFICOS COMPARATIVOS\n")
cat("================================================================================\n\n")

# Preparar dados para visualização
dados_plot <- data.frame(
  Plano = rep(c("Plano A\n(15 amostras equiprováveis)", 
                "Plano B\n(5 amostras específicas)"), 
              c(length(estimativas_HT_A), length(estimativas_HT_B))),
  Estimativa = c(estimativas_HT_A, estimativas_HT_B)
)

# Criar gráfico comparativo
p <- ggplot(dados_plot, aes(x = Estimativa, fill = Plano)) +
  geom_histogram(bins = 10, alpha = 0.7, color = "black", position = "identity") +
  geom_vline(xintercept = param_renda$total, 
             color = "red", linetype = "dashed", linewidth = 1.2) +
  geom_vline(data = data.frame(Plano = c("Plano A\n(15 amostras equiprováveis)", 
                                          "Plano B\n(5 amostras específicas)"),
                                media = c(E_T_hat_A, E_T_hat_B)),
             aes(xintercept = media), 
             color = "darkgreen", linetype = "dashed", linewidth = 1) +
  scale_fill_manual(values = c("steelblue", "coral")) +
  scale_x_continuous(labels = scales::comma_format(big.mark = ".", decimal.mark = ",")) +
  facet_wrap(~Plano, ncol = 1, scales = "free_y") +
  labs(
    title = "Comparação das Distribuições do Estimador Horvitz-Thompson",
    subtitle = "Estimativas do Total da Renda sob Dois Planos Amostrais",
    x = "Estimativa do Total (R$)",
    y = "Frequência",
    caption = "Linha vermelha tracejada: Total Real (R$ 10.000)\nLinha verde tracejada: Valor Esperado"
  ) +
  theme(legend.position = "none",
        strip.text = element_text(face = "bold", size = 11))

# Salvar gráfico
ggsave(
  filename = file.path(output_fig_dir, "comparacao_planos_amostrais.png"),
  plot = p,
  width = 10,
  height = 8,
  dpi = 300
)

cat("Gráfico salvo em:", file.path(output_fig_dir, "comparacao_planos_amostrais.png"), "\n\n")

# Exibir gráfico
print(p)


# QUESTÃO 6: Comparação e Recomendação ----------------------------------------

cat("\n")
cat("================================================================================\n")
cat("QUESTÃO 6: COMPARAÇÃO DOS PLANOS AMOSTRAIS\n")
cat("================================================================================\n\n")

cat("RESUMO COMPARATIVO\n")
cat(rep("-", 80), "\n", sep = "")

# Criar tabela comparativa
comparacao <- data.frame(
  Caracteristica = c(
    "Número de amostras",
    "Valor Esperado E[T̂]",
    "Total Populacional",
    "Viés",
    "Variância Var[T̂]",
    "Desvio Padrão",
    "Coef. de Variação (%)"
  ),
  Plano_A = c(
    as.character(num_amostras),
    paste0("R$ ", format(E_T_hat_A, big.mark = ".", decimal.mark = ",")),
    paste0("R$ ", format(param_renda$total, big.mark = ".", decimal.mark = ",")),
    "R$ 0,00",
    format(Var_T_hat_A, big.mark = ".", decimal.mark = ","),
    paste0("R$ ", format(DP_T_hat_A, big.mark = ".", decimal.mark = ",")),
    sprintf("%.2f%%", CV_A)
  ),
  Plano_B = c(
    as.character(num_amostras_B),
    paste0("R$ ", format(E_T_hat_B, big.mark = ".", decimal.mark = ",")),
    paste0("R$ ", format(param_renda$total, big.mark = ".", decimal.mark = ",")),
    "R$ 0,00",
    format(Var_T_hat_B, big.mark = ".", decimal.mark = ","),
    paste0("R$ ", format(DP_T_hat_B, big.mark = ".", decimal.mark = ",")),
    sprintf("%.2f%%", CV_B)
  )
)

print(kable(comparacao, 
            format = "simple",
            col.names = c("Característica", "Plano A", "Plano B")))

cat("\n")
cat("ANÁLISE\n")
cat(rep("-", 80), "\n", sep = "")

reducao_variancia <- 100 * (1 - Var_T_hat_B / Var_T_hat_A)

cat("\n1. NÃO VICIAMENTO:\n")
cat("   Ambos os planos são NÃO VICIADOS, pois E[T̂_HT] = T_y = R$ 10.000,00\n\n")

cat("2. PRECISÃO (VARIÂNCIA):\n")
cat(sprintf("   - Plano B tem variância %.2f%% MENOR que Plano A\n", reducao_variancia))
cat(sprintf("   - Variância Plano A: %s\n", 
            format(Var_T_hat_A, big.mark = ".", decimal.mark = ",")))
cat(sprintf("   - Variância Plano B: %s\n\n", 
            format(Var_T_hat_B, big.mark = ".", decimal.mark = ",")))

cat("3. POR QUE O PLANO B É MAIS EFICIENTE?\n")
cat("   O Plano B concentra a amostragem no domicílio 2 (maior renda: R$ 4.200),\n")
cat("   que é incluído com CERTEZA (π_2 = 1,0) em todas as amostras. Esta\n")
cat("   estratégia reduz significativamente a variabilidade das estimativas.\n\n")

cat(rep("=", 80), "\n", sep = "")
cat(">>> RECOMENDAÇÃO: PLANO B É PREFERÍVEL <<<\n")
cat(rep("=", 80), "\n\n")

cat("JUSTIFICATIVA:\n")
cat(strwrap("Embora ambos os planos sejam não viciados, o Plano B oferece estimativas 
muito mais precisas (menor variância) para o total da renda. A redução de 65% 
na variância representa um ganho substancial de eficiência estatística, resultando 
em intervalos de confiança mais estreitos e estimativas mais confiáveis.", 
            width = 78), sep = "\n")
cat("\n\n")


# Salvar resultados em CSV -----------------------------------------------------

# Salvar parâmetros populacionais
write.csv(
  parametros_df,
  file = file.path(output_tab_dir, "parametros_populacionais.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# Salvar resultados Plano A
write.csv(
  resultados_A,
  file = file.path(output_tab_dir, "resultados_plano_A.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# Salvar resultados Plano B
write.csv(
  resultados_B,
  file = file.path(output_tab_dir, "resultados_plano_B.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# Salvar comparação
write.csv(
  comparacao,
  file = file.path(output_tab_dir, "comparacao_planos.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Tabelas de resultados salvas em:", output_tab_dir, "\n")


# Conclusão --------------------------------------------------------------------

cat("\n")
cat("================================================================================\n")
cat("CONCLUSÕES DO EXERCÍCIO 3.1\n")
cat("================================================================================\n\n")

conclusoes <- c(
  "1. NÃO VICIAMENTO depende do plano amostral e do estimador, não do número 
  de amostras possíveis.",
  
  "2. EFICIÊNCIA varia significativamente entre planos, mesmo sendo ambos 
  não viciados.",
  
  "3. PROBABILIDADES DESIGUAIS de inclusão podem melhorar significativamente 
  a precisão das estimativas.",
  
  "4. ESTIMADOR HORVITZ-THOMPSON é não viciado sob qualquer plano probabilístico 
  com probabilidades conhecidas e positivas."
)

for (i in seq_along(conclusoes)) {
  cat(strwrap(conclusoes[i], width = 78), sep = "\n")
  cat("\n")
}

cat("================================================================================\n")
cat("ANÁLISE CONCLUÍDA COM SUCESSO!\n")
cat("================================================================================\n\n")

################################################################################
# FIM DO SCRIPT
################################################################################
