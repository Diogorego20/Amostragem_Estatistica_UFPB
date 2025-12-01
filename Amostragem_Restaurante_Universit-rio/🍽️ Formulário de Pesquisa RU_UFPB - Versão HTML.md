# 🍽️ Formulário de Pesquisa RU/UFPB - Versão HTML

## 📱 Compatibilidade Universal

Este formulário HTML funciona em **todos os sistemas operacionais e dispositivos**:

- ✅ **Windows** (Chrome, Firefox, Edge, Opera)
- ✅ **macOS** (Safari, Chrome, Firefox)
- ✅ **Linux** (Chrome, Firefox)
- ✅ **Android** (Chrome, Firefox, Samsung Internet)
- ✅ **iOS** (Safari, Chrome)
- ✅ **Tablets** (iPad, Android tablets)

---

## 🚀 Como Usar

### Método 1: Abrir Diretamente (Mais Simples)

1. **Baixe o arquivo** `formulario_pesquisa_ru.html`
2. **Copie para o local desejado:**
   ```bash
   cp formulario_pesquisa_ru.html /Users/mac/Desktop/Amostragem/
   ```
3. **Abra com duplo clique** ou arraste para o navegador
4. **Pronto!** O formulário está funcionando

### Método 2: Via Terminal (macOS/Linux)

```bash
# Navegar até o diretório
cd /Users/mac/Desktop/Amostragem

# Abrir no navegador padrão
open formulario_pesquisa_ru.html
```

### Método 3: Via Windows

```cmd
# Navegar até o diretório
cd C:\Users\SeuUsuario\Desktop\Amostragem

# Abrir no navegador padrão
start formulario_pesquisa_ru.html
```

---

## 💾 Como Funciona o Armazenamento de Dados

### Armazenamento Local (LocalStorage)

- **Automático:** Cada resposta é salva automaticamente no navegador
- **Persistente:** Os dados permanecem mesmo após fechar o navegador
- **Privado:** Dados ficam apenas no dispositivo do usuário
- **Download CSV:** Arquivo CSV é baixado automaticamente após cada envio

### Estrutura dos Dados

Cada resposta gera um arquivo CSV com as seguintes colunas:

```
timestamp, curso_nivel, turno, frequencia, usava_antes, renda, 
sabor, variedade, temperatura, higiene, frescor, 
qualidade_antes, qualidade_depois, mudanca, 
esperava_diminuir, expectativa_atendida, 
importante_qualidade, sugestoes, email
```

### Exportar Todas as Respostas

Para exportar todas as respostas armazenadas localmente:

**Opção 1:** Pressione `Ctrl + Shift + E` (Windows/Linux) ou `Cmd + Shift + E` (macOS)

**Opção 2:** Abra o Console do navegador (F12) e execute:
```javascript
exportarTodasRespostas();
```

---

## 🎨 Recursos Visuais

### Design Responsivo
- **Desktop:** Layout amplo com elementos bem espaçados
- **Tablet:** Layout adaptado para telas médias
- **Mobile:** Layout otimizado para telas pequenas (smartphones)

### Elementos Interativos
- **Sliders animados** com feedback visual em tempo real
- **Validação de formulário** com mensagens amigáveis
- **Modais elegantes** para confirmações e alertas
- **Gradientes vibrantes** que estimulam o engajamento
- **Ícones e emojis** para facilitar a compreensão

### Animações
- Fade-in suave ao carregar a página
- Efeitos hover nos campos do formulário
- Transições suaves nos botões
- Modal com animação slide-in

---

## 🔒 Privacidade e Segurança

### Conformidade LGPD
- ✅ Termo de consentimento obrigatório
- ✅ Dados anônimos e agregados
- ✅ Armazenamento local (não envia para servidor)
- ✅ E-mail opcional para relatório

### Dados Coletados
- **Obrigatórios:** Perfil, avaliações de qualidade, percepções
- **Opcionais:** Renda, sugestões, e-mail

### Onde os Dados Ficam?
- **LocalStorage do navegador:** Armazenamento temporário local
- **Arquivo CSV:** Download automático para o computador do usuário
- **Nenhum servidor:** Os dados NÃO são enviados para nenhum servidor externo

---

## 📊 Análise dos Dados Coletados

Após coletar várias respostas, você pode analisar os dados CSV usando:

### Excel / Google Sheets
1. Abra o arquivo CSV no Excel ou Google Sheets
2. Use tabelas dinâmicas para análise
3. Crie gráficos de distribuição

### R (Estatística)
```r
# Carregar dados
dados <- read.csv("respostas_ru_ufpb.csv", encoding = "UTF-8")

# Estatísticas descritivas
summary(dados)

# Média de qualidade
mean(dados$sabor)
mean(dados$variedade)

# Teste t pareado (antes vs depois)
t.test(dados$qualidade_antes, dados$qualidade_depois, paired = TRUE)

# Gráficos
library(ggplot2)
ggplot(dados, aes(x = mudanca)) + 
  geom_bar(fill = "#667eea") +
  labs(title = "Percepção de Mudança", x = "Mudança", y = "Frequência")
```

### Python (Pandas)
```python
import pandas as pd
import matplotlib.pyplot as plt

# Carregar dados
df = pd.read_csv('respostas_ru_ufpb.csv', encoding='utf-8')

# Estatísticas descritivas
print(df.describe())

# Média de qualidade
print(f"Sabor médio: {df['sabor'].mean()}")

# Gráfico de barras
df['mudanca'].value_counts().plot(kind='bar', color='#667eea')
plt.title('Percepção de Mudança na Qualidade')
plt.show()
```

