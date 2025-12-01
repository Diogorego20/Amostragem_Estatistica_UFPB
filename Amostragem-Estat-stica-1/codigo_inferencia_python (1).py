#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Análise Inferencial - Agricultura Familiar PB (Python)
Autor: Diogo Rego (modelo)
Descrição:
  - Realiza análise descritiva, estimação por IC e testes de hipóteses
  - Utiliza dados do frame integrado gerado pelo ETL
  - Gera relatório de análise em Markdown
"""

import pandas as pd
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime
from pathlib import Path

# Configurações
sns.set_style("whitegrid")
plt.rcParams['figure.figsize'] = (10, 6)
plt.rcParams['font.size'] = 11

# ============================================================================
# 1. CARREGAR DADOS
# ============================================================================

def carregar_dados(caminho):
    """Carrega o frame integrado gerado pelo ETL."""
    df = pd.read_csv(caminho, encoding='utf-8')
    print(f"✓ Dados carregados: {len(df)} observações")
    return df

# Substitua pelo caminho do seu frame integrado
dados = carregar_dados("dados/processed/frame_integrado.csv")

# ============================================================================
# 2. ANÁLISE DESCRITIVA
# ============================================================================

print("\n=== ANÁLISE DESCRITIVA ===")

# Estatísticas para variáveis numéricas
descritiva_numerica = dados[['renda_familiar_mensal', 'area_plantada_ha']].describe()
print("\nEstatísticas Descritivas (Variáveis Numéricas):")
print(descritiva_numerica)

# Tabela de frequências para variáveis categóricas
freq_credito = dados['usa_credito'].value_counts()
prop_credito = dados['usa_credito'].value_counts(normalize=True)

print("\nDistribuição de acesso a crédito:")
print(pd.DataFrame({
    'Frequência': freq_credito,
    'Proporção': prop_credito,
    'Percentual': prop_credito * 100
}))

# ============================================================================
# 3. ESTIMAÇÃO POR INTERVALO DE CONFIANÇA
# ============================================================================

print("\n=== ESTIMAÇÃO POR INTERVALO DE CONFIANÇA ===")

def ic_proporcao(x, N=None, nivel_confianca=0.95):
    """
    Calcula intervalo de confiança para proporção.
    
    Args:
        x: array binário (0/1, True/False)
        N: tamanho da população (se conhecido)
        nivel_confianca: nível de confiança (padrão 0.95)
    
    Returns:
        dict com estimativa, IC inferior, IC superior e margem de erro
    """
    n = len(x[~np.isnan(x)])
    p_hat = np.mean(x)
    
    # Valor crítico Z
    z = stats.norm.ppf((1 + nivel_confianca) / 2)
    
    # Erro padrão
    ep = np.sqrt(p_hat * (1 - p_hat) / n)
    
    # Correção para população finita (se N fornecido)
    if N is not None and N > 0:
        fpc = np.sqrt((N - n) / (N - 1))  # Fator de correção
        ep = ep * fpc
    
    # Margem de erro
    me = z * ep
    
    # Intervalo
    ic_inf = max(0, p_hat - me)
    ic_sup = min(1, p_hat + me)
    
    return {
        'estimativa': p_hat,
        'ic_inferior': ic_inf,
        'ic_superior': ic_sup,
        'margem_erro': me,
        'nivel_confianca': nivel_confianca
    }

# Exemplo: IC para proporção de agricultores com acesso a crédito
# Assumindo população de 100.000 agricultores familiares na PB
usa_credito_binario = (dados['usa_credito'] == 'Sim').astype(int).values
ic_credito = ic_proporcao(usa_credito_binario, N=100000, nivel_confianca=0.95)

print("\nIntervalo de Confiança (95%) para Acesso a Crédito:")
print(f"  Estimativa pontual: {ic_credito['estimativa']*100:.2f}%")
print(f"  IC: [{ic_credito['ic_inferior']*100:.2f}%, {ic_credito['ic_superior']*100:.2f}%]")
print(f"  Margem de erro: ±{ic_credito['margem_erro']*100:.2f}%")

def ic_media(x, N=None, nivel_confianca=0.95):
    """
    Calcula intervalo de confiança para média.
    
    Args:
        x: array numérico
        N: tamanho da população (se conhecido)
        nivel_confianca: nível de confiança (padrão 0.95)
    
    Returns:
        dict com estimativa, IC inferior, IC superior e margem de erro
    """
    x_clean = x[~np.isnan(x)]
    n = len(x_clean)
    media = np.mean(x_clean)
    dp = np.std(x_clean, ddof=1)
    
    # Graus de liberdade
    gl = n - 1
    t_critico = stats.t.ppf((1 + nivel_confianca) / 2, gl)
    
    # Erro padrão
    ep = dp / np.sqrt(n)
    
    # Correção para população finita
    if N is not None and N > 0:
        fpc = np.sqrt((N - n) / (N - 1))
        ep = ep * fpc
    
    # Margem de erro
    me = t_critico * ep
    
    # Intervalo
    ic_inf = media - me
    ic_sup = media + me
    
    return {
        'estimativa': media,
        'ic_inferior': ic_inf,
        'ic_superior': ic_sup,
        'margem_erro': me,
        'nivel_confianca': nivel_confianca
    }

# Exemplo: IC para renda média
ic_renda = ic_media(dados['renda_familiar_mensal'].values, N=100000, nivel_confianca=0.95)

print("\nIntervalo de Confiança (95%) para Renda Familiar Mensal:")
print(f"  Estimativa pontual: R$ {ic_renda['estimativa']:.2f}")
print(f"  IC: [R$ {ic_renda['ic_inferior']:.2f}, R$ {ic_renda['ic_superior']:.2f}]")

# ============================================================================
# 4. TESTES DE HIPÓTESES
# ============================================================================

print("\n=== TESTES DE HIPÓTESES ===")

# Exemplo 1: Teste T para comparar renda entre duas regiões
# H0: média_regiao_A = média_regiao_B
# H1: média_regiao_A ≠ média_regiao_B

regiao_A = dados[dados['regiao'] == 'Cariri']['renda_familiar_mensal'].dropna()
regiao_B = dados[dados['regiao'] == 'Litoral']['renda_familiar_mensal'].dropna()

teste_t = stats.ttest_ind(regiao_A, regiao_B, equal_var=False)

print("\nTeste T: Comparação de Renda entre Cariri e Litoral")
print(f"  Estatística t: {teste_t.statistic:.3f}")
print(f"  p-valor: {teste_t.pvalue:.4f}")

if teste_t.pvalue < 0.05:
    print("  Conclusão: Rejeita-se H0. Há diferença significativa entre as rendas.")
else:
    print("  Conclusão: Não se rejeita H0. Não há evidência de diferença significativa.")

# Exemplo 2: Teste de proporções (Qui-quadrado)
# H0: A proporção de uso de crédito é igual entre as regiões
# H1: A proporção de uso de crédito difere entre as regiões

tabela_contingencia = pd.crosstab(dados['regiao'], dados['usa_credito'])
teste_qui = stats.chi2_contingency(tabela_contingencia)

print("\nTeste Qui-quadrado: Uso de Crédito por Região")
print(f"  Estatística χ²: {teste_qui.statistic:.3f}")
print(f"  p-valor: {teste_qui.pvalue:.4f}")

if teste_qui.pvalue < 0.05:
    print("  Conclusão: Rejeita-se H0. O uso de crédito difere entre regiões.")
else:
    print("  Conclusão: Não se rejeita H0. Não há evidência de diferença.")

# ============================================================================
# 5. VISUALIZAÇÕES
# ============================================================================

print("\n=== GERANDO VISUALIZAÇÕES ===")

# Criar diretório para imagens
Path("docs/img").mkdir(parents=True, exist_ok=True)

# Gráfico 1: Distribuição de renda por região
plt.figure(figsize=(10, 6))
dados.boxplot(column='renda_familiar_mensal', by='regiao', grid=False)
plt.suptitle('')
plt.title('Distribuição de Renda Familiar por Região')
plt.xlabel('Região')
plt.ylabel('Renda Familiar Mensal (R$)')
plt.tight_layout()
plt.savefig('docs/img/renda_por_regiao.png', dpi=300, bbox_inches='tight')
print("✓ Gráfico salvo: docs/img/renda_por_regiao.png")
plt.close()

# Gráfico 2: Proporção de uso de crédito
plt.figure(figsize=(8, 6))
freq_df = pd.DataFrame({
    'Categoria': freq_credito.index,
    'Proporção': prop_credito.values
})
bars = plt.bar(freq_df['Categoria'], freq_df['Proporção'], alpha=0.8)
plt.title('Proporção de Agricultores com Acesso a Crédito')
plt.xlabel('Usa Crédito')
plt.ylabel('Proporção')
plt.ylim(0, 1)

# Adicionar percentuais nas barras
for bar in bars:
    height = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2., height,
             f'{height*100:.1f}%',
             ha='center', va='bottom')

plt.tight_layout()
plt.savefig('docs/img/uso_credito.png', dpi=300, bbox_inches='tight')
print("✓ Gráfico salvo: docs/img/uso_credito.png")
plt.close()

# ============================================================================
# 6. GERAR RELATÓRIO MARKDOWN
# ============================================================================

print("\n=== GERANDO RELATÓRIO ===")

# Preparar dados para o relatório
n_obs = len(dados)
renda_media = dados['renda_familiar_mensal'].mean()
renda_mediana = dados['renda_familiar_mensal'].median()
renda_dp = dados['renda_familiar_mensal'].std()
area_media = dados['area_plantada_ha'].mean()

freq_sim = freq_credito.get('Sim', 0)
freq_nao = freq_credito.get('Não', 0)
prop_sim = prop_credito.get('Sim', 0) * 100
prop_nao = prop_credito.get('Não', 0) * 100

conclusao_t = "Rejeita-se H₀. Há diferença significativa entre as rendas das duas regiões (p < 0.05)." if teste_t.pvalue < 0.05 else "Não se rejeita H₀. Não há evidência estatística de diferença significativa."

conclusao_qui = "Rejeita-se H₀. O uso de crédito difere significativamente entre as regiões (p < 0.05)." if teste_qui.pvalue < 0.05 else "Não se rejeita H₀. Não há evidência de diferença no uso de crédito entre regiões."

conclusao_renda = "Existem diferenças estatisticamente significativas na renda média entre as regiões do Cariri e do Litoral." if teste_t.pvalue < 0.05 else "Não foram encontradas diferenças significativas na renda média entre regiões."

conclusao_credito = "O acesso a crédito varia significativamente entre as regiões do estado." if teste_qui.pvalue < 0.05 else "O acesso a crédito é relativamente homogêneo entre as regiões."

relatorio = f"""# Relatório de Análise Inferencial

