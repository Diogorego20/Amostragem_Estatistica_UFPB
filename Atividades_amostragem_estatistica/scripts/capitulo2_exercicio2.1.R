################################################################################
# EXERCÍCIO 2.1 - ANÁLISE DA PESQUISA TIC DOMICÍLIOS 2017
################################################################################
#
# Disciplina: Amostragem Estatística
# Capítulo: 2 - Conceitos e Cadastros
# Fonte: Livro "Amostragem: Teoria e Prática usando R"
# Data: 24/11/2025
# Autor: Diogo Rego
#
# Descrição:
#   Este script documenta a análise metodológica da Pesquisa TIC Domicílios 2017
#   realizada pelo CETIC.br, respondendo às questões sobre população-alvo,
#   cadastros, unidades de análise, tipo de pesquisa e procedimentos de coleta.
#
# Referência:
#   CETIC.br (2018). Relatório Metodológico da Pesquisa TIC Domicílios 2017.
#   Disponível em: https://cetic.br/
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
  kableExtra    # Formatação de tabelas
)

# Definir diretório de saída
output_dir <- here::here("output", "tabelas")
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)


# Informações da Pesquisa TIC Domicílios 2017 ---------------------------------

cat("\n")
cat("================================================================================\n")
cat("EXERCÍCIO 2.1 - ANÁLISE DA PESQUISA TIC DOMICÍLIOS 2017\n")
cat("================================================================================\n\n")

# a) Objetivo da pesquisa ------------------------------------------------------

cat("a) OBJETIVO DA PESQUISA\n")
cat(rep("-", 80), "\n", sep = "")

objetivo <- "Medir a posse e o uso das tecnologias de informação e comunicação (TIC) 
entre a população residente no Brasil com idade de 10 anos ou mais."

cat(strwrap(objetivo, width = 78), sep = "\n")
cat("\n")


# b) População alvo e população de pesquisa ------------------------------------

cat("b) POPULAÇÃO ALVO E POPULAÇÃO DE PESQUISA\n")
cat(rep("-", 80), "\n", sep = "")

populacao_alvo <- "Domicílios particulares permanentes brasileiros e população 
com 10 anos de idade ou mais residente nesses domicílios."

populacao_pesquisa <- "Coincide com a população alvo. A pesquisa abrange todo 
o território nacional, incluindo áreas urbanas e rurais."

cat("População Alvo:\n")
cat(strwrap(populacao_alvo, width = 78, prefix = "  "), sep = "\n")
cat("\nPopulação de Pesquisa:\n")
cat(strwrap(populacao_pesquisa, width = 78, prefix = "  "), sep = "\n")
cat("\n")


# c) Principal cadastro utilizado ----------------------------------------------

cat("c) PRINCIPAL CADASTRO UTILIZADO\n")
cat(rep("-", 80), "\n", sep = "")

cadastro <- "Base de setores censitários do Censo Demográfico 2010 do IBGE 
(Instituto Brasileiro de Geografia e Estatística)."

cat(strwrap(cadastro, width = 78), sep = "\n")
cat("\n")


# d) Unidades de referência ----------------------------------------------------

cat("d) UNIDADES DE REFERÊNCIA\n")
cat(rep("-", 80), "\n", sep = "")

unidades_referencia <- data.frame(
  Numero = 1:2,
  Unidade = c(
    "Domicílios particulares permanentes",
    "População residente com 10 anos de idade ou mais"
  )
)

print(kable(unidades_referencia, 
            format = "simple",
            col.names = c("Nº", "Unidade de Referência")))
cat("\n")


# e) Unidades informantes ------------------------------------------------------

cat("e) UNIDADES INFORMANTES\n")
cat(rep("-", 80), "\n", sep = "")

informantes <- "Moradores dos domicílios selecionados, especificamente 
indivíduos com 10 anos ou mais de idade que respondem ao questionário 
durante a entrevista presencial."

cat(strwrap(informantes, width = 78), sep = "\n")
cat("\n")


# f) Unidades de análise -------------------------------------------------------

cat("f) UNIDADES DE ANÁLISE\n")
cat(rep("-", 80), "\n", sep = "")

unidades_analise <- data.frame(
  Numero = 1:2,
  Unidade = c(
    "Domicílios particulares permanentes",
    "Indivíduos com 10 anos de idade ou mais residentes nesses domicílios"
  )
)

print(kable(unidades_analise, 
            format = "simple",
            col.names = c("Nº", "Unidade de Análise")))
cat("\n")


# g) Unidades de amostragem ----------------------------------------------------

cat("g) UNIDADES DE AMOSTRAGEM\n")
cat(rep("-", 80), "\n", sep = "")

unidades_amostragem <- data.frame(
  Estagio = c("1º estágio", "2º estágio", "3º estágio", "4º estágio"),
  Unidade = c(
    "Municípios (quando não selecionados com certeza) ou setores censitários",
    "Setores censitários",
    "Domicílios particulares permanentes",
    "Indivíduos (moradores com 10 anos ou mais)"
  )
)

print(kable(unidades_amostragem, 
            format = "simple",
            col.names = c("Estágio", "Unidade de Amostragem")))

cat("\nPlano amostral: Amostragem estratificada de conglomerados em múltiplos\n")
cat("estágios (3 ou 4 estágios).\n\n")


# h) Tipo de pesquisa ----------------------------------------------------------

