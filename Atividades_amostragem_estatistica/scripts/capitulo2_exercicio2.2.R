################################################################################
# EXERCÍCIO 2.2 - PLANEJAMENTO DE PESQUISA COM ESTUDANTES DO ENSINO FUNDAMENTAL
################################################################################
#
# Disciplina: Amostragem Estatística
# Capítulo: 2 - Conceitos e Cadastros
# Fonte: Livro "Amostragem: Teoria e Prática usando R"
# Data: 24/11/2025
# Autor: Diogo Rego
#
# Descrição:
#   Este script analisa dois cadastros disponíveis para uma pesquisa com
#   estudantes do ensino fundamental regular em escolas públicas municipais
#   do Rio de Janeiro, avaliando vantagens, desvantagens e recomendações.
#
# Contexto:
#   - População: Estudantes do EFR em escolas públicas municipais (RJ)
#   - Período de coleta: Setembro-Outubro 2019
#   - Cadastro A: Censo Escolar MEC 2018
#   - Cadastro B: Lista de escolas da Prefeitura (atualizada até agosto 2019)
#
################################################################################

# Configuração inicial --------------------------------------------------------

# Limpar ambiente
rm(list = ls())

# Carregar pacotes necessários
if (!require("pacman")) install.packages("pacman")
pacman::p_load(
  tidyverse,    # Manipulação de dados
  knitr,        # Geração de tabelas
  kableExtra,   # Formatação de tabelas
  DiagrammeR    # Diagramas de fluxo
)

# Definir diretório de saída
output_dir <- here::here("output", "tabelas")
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)


# Informações do contexto ------------------------------------------------------

cat("\n")
cat("================================================================================\n")
cat("EXERCÍCIO 2.2 - PLANEJAMENTO DE PESQUISA COM ESTUDANTES\n")
cat("================================================================================\n\n")

cat("CONTEXTO DA PESQUISA\n")
cat(rep("-", 80), "\n", sep = "")
cat("População-alvo: Estudantes do Ensino Fundamental Regular (EFR)\n")
cat("Escolas: Públicas municipais do Rio de Janeiro\n")
cat("Período de coleta: Setembro-Outubro de 2019\n\n")

cat("CADASTROS DISPONÍVEIS:\n")
cat("  A) Censo Escolar do MEC (ano calendário 2018)\n")
cat("  B) Lista de escolas públicas municipais da Prefeitura (agosto 2019)\n\n")


# Questão 1: Tipo de associação ------------------------------------------------

cat("\n")
cat("================================================================================\n")
cat("QUESTÃO 1: TIPO DE ASSOCIAÇÃO ENTRE CADASTRO E UNIDADES DE REFERÊNCIA\n")
cat("================================================================================\n\n")

# Análise do Cadastro A
cat("CADASTRO A - Censo Escolar MEC 2018\n")
cat(rep("-", 80), "\n", sep = "")

analise_cadastro_a <- data.frame(
  Aspecto = c(
    "Tipo de associação",
    "Defasagem temporal",
    "Unidades no cadastro",
    "Unidades de referência",
    "Principal problema"
  ),
  Descricao = c(
    "Associação indireta com defasagem temporal",
    "Aproximadamente 1 ano e meio (2018 → Set-Out 2019)",
    "Estudantes matriculados em 2018",
    "Estudantes matriculados em setembro-outubro 2019",
    "Evasão, conclusão, transferências; novos alunos não incluídos"
  )
)

print(kable(analise_cadastro_a, format = "simple"))
cat("\n")

# Análise do Cadastro B
cat("CADASTRO B - Lista de Escolas da Prefeitura (Agosto 2019)\n")
cat(rep("-", 80), "\n", sep = "")

analise_cadastro_b <- data.frame(
  Aspecto = c(
    "Tipo de associação",
    "Defasagem temporal",
    "Unidades no cadastro",
    "Unidades de referência",
    "Característica"
  ),
  Descricao = c(
    "Associação indireta através de conglomerados (escolas)",
    "Mínima (1-2 meses antes da coleta)",
    "Escolas públicas municipais",
    "Estudantes matriculados nessas escolas",
    "Escolas funcionam como unidades intermediárias"
  )
)

print(kable(analise_cadastro_b, format = "simple"))
cat("\n")


# Questão 2: Vantagens e desvantagens ------------------------------------------

cat("\n")
cat("================================================================================\n")
cat("QUESTÃO 2: VANTAGENS E DESVANTAGENS DE CADA CADASTRO\n")
cat("================================================================================\n\n")

# Cadastro A - Vantagens
cat("CADASTRO A - VANTAGENS\n")
cat(rep("-", 80), "\n", sep = "")

vantagens_a <- c(
  "Contém informações detalhadas sobre os estudantes (idade, série, turma)",
  "Permite seleção direta dos estudantes",
  "Cobertura nacional padronizada e consistente",
  "Dados oficiais e confiáveis do MEC",
  "Permite estratificação por características dos alunos",
  "Informações sobre características socioeconômicas"
)

