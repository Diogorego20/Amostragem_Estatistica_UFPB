# Soluções Detalhadas - Capítulo 2: Conceitos e Cadastros

**Autor:** Diogo Rego  
**Data:** 24/11/2025  
**Fonte:** Livro "Amostragem: Teoria e Prática usando R"

---

## Exercício 2.1 - Análise da Pesquisa TIC Domicílios 2017

Este documento detalha a análise metodológica da Pesquisa TIC Domicílios 2017, realizada pelo Comitê Gestor da Internet no Brasil (CGI.br) através do Centro Regional de Estudos para o Desenvolvimento da Sociedade da Informação (Cetic.br).

### a) Qual é o objetivo da pesquisa?

O objetivo principal da pesquisa TIC Domicílios é **medir a posse e o uso das tecnologias de informação e comunicação (TIC) entre a população residente no Brasil com idade de 10 anos ou mais**. A pesquisa busca mapear o acesso às TIC nos domicílios urbanos e rurais do Brasil, bem como suas formas de uso por indivíduos, gerando indicadores para a formulação de políticas públicas.

### b) Qual é a população alvo? Qual é a população de pesquisa?

- **População-alvo:** A população-alvo da pesquisa é composta por **domicílios particulares permanentes brasileiros** e pela **população com 10 anos de idade ou mais residente em domicílios particulares permanentes no Brasil**.

- **População de pesquisa:** A população de pesquisa coincide com a população alvo. Não há menção no relatório metodológico de exclusões significativas que diferenciem a população de pesquisa da população alvo. A pesquisa abrange todo o território nacional, incluindo áreas urbanas e rurais.

### c) Qual é o principal cadastro utilizado?

O principal cadastro utilizado para o desenho amostral da pesquisa TIC Domicílios é a **base de setores censitários do Censo Demográfico 2010 do IBGE** (Instituto Brasileiro de Geografia e Estatística).

### d) Quais são as unidades de referência?

A pesquisa possui duas unidades de referência, que são os elementos sobre os quais se deseja obter informação:

1.  **Domicílios particulares permanentes**
2.  **População residente com 10 anos de idade ou mais**

### e) Quais são as unidades informantes?

As unidades informantes são os **moradores dos domicílios selecionados**, especificamente indivíduos com 10 anos ou mais de idade que respondem ao questionário durante a entrevista presencial.

### f) Quais são as unidades de análise?

A pesquisa possui duas unidades de análise, que são as unidades para as quais os resultados são divulgados:

1.  **Domicílios particulares permanentes**
2.  **Indivíduos com 10 anos de idade ou mais residentes nesses domicílios**

### g) Quais são as unidades de amostragem?

As unidades de amostragem variam conforme o estágio do plano amostral, que é de múltiplos estágios:

- **Primeiro estágio:** Municípios (quando não selecionados com certeza) ou setores censitários (em municípios grandes)
- **Segundo estágio:** Setores censitários
- **Terceiro estágio:** Domicílios particulares permanentes
- **Quarto estágio:** Indivíduos (moradores com 10 anos ou mais)

### h) Qual é o tipo de pesquisa?

É uma **pesquisa por amostragem probabilística**. Especificamente, utiliza amostragem estratificada de conglomerados em múltiplos estágios.

### i) Como a pesquisa se desenvolve no tempo?

A pesquisa TIC Domicílios é uma **pesquisa repetida com periodicidade anual**. Ela é realizada anualmente desde 2005, permitindo o acompanhamento da evolução do acesso e uso das TIC no Brasil ao longo do tempo.

### j) Como são coletados os dados?

Os dados são coletados por meio de **entrevistas presenciais** (face a face) nos domicílios selecionados. O método utilizado é o **CAPI** (Computer-Assisted Personal Interviewing), onde entrevistadores aplicam questionários estruturados programados em tablets. O período de coleta da edição 2017 foi em **novembro de 2017**.

### k) Para que tipos de quantidades resumo são publicadas estimativas?

A pesquisa publica estimativas de:

- **Proporções (percentuais):** Ex: percentual de domicílios com acesso à Internet.
- **Totais (números absolutos):** Ex: número total de domicílios com computador.
- **Margens de erro amostral:** Para cada estimativa publicada.

### l) Foi possível responder todas as perguntas só com a documentação disponível?

