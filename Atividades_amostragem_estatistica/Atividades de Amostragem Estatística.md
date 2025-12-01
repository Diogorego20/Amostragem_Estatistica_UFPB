# Atividades de Amostragem Estatística

[![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)](https://www.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📋 Sobre o Projeto

Este repositório contém as soluções completas e detalhadas dos exercícios dos Capítulos 2 e 3 do livro **"Amostragem: Teoria e Prática usando R"**, desenvolvidas como atividade complementar de estudo para a disciplina de Amostragem Estatística.

**Período:** 24/11/2025 - 24/11/2025  
**Instituição:** UFPB (Universidade Federal da Paraíba)  
**Contexto:** Atividade realizada durante o ENCONTRO UNIFICADO 2025

## 🎯 Objetivos

- Aplicar conceitos fundamentais de amostragem probabilística
- Analisar metodologias de pesquisas por amostragem reais (TIC Domicílios)
- Implementar estimadores estatísticos (Horvitz-Thompson)
- Comparar eficiência de diferentes planos amostrais
- Desenvolver habilidades de programação estatística em R

## 📚 Conteúdo

### Capítulo 2: Conceitos e Cadastros

**Exercício 2.1 - Análise da Pesquisa TIC Domicílios 2017**
- Análise metodológica completa da pesquisa CETIC.br
- Identificação de população-alvo, cadastros e unidades de análise
- Documentação de procedimentos de coleta e estimação

**Exercício 2.2 - Planejamento de Pesquisa com Estudantes**
- Avaliação de cadastros disponíveis
- Análise de erros de cobertura
- Recomendações de estratégias de amostragem

### Capítulo 3: Visão Geral da Amostragem e Estimação

**Exercício 3.1 - População de Domicílios**
- Cálculo de parâmetros populacionais
- Enumeração de amostras possíveis
- Implementação do estimador Horvitz-Thompson
- Comparação de dois planos amostrais (A e B)
- Análise de eficiência e variância
- Visualizações comparativas

## 🗂️ Estrutura do Repositório

```
Atividades_amostragem_estatistica/
│
├── README.md                          # Este arquivo
├── LICENSE                            # Licença MIT
│
├── scripts/                           # Scripts R
│   ├── capitulo2_exercicio2.1.R      # Análise TIC Domicílios
│   ├── capitulo2_exercicio2.2.R      # Planejamento de pesquisa
│   ├── capitulo3_exercicio3.1.R      # População de domicílios
│   └── utils.R                        # Funções auxiliares
│
├── docs/                              # Documentação detalhada
│   ├── solucoes_capitulo2.md         # Soluções Capítulo 2
│   ├── solucoes_capitulo3.md         # Soluções Capítulo 3
│   └── metodologia_tic_domicilios.md # Análise metodológica
│
├── output/                            # Resultados gerados
│   ├── figuras/                       # Gráficos e visualizações
│   │   └── comparacao_planos.png
│   └── tabelas/                       # Tabelas de resultados
│       └── resultados_exercicio3.1.csv
│
└── data/                              # Dados utilizados
    └── populacao_domicilios.csv       # Dados do Exercício 3.1
```

## 🚀 Como Usar

### Pré-requisitos

```r
# Instalar pacotes necessários
install.packages(c("tidyverse", "knitr", "kableExtra", "ggplot2"))
```

### Executando os Scripts

```r
# Definir diretório de trabalho
setwd("caminho/para/Atividades_amostragem_estatistica")

# Executar script do Exercício 3.1
source("scripts/capitulo3_exercicio3.1.R")

# Ou executar todos os scripts
source("scripts/capitulo2_exercicio2.1.R")
source("scripts/capitulo2_exercicio2.2.R")
source("scripts/capitulo3_exercicio3.1.R")
```

## 📊 Principais Resultados

### Exercício 2.1: TIC Domicílios 2017

- **População-alvo:** Domicílios particulares permanentes e população com 10+ anos
- **Cadastro:** Setores censitários do Censo 2010 (IBGE)
- **Método:** Amostragem estratificada de conglomerados em múltiplos estágios
- **Coleta:** CAPI (entrevistas presenciais com tablets)
- **Periodicidade:** Anual desde 2005

### Exercício 3.1: Comparação de Planos Amostrais

| Característica | Plano A | Plano B |
|----------------|---------|---------|
| Amostras | 15 | 5 |
| E[T̂] | R$ 10.000 | R$ 10.000 |
| Var[T̂] | 22.160.000 | 7.660.000 |
| Redução de Variância | - | **65,43%** |

**Conclusão:** Plano B é 65% mais eficiente que Plano A, demonstrando a importância de probabilidades desiguais de inclusão.

## 📖 Referências

- Silva, P. L. N., Pessoa, D. G. C., & Lila, M. F. (2002). **Análise Estatística de Dados da PNAD: Incorporando a Estrutura do Plano Amostral**. Ciência & Saúde Coletiva.

- Bolfarine, H., & Bussab, W. O. (2005). **Elementos de Amostragem**. São Paulo: Blucher.

- CETIC.br (2018). **Pesquisa sobre o uso das tecnologias de informação e comunicação nos domicílios brasileiros - TIC Domicílios 2017**. Disponível em: https://cetic.br/

- Livro online: **Amostragem: Teoria e Prática usando R**. Disponível em: https://amostragemcomr.github.io/livro/

## 👨‍💻 Autor

**Diogo Rego**  
Estudante de Estatística - UFPB

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🤝 Contribuições

Contribuições, issues e feature requests são bem-vindos! Sinta-se à vontade para verificar a [página de issues](https://github.com/Diogorego20/Atividades_amostragem_estatistica/issues).

## ⭐ Agradecimentos

- Professor(a) da disciplina de Amostragem Estatística
- Autores do livro "Amostragem: Teoria e Prática usando R"
- CETIC.br pela disponibilização da documentação metodológica
- Comunidade R pela excelência das ferramentas estatísticas

---

**Desenvolvido com 💙 para a comunidade estatística**