for (i in seq_along(vantagens_a)) {
  cat(sprintf("  %d. %s\n", i, vantagens_a[i]))
}
cat("\n")

# Cadastro A - Desvantagens
cat("CADASTRO A - DESVANTAGENS\n")
cat(rep("-", 80), "\n", sep = "")

desvantagens_a <- c(
  "Defasagem temporal significativa (1 ano e meio)",
  "Erros de cobertura por desatualização (evasão, conclusão, transferências)",
  "Não inclui novos alunos matriculados em 2019",
  "Informações de contato podem estar desatualizadas",
  "Necessidade de atualização antes do uso",
  "Possível viés se alunos não localizados forem sistemáticos"
)

for (i in seq_along(desvantagens_a)) {
  cat(sprintf("  %d. %s\n", i, desvantagens_a[i]))
}
cat("\n")

# Cadastro B - Vantagens
cat("CADASTRO B - VANTAGENS\n")
cat(rep("-", 80), "\n", sep = "")

vantagens_b <- c(
  "Atualização recente (apenas 1-2 meses antes da coleta)",
  "Menor probabilidade de erros de cobertura de escolas",
  "Informações de contato dos diretores facilitam acesso",
  "Informações sobre séries oferecidas auxiliam no planejamento",
  "Reflete a situação atual do sistema educacional municipal"
)

for (i in seq_along(vantagens_b)) {
  cat(sprintf("  %d. %s\n", i, vantagens_b[i]))
}
cat("\n")

# Cadastro B - Desvantagens
cat("CADASTRO B - DESVANTAGENS\n")
cat(rep("-", 80), "\n", sep = "")

desvantagens_b <- c(
  "Não contém lista de estudantes, apenas escolas",
  "Necessidade de etapa adicional de arrolamento dos alunos",
  "Não permite seleção direta dos estudantes",
  "Falta de informações detalhadas sobre os alunos para estratificação",
  "Requer procedimentos adicionais em campo",
  "Aumento de custos e tempo devido ao arrolamento"
)

for (i in seq_along(desvantagens_b)) {
  cat(sprintf("  %d. %s\n", i, desvantagens_b[i]))
}
cat("\n")


# Criar tabela comparativa
comparacao <- data.frame(
  Criterio = c(
    "Atualização",
    "Cobertura",
    "Informações sobre alunos",
    "Seleção direta",
    "Custo operacional",
    "Complexidade"
  ),
  Cadastro_A = c(
    "Desatualizado (2018)",
    "Completa mas defasada",
    "Detalhadas",
    "Sim (com atualização)",
    "Médio",
    "Média"
  ),
  Cadastro_B = c(
    "Atualizado (ago/2019)",
    "Atual de escolas",
    "Não disponíveis",
    "Não (requer arrolamento)",
    "Alto",
    "Alta"
  )
)

cat("TABELA COMPARATIVA\n")
cat(rep("-", 80), "\n", sep = "")
print(kable(comparacao, 
            format = "simple",
            col.names = c("Critério", "Cadastro A", "Cadastro B")))
cat("\n")


# Questão 3: Cuidados ao usar Cadastro A ---------------------------------------

cat("\n")
cat("================================================================================\n")
cat("QUESTÃO 3: CUIDADOS AO OPTAR PELO CADASTRO A\n")
cat("================================================================================\n\n")

cuidados_a <- data.frame(
  Procedimento = c(
    "a) Atualização do cadastro",
    "b) Procedimentos de substituição",
    "c) Verificação em campo",
    "d) Inclusão de novos alunos",
    "e) Análise de não resposta"
  ),
  Descricao = c(
    "Contatar escolas antes da coleta para verificar alunos matriculados; 
    solicitar lista atualizada de setembro 2019; identificar evasões e 
    transferências",
    
    "Estabelecer regras claras para substituição; selecionar amostra de 
    reserva (oversample); documentar todos os casos de não localização",
    
    "Confirmar presença do aluno na escola antes da entrevista; atualizar 
    informações de série/turma no momento da coleta",
    
    "Considerar procedimento para incluir alunos matriculados em 2019 não 
    constantes no cadastro de 2018; avaliar impacto na representatividade",
    
    "Documentar motivos de não localização/não resposta; avaliar se há viés 
    sistemático nos alunos não localizados"
  )
)

for (i in 1:nrow(cuidados_a)) {
  cat(cuidados_a$Procedimento[i], "\n")
  cat(rep("-", 80), "\n", sep = "")
  cat(strwrap(cuidados_a$Descricao[i], width = 78), sep = "\n")
  cat("\n\n")
}


# Questão 4: Procedimentos ao usar Cadastro B ----------------------------------

cat("\n")
cat("================================================================================\n")
cat("QUESTÃO 4: PROCEDIMENTOS AO OPTAR PELO CADASTRO B\n")
cat("================================================================================\n\n")