**Sim, foi possível responder todas as perguntas** utilizando a documentação disponível no site do CETIC.br. O relatório metodológico é completo e bem estruturado, fornecendo detalhes técnicos sobre todos os aspectos da pesquisa. A transparência metodológica do CETIC.br facilita o entendimento da pesquisa.

---

## Exercício 2.2 - Planejamento de Pesquisa com Estudantes

### Contexto

Pesquisa por amostragem com estudantes do ensino fundamental regular (EFR) matriculados em escolas públicas municipais no Rio de Janeiro. Coleta prevista: setembro-outubro de 2019.

**Cadastros disponíveis:**
- **Cadastro A:** Censo Escolar do MEC (ano calendário 2018)
- **Cadastro B:** Lista de escolas públicas municipais da Prefeitura (atualizada até agosto 2019)

### 1. Tipo de associação entre unidades do cadastro e unidades de referência

- **Cadastro A (Censo Escolar 2018):** Associação indireta com defasagem temporal de aproximadamente 1,5 ano. O cadastro contém estudantes de 2018, enquanto a pesquisa é em 2019. Há problemas de cobertura (subcobertura de novos alunos e sobrecobertura de alunos que saíram).

- **Cadastro B (Lista de escolas 2019):** Associação indireta através de conglomerados (escolas). O cadastro lista escolas, que são as unidades primárias de amostragem (UPAs), e não os estudantes. A atualização é recente, minimizando problemas de cobertura das escolas.

### 2. Vantagens e desvantagens de cada cadastro

| Característica | Cadastro A (Censo 2018) | Cadastro B (Lista de Escolas 2019) |
| :--- | :--- | :--- |
| **Atualização** | Desatualizado (2018) | Atualizado (ago/2019) |
| **Cobertura** | Completa mas defasada | Atual de escolas, mas não de alunos |
| **Informações** | Detalhadas sobre alunos | Apenas sobre escolas |
| **Seleção direta** | Sim (com atualização) | Não (requer arrolamento) |
| **Custo/Complexidade** | Médio | Alto (devido ao arrolamento) |

### 3. Cuidados ao optar pelo Cadastro A

Para mitigar os erros de cobertura, seria necessário:

1.  **Atualização do cadastro:** Contatar as escolas para verificar quais alunos ainda estão matriculados e obter listas atualizadas.
2.  **Procedimentos de substituição:** Estabelecer regras claras para substituição de alunos não localizados e usar uma amostra de reserva (oversample).
3.  **Verificação em campo:** Confirmar a presença do aluno na escola antes da entrevista.

### 4. Procedimentos ao optar pelo Cadastro B

Para assegurar a cobertura da população de interesse, seria necessário:

1.  **Amostragem em múltiplos estágios:** Selecionar uma amostra de escolas (1º estágio), realizar o arrolamento completo dos alunos em cada escola (2º estágio) e, por fim, selecionar uma amostra de alunos (3º estágio).
2.  **Arrolamento dos estudantes:** Solicitar à direção de cada escola selecionada a lista completa e atualizada de alunos matriculados.
3.  **Coordenação com as escolas:** Estabelecer contato prévio com os diretores para obter autorização e agendar visitas.

### 5. Recomendação: Como usar um ou mais dos cadastros

A **abordagem recomendada é o uso combinado dos dois cadastros** para maximizar a eficiência e minimizar os erros.

**Estratégia Proposta:**

1.  **Fase 1 - Seleção de escolas:** Utilizar o **Cadastro B** (lista de escolas da Prefeitura) como base para a seleção das escolas, pois está atualizado e garante cobertura adequada das escolas em funcionamento.
2.  **Fase 2 - Informações auxiliares:** Utilizar o **Cadastro A** (Censo Escolar 2018) para obter informações sobre o tamanho aproximado das escolas (número de alunos), o que é útil para a seleção com probabilidade proporcional ao tamanho (PPT).
3.  **Fase 3 - Arrolamento atualizado:** Realizar o arrolamento completo e atualizado dos alunos nas escolas selecionadas, obtendo a lista diretamente das escolas em setembro de 2019.
4.  **Fase 4 - Seleção de alunos:** Selecionar a amostra de alunos a partir das listas atualizadas obtidas nas escolas.

**Vantagens desta abordagem:**
- Minimiza erros de cobertura usando um cadastro atualizado de escolas.
- Permite um planejamento amostral eficiente usando informações do Censo Escolar.
- Garante a seleção de alunos efetivamente matriculados no momento da pesquisa.
- É flexível e adaptável a mudanças recentes no sistema educacional municipal.

---
