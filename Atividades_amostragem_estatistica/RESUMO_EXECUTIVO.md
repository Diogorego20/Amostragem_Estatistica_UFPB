# Resumo Executivo - Atividades de Amostragem Estatística

**Autor:** Diogo Rego  
**Instituição:** UFPB (Universidade Federal da Paraíba)  
**Data:** 24/11/2025  
**Contexto:** Atividade Complementar de Estudo nº 01 - ENCONTRO UNIFICADO 2025

---

## 📌 Visão Geral

Este projeto apresenta as soluções completas e detalhadas dos exercícios dos Capítulos 2 e 3 do livro **"Amostragem: Teoria e Prática usando R"**, implementadas em linguagem R com padrões profissionais de programação e documentação.

## 🎯 Objetivos Alcançados

### Capítulo 2: Conceitos e Cadastros

✅ **Exercício 2.1** - Análise metodológica completa da Pesquisa TIC Domicílios 2017 (CETIC.br)
- Identificação de população-alvo, cadastros e unidades de análise
- Documentação de procedimentos de coleta e periodicidade
- Análise de tipos de estimativas publicadas

✅ **Exercício 2.2** - Planejamento estratégico de pesquisa com estudantes
- Avaliação comparativa de dois cadastros disponíveis
- Análise de erros de cobertura e suas implicações
- Recomendação de estratégia combinada para maximizar eficiência

### Capítulo 3: Visão Geral da Amostragem e Estimação

✅ **Exercício 3.1** - Análise completa de população de 6 domicílios
- Cálculo de parâmetros populacionais (total, média, variância)
- Enumeração de todas as 15 amostras possíveis de tamanho 2
- Implementação do estimador Horvitz-Thompson
- Comparação de eficiência entre Plano A (equiprovável) e Plano B (específico)
- Demonstração de redução de 65% na variância usando probabilidades desiguais

## 📊 Principais Resultados

### Exercício 2.1: TIC Domicílios 2017

| Característica | Descrição |
|:---|:---|
| **População-alvo** | Domicílios particulares permanentes e população 10+ anos |
| **Cadastro** | Setores censitários do Censo 2010 (IBGE) |
| **Método** | Amostragem estratificada de conglomerados (3-4 estágios) |
| **Coleta** | CAPI (entrevistas presenciais com tablets) |
| **Periodicidade** | Anual desde 2005 |

### Exercício 2.2: Planejamento de Pesquisa

**Recomendação:** Uso combinado dos cadastros
- **Cadastro B** (Prefeitura) → Seleção de escolas (atualizado)
- **Cadastro A** (Censo Escolar) → Informações auxiliares para PPT
- **Arrolamento** → Garantir cobertura adequada dos estudantes

### Exercício 3.1: Comparação de Planos Amostrais

| Métrica | Plano A | Plano B | Ganho |
|:---|:---:|:---:|:---:|
| **Viés** | R$ 0,00 | R$ 0,00 | - |
| **Variância** | 22.160.000 | 7.660.000 | **-65,43%** |
| **CV** | 47,07% | 27,68% | **-41,15%** |

**Conclusão:** Plano B é substancialmente mais eficiente devido à inclusão estratégica do domicílio com maior renda (π_2 = 1,0).

## 💻 Estrutura Técnica

### Scripts R Desenvolvidos

1. **capitulo2_exercicio2.1.R** - Análise TIC Domicílios (220 linhas)
2. **capitulo2_exercicio2.2.R** - Planejamento de pesquisa (290 linhas)
3. **capitulo3_exercicio3.1.R** - População de domicílios (420 linhas)

### Características dos Scripts

- ✅ Documentação completa com cabeçalhos detalhados
- ✅ Funções modulares e reutilizáveis
- ✅ Comentários explicativos em português
- ✅ Formatação consistente e legível
- ✅ Geração automática de tabelas e gráficos
- ✅ Exportação de resultados em CSV
- ✅ Tratamento adequado de encoding (UTF-8)

### Pacotes R Utilizados

- `tidyverse` - Manipulação e visualização de dados
- `knitr` / `kableExtra` - Geração de tabelas formatadas
- `ggplot2` - Visualizações gráficas
- `scales` - Formatação de números
- `here` - Gerenciamento de caminhos

## 📁 Organização do Repositório

```
Atividades_amostragem_estatistica/
│
├── README.md                          # Documentação principal
├── LICENSE                            # Licença MIT
├── GUIA_PUBLICACAO_GITHUB.md         # Instruções de publicação
├── .gitignore                         # Arquivos ignorados pelo Git
│
├── scripts/                           # Scripts R
│   ├── capitulo2_exercicio2.1.R
│   ├── capitulo2_exercicio2.2.R
│   └── capitulo3_exercicio3.1.R
│
├── docs/                              # Documentação detalhada
│   ├── solucoes_capitulo2.md
│   └── solucoes_capitulo3.md
│
├── data/                              # Dados
│   └── populacao_domicilios.csv
│
└── output/                            # Resultados
    ├── figuras/                       # Gráficos
    └── tabelas/                       # Tabelas CSV
```

## 🎓 Aprendizados e Contribuições

### Conceitos Estatísticos Aplicados

1. **Não viciamento** - Independe do número de amostras, depende do plano e do estimador
2. **Eficiência** - Planos diferentes podem ter eficiências muito distintas
3. **Probabilidades desiguais** - Podem melhorar drasticamente a precisão
4. **Estimador Horvitz-Thompson** - Não viciado sob qualquer plano probabilístico

### Habilidades Desenvolvidas

- ✅ Análise metodológica de pesquisas reais
- ✅ Implementação de estimadores estatísticos
- ✅ Programação em R com boas práticas
- ✅ Documentação técnica profissional
- ✅ Visualização de dados estatísticos
- ✅ Versionamento com Git/GitHub

## 🚀 Como Usar Este Repositório

### 1. Clonar o Repositório

```bash
git clone https://github.com/Diogorego20/Atividades_amostragem_estatistica.git
cd Atividades_amostragem_estatistica
```

### 2. Instalar Pacotes R

```r
install.packages(c("tidyverse", "knitr", "kableExtra", "scales", "here"))
```

### 3. Executar os Scripts

```r
# Exercício 3.1 (recomendado começar por este)
source("scripts/capitulo3_exercicio3.1.R")

# Exercício 2.1
source("scripts/capitulo2_exercicio2.1.R")

# Exercício 2.2
source("scripts/capitulo2_exercicio2.2.R")
```

## 📚 Referências

1. Livro online: [Amostragem: Teoria e Prática usando R](https://amostragemcomr.github.io/livro/)
2. CETIC.br: [Pesquisa TIC Domicílios 2017](https://cetic.br/)
3. Bolfarine, H., & Bussab, W. O. (2005). *Elementos de Amostragem*. São Paulo: Blucher.

## 📞 Contato

**Diogo Rego**  
Estudante de Estatística - UFPB  
GitHub: [@Diogorego20](https://github.com/Diogorego20)

---

**Desenvolvido com dedicação para a comunidade estatística brasileira 💙**