procedimentos_b <- data.frame(
  Procedimento = c(
    "a) Amostragem em múltiplos estágios",
    "b) Arrolamento dos estudantes",
    "c) Estratificação dentro das escolas",
    "d) Coordenação com as escolas",
    "e) Atualização do cadastro de escolas",
    "f) Definição clara da população"
  ),
  Descricao = c(
    "1º estágio: Selecionar amostra de escolas da lista; 
    2º estágio: Realizar arrolamento completo dos alunos do EFR; 
    3º estágio: Selecionar amostra de alunos dentro de cada escola",
    
    "Solicitar à direção lista completa e atualizada de alunos matriculados 
    em setembro 2019; obter nome, série, turma, turno; verificar frequência 
    recente",
    
    "Estratificar por série para garantir representatividade de todos os anos 
    do EFR; considerar estratificação por turno se relevante",
    
    "Estabelecer contato prévio com diretores usando informações da lista; 
    obter autorização formal; agendar visitas para minimizar interferência",
    
    "Verificar se há novas escolas municipais criadas após agosto 2019; 
    confirmar que as escolas listadas ainda oferecem EFR em 2019",
    
    "Especificar critérios de inclusão: apenas alunos regularmente matriculados 
    e frequentes; definir tratamento de alunos com frequência irregular"
  )
)

for (i in 1:nrow(procedimentos_b)) {
  cat(procedimentos_b$Procedimento[i], "\n")
  cat(rep("-", 80), "\n", sep = "")
  cat(strwrap(procedimentos_b$Descricao[i], width = 78), sep = "\n")
  cat("\n\n")
}


# Questão 5: Recomendação de uso -----------------------------------------------

cat("\n")
cat("================================================================================\n")
cat("QUESTÃO 5: RECOMENDAÇÃO - USO COMBINADO DOS CADASTROS\n")
cat("================================================================================\n\n")

cat("ESTRATÉGIA PROPOSTA: USO COMBINADO\n")
cat(rep("-", 80), "\n", sep = "")
cat("\n")

estrategia <- data.frame(
  Fase = paste("Fase", 1:4),
  Atividade = c(
    "Seleção de escolas",
    "Informações auxiliares",
    "Arrolamento atualizado",
    "Seleção de alunos"
  ),
  Cadastro = c(
    "Cadastro B",
    "Cadastro A",
    "Escolas selecionadas",
    "Listas atualizadas"
  ),
  Justificativa = c(
    "Está atualizado e garante cobertura adequada das escolas em funcionamento",
    "Obter tamanho aproximado das escolas para cálculo de PPT",
    "Garante cadastro atualizado das unidades de referência",
    "Seleção de alunos efetivamente matriculados no momento da pesquisa"
  )
)

print(kable(estrategia, format = "simple"))
cat("\n")

cat("PLANO AMOSTRAL SUGERIDO:\n")
cat(rep("-", 80), "\n", sep = "")
cat("  • Estratificação: Por região administrativa do RJ e/ou tamanho da escola\n")
cat("  • 1º estágio: Seleção de escolas com PPT (proporcional ao nº de alunos)\n")
cat("  • 2º estágio: Seleção de alunos por AAS dentro de cada escola\n\n")

cat("VANTAGENS DESTA ABORDAGEM:\n")
cat(rep("-", 80), "\n", sep = "")
vantagens_combinado <- c(
  "Minimiza erros de cobertura usando cadastro atualizado de escolas",
  "Permite planejamento amostral eficiente usando informações do Censo Escolar",
  "Garante seleção de alunos efetivamente matriculados no momento da pesquisa",
  "Flexível e adaptável a mudanças recentes no sistema educacional municipal",
  "Combina as vantagens de ambos os cadastros"
)

for (i in seq_along(vantagens_combinado)) {
  cat(sprintf("  %d. %s\n", i, vantagens_combinado[i]))
}
cat("\n")


# Salvar análise comparativa ---------------------------------------------------

write.csv(
  comparacao,
  file = file.path(output_dir, "comparacao_cadastros_exercicio2.2.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

write.csv(
  estrategia,
  file = file.path(output_dir, "estrategia_combinada_exercicio2.2.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("Tabelas salvas em:", output_dir, "\n")


# Conclusão --------------------------------------------------------------------

cat("\n")
cat("================================================================================\n")
cat("CONCLUSÃO\n")
cat("================================================================================\n\n")

conclusao <- "A combinação dos dois cadastros permite aproveitar as vantagens de cada um: 
a atualização e cobertura do Cadastro B para escolas, e as informações detalhadas 
do Cadastro A para planejamento. O arrolamento atualizado nas escolas selecionadas 
é fundamental para garantir que a população de pesquisa corresponda à população alvo.

Esta estratégia minimiza erros de cobertura, reduz viés de seleção e garante que 
os estudantes efetivamente matriculados e frequentes sejam adequadamente 
representados na amostra."

cat(strwrap(conclusao, width = 78), sep = "\n")
cat("\n\n")

cat("================================================================================\n")
cat("ANÁLISE CONCLUÍDA COM SUCESSO!\n")
cat("================================================================================\n\n")

################################################################################
# FIM DO SCRIPT
################################################################################