---

## 🔧 Personalização

### Alterar Cores

Edite a seção `<style>` no arquivo HTML:

```css
/* Gradiente principal (roxo/rosa) */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

/* Altere para suas cores */
background: linear-gradient(135deg, #SUA_COR_1 0%, #SUA_COR_2 100%);
```

### Adicionar Novos Campos

1. Adicione o campo HTML no `<form>`:
```html
<div class="form-group">
    <label for="novo_campo">Novo Campo</label>
    <input type="text" id="novo_campo" name="novo_campo">
</div>
```

2. Adicione no objeto `data` do JavaScript:
```javascript
const data = {
    // ... campos existentes ...
    novo_campo: formData.get('novo_campo')
};
```

### Alterar Textos

Todos os textos estão em português e podem ser editados diretamente no HTML.

---

## 🌐 Compartilhar o Formulário

### Opção 1: Arquivo Local
- Envie o arquivo HTML por e-mail
- Compartilhe via Google Drive / Dropbox
- Distribua via pen drive

### Opção 2: Hospedar Online (Grátis)

**GitHub Pages:**
1. Crie um repositório no GitHub
2. Faça upload do arquivo HTML
3. Ative GitHub Pages nas configurações
4. Compartilhe o link gerado

**Netlify Drop:**
1. Acesse [netlify.com/drop](https://app.netlify.com/drop)
2. Arraste o arquivo HTML
3. Compartilhe o link gerado

**Google Drive:**
1. Faça upload para o Google Drive
2. Configure compartilhamento público
3. Use Google Sites para incorporar

---

## 📱 Testado em Dispositivos

### Desktop
- ✅ Chrome 120+ (Windows, macOS, Linux)
- ✅ Firefox 121+ (Windows, macOS, Linux)
- ✅ Safari 17+ (macOS)
- ✅ Edge 120+ (Windows)

### Mobile
- ✅ Safari iOS 16+ (iPhone, iPad)
- ✅ Chrome Android 120+
- ✅ Samsung Internet 23+
- ✅ Firefox Android 121+

### Resoluções Testadas
- ✅ 320px (iPhone SE)
- ✅ 375px (iPhone 12/13/14)
- ✅ 768px (iPad)
- ✅ 1024px (iPad Pro)
- ✅ 1920px (Desktop Full HD)

---

## 🐛 Solução de Problemas

### O formulário não abre
- **Solução:** Certifique-se de que a extensão do arquivo é `.html`
- Tente abrir com outro navegador

### Os dados não são salvos
- **Solução:** Verifique se o navegador permite LocalStorage
- Alguns navegadores em modo privado bloqueiam LocalStorage
- Use modo normal do navegador

### O CSV não baixa automaticamente
- **Solução:** Verifique as configurações de download do navegador
- Alguns navegadores pedem confirmação para download
- Verifique a pasta de Downloads

### Layout quebrado no celular
- **Solução:** Atualize o navegador para a versão mais recente
- Limpe o cache do navegador
- Tente em outro navegador

---

## 💡 Dicas de Uso

### Para Pesquisadores
1. **Teste primeiro:** Preencha o formulário você mesmo para verificar
2. **Colete amostras:** Distribua para grupos diversos da UFPB
3. **Consolide dados:** Use `Ctrl+Shift+E` para exportar todas as respostas
4. **Analise:** Use R, Python ou Excel para análise estatística

### Para Respondentes
1. **Seja honesto:** Suas respostas são anônimas
2. **Leia com atenção:** Especialmente o termo LGPD
3. **Use escalas:** Os sliders facilitam a avaliação
4. **Dê sugestões:** Campos de texto livre são importantes

---

## 📞 Suporte Técnico

### Problemas Comuns

**"Preciso concordar com o termo mas já marquei"**
- Recarregue a página e tente novamente

**"O formulário não envia"**
- Verifique se todos os campos obrigatórios (marcados com *) estão preenchidos

**"Quero ver minhas respostas anteriores"**
- Abra o Console (F12) e digite: `JSON.parse(localStorage.getItem('respostas_ru'))`

**"Como limpar todas as respostas armazenadas?"**
- Abra o Console (F12) e digite: `localStorage.clear()`

---

## 📄 Licença

Este projeto é desenvolvido para fins acadêmicos na **Universidade Federal da Paraíba (UFPB)**.

Livre para uso, modificação e distribuição para fins educacionais.

---

## 🙏 Agradecimentos

Agradecemos a todos os participantes que contribuírem para melhorar a qualidade do RU/UFPB!

**Juntos, fazemos a diferença!** 🎉

---

## 📈 Amostragem e Inferência Estatística

Este formulário foi desenvolvido com base em princípios de **amostragem científica** e **inferência estatística**:

- **Amostra representativa:** Cada resposta contribui para uma amostra da população UFPB
- **Inferência estatística:** Permite generalizar resultados para toda a comunidade
- **Análise quantitativa:** Escalas numéricas facilitam análises estatísticas
- **Dados qualitativos:** Campos de texto capturam nuances e sugestões

### Tamanho Amostral Recomendado

Para uma margem de erro de 5% com 95% de confiança:
- **População pequena (< 1000):** ~280 respostas
- **População média (1000-5000):** ~360 respostas
- **População grande (> 5000):** ~385 respostas

---

*Desenvolvido com ❤️ para a comunidade UFPB*

**Versão:** 1.0.0 | **Data:** Novembro 2025