**Projeto:** Levantamento Amostral - Agricultura Familiar PB  
**Data:** {datetime.now().strftime('%d/%m/%Y')}  
**Autor:** Diogo Da Silva Rego

---

## 1. Resumo Executivo

Este relatório apresenta os resultados da análise inferencial realizada sobre os dados do levantamento amostral de agricultores familiares da Paraíba. A amostra compreende **{n_obs} observações** coletadas através do processo de integração de dados (ETL) descrito no manual técnico.

---

## 2. Análise Descritiva

### 2.1 Variáveis Numéricas

A renda familiar mensal média observada na amostra foi de **R$ {renda_media:.2f}**, com mediana de **R$ {renda_mediana:.2f}** e desvio padrão de **R$ {renda_dp:.2f}**. A área plantada média foi de **{area_media:.2f} hectares**.

### 2.2 Variáveis Categóricas

A distribuição de acesso a crédito rural na amostra foi:

| Usa Crédito | Frequência | Percentual |
|-------------|------------|------------|
| Sim         | {freq_sim} | {prop_sim:.1f}% |
| Não         | {freq_nao} | {prop_nao:.1f}% |

---

## 3. Estimação por Intervalo de Confiança

### 3.1 Proporção de Agricultores com Acesso a Crédito

Utilizando um estimador para populações finitas (N = 100.000) e considerando um nível de confiança de 95%, a proporção estimada de agricultores com acesso a crédito na população é:

- **Estimativa pontual:** {ic_credito['estimativa']*100:.2f}%
- **Intervalo de confiança (95%):** [{ic_credito['ic_inferior']*100:.2f}%, {ic_credito['ic_superior']*100:.2f}%]
- **Margem de erro:** ±{ic_credito['margem_erro']*100:.2f}%

**Interpretação:** Com 95% de confiança, estima-se que entre {ic_credito['ic_inferior']*100:.1f}% e {ic_credito['ic_superior']*100:.1f}% dos agricultores familiares da Paraíba têm acesso a crédito rural.

### 3.2 Renda Familiar Mensal Média

A renda familiar mensal média estimada para a população é:

- **Estimativa pontual:** R$ {ic_renda['estimativa']:.2f}
- **Intervalo de confiança (95%):** [R$ {ic_renda['ic_inferior']:.2f}, R$ {ic_renda['ic_superior']:.2f}]

---

## 4. Testes de Hipóteses

### 4.1 Comparação de Renda entre Regiões (Cariri vs. Litoral)

**Hipótese Nula (H₀):** A renda média no Cariri é igual à renda média no Litoral.  
**Hipótese Alternativa (H₁):** A renda média no Cariri é diferente da renda média no Litoral.

**Resultado do Teste T:**
- Estatística t: {teste_t.statistic:.3f}
- p-valor: {teste_t.pvalue:.4f}
- Conclusão: {conclusao_t}