cat("h) TIPO DE PESQUISA\n")
cat(rep("-", 80), "\n", sep = "")

tipo <- "Pesquisa por amostragem probabilística."

cat(tipo, "\n\n")


# i) Desenvolvimento temporal e periodicidade ----------------------------------

cat("i) DESENVOLVIMENTO TEMPORAL E PERIODICIDADE\n")
cat(rep("-", 80), "\n", sep = "")

temporal <- "Pesquisa repetida com periodicidade ANUAL. Realizada anualmente 
desde 2005, permitindo o acompanhamento da evolução do acesso e uso das TIC 
no Brasil ao longo do tempo."

cat(strwrap(temporal, width = 78), sep = "\n")
cat("\n")


# j) Forma de coleta dos dados -------------------------------------------------

cat("j) FORMA DE COLETA DOS DADOS\n")
cat(rep("-", 80), "\n", sep = "")

coleta <- "Entrevistas presenciais (face a face) nos domicílios selecionados 
usando o método CAPI (Computer-Assisted Personal Interviewing). Os 
entrevistadores aplicam questionários estruturados programados em tablets, 
com perguntas fechadas e respostas predefinidas."

cat(strwrap(coleta, width = 78), sep = "\n")
cat("\nPeríodo de coleta (2017): Novembro de 2017\n\n")


# k) Quantidades resumo publicadas ---------------------------------------------

cat("k) QUANTIDADES RESUMO PUBLICADAS\n")
cat(rep("-", 80), "\n", sep = "")

quantidades <- data.frame(
  Tipo = c(
    "Proporções (percentuais)",
    "Totais (números absolutos)",
    "Margens de erro amostral"
  ),
  Exemplo = c(
    "Percentual de domicílios com acesso à Internet por região",
    "Número total de domicílios com computador no Brasil",
    "Margem de erro para cada estimativa publicada"
  )
)

print(kable(quantidades, 
            format = "simple",
            col.names = c("Tipo de Estimativa", "Exemplo")))

cat("\nDomínios de divulgação:\n")
cat("  - Área (urbana/rural)\n")
cat("  - Região geográfica (Norte, Nordeste, Sudeste, Sul, Centro-Oeste)\n")
cat("  - Renda familiar (faixas de salário mínimo)\n")
cat("  - Classe social (A, B, C, DE)\n")
cat("  - Sexo (Masculino, Feminino)\n")
cat("  - Grau de instrução\n")
cat("  - Faixa etária\n")
cat("  - Condição de atividade (PEA, não PEA)\n\n")


# l) Disponibilidade da documentação -------------------------------------------

cat("l) DISPONIBILIDADE DA DOCUMENTAÇÃO\n")
cat(rep("-", 80), "\n", sep = "")

disponibilidade <- "SIM, foi possível responder todas as perguntas utilizando 
a documentação disponível no site do CETIC.br, especificamente o Relatório 
Metodológico da TIC Domicílios 2017 e a página institucional da pesquisa.

COMENTÁRIOS:
- A documentação é bastante completa e bem estruturada
- O relatório metodológico fornece detalhes técnicos sobre todos os aspectos
- A navegação no site é clara, com seções específicas para metodologia
- Não houve dificuldades significativas para localizar as informações
- A transparência metodológica do CETIC.br facilita o entendimento"

cat(strwrap(disponibilidade, width = 78), sep = "\n")
cat("\n")


# Criar resumo em tabela -------------------------------------------------------

cat("\n")
cat("================================================================================\n")
cat("RESUMO DAS CARACTERÍSTICAS DA PESQUISA TIC DOMICÍLIOS 2017\n")
cat("================================================================================\n\n")

resumo_pesquisa <- data.frame(
  Caracteristica = c(
    "Objetivo",
    "População-alvo",
    "Cadastro principal",
    "Tipo de pesquisa",
    "Plano amostral",
    "Periodicidade",
    "Método de coleta",
    "Período de coleta (2017)",
    "Tamanho da amostra",
    "Estimativas publicadas"
  ),
  Descricao = c(
    "Medir posse e uso das TIC",
    "Domicílios e população 10+ anos",
    "Setores censitários Censo 2010 IBGE",
    "Amostragem probabilística",
    "Estratificada de conglomerados (3-4 estágios)",
    "Anual (desde 2005)",
    "CAPI (entrevistas presenciais com tablet)",
    "Novembro de 2017",
    "~33.210 domicílios",
    "Proporções, totais e margens de erro"
  )
)

print(kable(resumo_pesquisa, 
            format = "simple",
            col.names = c("Característica", "Descrição")))


# Salvar resumo em CSV ---------------------------------------------------------

write.csv(
  resumo_pesquisa,
  file = file.path(output_dir, "resumo_tic_domicilios_2017.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

cat("\n")
cat("Resumo salvo em:", file.path(output_dir, "resumo_tic_domicilios_2017.csv"), "\n")


# Finalização ------------------------------------------------------------------

cat("\n")
cat("================================================================================\n")
cat("ANÁLISE CONCLUÍDA COM SUCESSO!\n")
cat("================================================================================\n")
cat("\n")
cat("Fonte: CETIC.br (2018). Relatório Metodológico da Pesquisa TIC Domicílios 2017.\n")
cat("Disponível em: https://cetic.br/\n")
cat("\n")

################################################################################
# FIM DO SCRIPT
################################################################################
