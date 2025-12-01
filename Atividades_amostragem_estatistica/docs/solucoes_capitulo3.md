# Soluções Detalhadas - Capítulo 3: Visão Geral da Amostragem e Estimação

**Autor:** Diogo Rego  
**Data:** 24/11/2025  
**Fonte:** Livro "Amostragem: Teoria e Prática usando R"

---

## Exercício 3.1 - População de Domicílios

Este documento detalha a resolução do Exercício 3.1, que aborda uma população de N=6 domicílios. O exercício explora o cálculo de parâmetros populacionais, a enumeração de amostras possíveis, a implementação do estimador Horvitz-Thompson e a comparação de dois planos amostrais.

### Dados da População

| Domicílio | Renda (R$) | Moradores | Trabalhadores |
|:---------:|:----------:|:---------:|:-------------:|
| 1         | 800        | 2         | 2             |
| 2         | 4.200      | 4         | 3             |
| 3         | 1.600      | 2         | 1             |
| 4         | 500        | 2         | 1             |
| 5         | 900        | 4         | 2             |
| 6         | 2.000      | 1         | 1             |
| **Total** | **10.000** | **15**    | **10**        |

---

### QUESTÃO 1: Parâmetros Populacionais

| Variável | Total | Média | Variância | Desvio Padrão |
| :--- | :--- | :--- | :--- | :--- |
| **Renda (R$)** | 10.000,00 | 1.666,67 | 1.722.222,22 | 1.312,33 |
| **Moradores** | 15 | 2,50 | 1,25 | 1,12 |
| **Trabalhadores** | 10 | 1,67 | 0,56 | 0,75 |

---

### QUESTÃO 2: Conjunto S de Amostras Possíveis (n=2)

O número total de amostras possíveis de tamanho 2 (sem reposição) é C(6,2) = 15. O conjunto S completo é:

(1,2), (1,3), (1,4), (1,5), (1,6), (2,3), (2,4), (2,5), (2,6), (3,4), (3,5), (3,6), (4,5), (4,6), (5,6)

---

### QUESTÃO 3: Plano Amostral A (Equiprovável)

Neste plano, todas as 15 amostras têm probabilidade igual de serem selecionadas: p(s) = 1/15.

- **Probabilidades de inclusão (π_i):** π_i = 5/15 = 1/3 ≈ 0,3333 para todos i.
- **Probabilidades de pares (π_ij):** π_ij = 1/15 ≈ 0,0667 para todos os pares i ≠ j.

**Estimador Horvitz-Thompson (Renda):**

| Amostra | Estimativa HT (R$) |
|:-------:|:------------------:|
| (1,2)   | 15.000,00          |
| (1,3)   | 7.200,00           |
| ...     | ...                |
| (5,6)   | 8.700,00           |

- **Valor Esperado E[T̂_HT]:** R$ 10.000,00 (não viciado)
- **Variância Var[T̂_HT]:** 22.160.000,00

---

### QUESTÃO 4: Plano Amostral B (5 amostras específicas)

Neste plano, o conjunto de amostras é S_B = {(1,2), (2,3), (2,4), (2,5), (2,6)}, com p(s) = 1/5.

- **Probabilidades de inclusão (π_i):**
  - π_1 = 0,20
  - π_2 = 1,00 (certeza!)
  - π_3 = 0,20
  - π_4 = 0,20
  - π_5 = 0,20
  - π_6 = 0,20

**Estimador Horvitz-Thompson (Renda):**

| Amostra | Estimativa HT (R$) |
|:-------:|:------------------:|
| (1,2)   | 8.200,00           |
| (2,3)   | 12.200,00          |
| (2,4)   | 6.700,00           |
| (2,5)   | 8.700,00           |
| (2,6)   | 14.200,00          |

- **Valor Esperado E[T̂_HT]:** R$ 10.000,00 (não viciado)
- **Variância Var[T̂_HT]:** 7.660.000,00

---

### QUESTÃO 5: Gráficos Comparativos

![Comparação dos Planos Amostrais](../output/figuras/comparacao_planos_amostrais.png)

O gráfico mostra que a distribuição das estimativas do Plano B é muito mais concentrada em torno do valor real (R$ 10.000) do que a do Plano A, indicando maior precisão.

---

### QUESTÃO 6: Comparação e Recomendação

| Característica | Plano A | Plano B |
|:---|:---|:---|
| **Viés** | R$ 0,00 | R$ 0,00 |
| **Variância** | 22.160.000,00 | 7.660.000,00 |
| **Redução de Variância** | - | **65,43%** |

**Análise:**
- **Não viciamento:** Ambos os planos são não viciados.
- **Precisão:** O Plano B é substancialmente mais preciso, com uma variância 65,43% menor que a do Plano A.

**Por que o Plano B é mais eficiente?**
O Plano B é mais eficiente porque concentra a amostragem em torno do domicílio 2, que possui a maior renda (R$ 4.200). Este domicílio é incluído com certeza (π_2 = 1,0) em todas as amostras do Plano B, o que reduz drasticamente a variabilidade das estimativas.

**RECOMENDAÇÃO: PLANO B É PREFERÍVEL**

**Justificativa:** Embora ambos os planos sejam não viciados, o Plano B oferece estimativas muito mais precisas (menor variância) para o total da renda. A redução de 65% na variância representa um ganho substancial de eficiência estatística, resultando em intervalos de confiança mais estreitos e estimativas mais confiáveis.

---