### 4.2 Uso de Crédito por Região

**Hipótese Nula (H₀):** A proporção de uso de crédito é igual entre as regiões.  
**Hipótese Alternativa (H₁):** A proporção de uso de crédito difere entre as regiões.

**Resultado do Teste Qui-quadrado:**
- Estatística χ²: {teste_qui.statistic:.3f}
- p-valor: {teste_qui.pvalue:.4f}
- Conclusão: {conclusao_qui}

---

## 5. Visualizações

### 5.1 Distribuição de Renda por Região

![Renda por Região](img/renda_por_regiao.png)

### 5.2 Proporção de Uso de Crédito

![Uso de Crédito](img/uso_credito.png)

---

## 6. Conclusões e Recomendações

Os resultados da análise inferencial indicam que:

1. A proporção de agricultores com acesso a crédito na Paraíba está entre {ic_credito['ic_inferior']*100:.1f}% e {ic_credito['ic_superior']*100:.1f}% (IC 95%).
2. {conclusao_renda}
3. {conclusao_credito}

**Recomendações:**
- Expandir políticas de acesso a crédito para regiões com menor cobertura.
- Investigar as causas das disparidades regionais identificadas.
- Realizar estudos longitudinais para acompanhar a evolução desses indicadores.

---

**Desenvolvido por:** Diogo Da Silva Rego  
**Ferramentas:** Python 3.9+, pandas, scipy, matplotlib, seaborn
"""

with open('docs/relatorio_inferencia.md', 'w', encoding='utf-8') as f:
    f.write(relatorio)

print("✓ Relatório salvo: docs/relatorio_inferencia.md")

print("\n=== ANÁLISE CONCLUÍDA COM SUCESSO ===")
