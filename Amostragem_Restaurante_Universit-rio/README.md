🍽️ Pesquisa RU/UFPB - Qualidade Percebida

📊 Sobre o Projeto

Este é um aplicativo Shiny desenvolvido para coletar dados sobre a percepção de qualidade do Restaurante Universitário (RU) da UFPB, especialmente após a redução de preços. O projeto utiliza princípios de amostragem científica e inferência estatística para obter insights representativos da comunidade acadêmica.




✨ Principais Melhorias Implementadas

🎨 Design Jovial e Moderno

•
Gradientes vibrantes (roxo e rosa) para criar uma interface atraente

•
Animações suaves ao carregar e interagir com elementos

•
Tipografia moderna usando a fonte Poppins do Google Fonts

•
Ícones e emojis para facilitar a compreensão e engajamento

📈 Elementos de Amostragem e Inferência Estatística

•
Banner estatístico destacando a importância da amostragem científica

•
Seção informativa explicando como cada resposta contribui para a pesquisa

•
Mensagens motivacionais incentivando a participação

•
Feedback visual com escalas de qualidade claramente identificadas

🔒 Conformidade com LGPD

•
Termo de consentimento claro e destacado

•
Validação obrigatória do consentimento antes do envio

•
Informações transparentes sobre tratamento de dados

•
Opção de e-mail para receber relatório final

🎯 Experiência do Usuário

•
Validação inteligente de campos obrigatórios

•
Mensagens de erro amigáveis e informativas

•
Feedback de sucesso animado após envio

•
Design responsivo que funciona em diferentes dispositivos

•
Efeitos hover para melhor interatividade




🚀 Como Usar

Pré-requisitos

Certifique-se de ter instalado:

•
R (versão 4.0 ou superior)

•
RStudio (recomendado)

•
Pacotes R necessários:

•
shiny

•
shinyjs



Instalação dos Pacotes

Abra o R ou RStudio e execute:

Plain Text


install.packages("shiny")
install.packages("shinyjs")


Executando o Aplicativo

Opção 1: Via RStudio

1.
Abra o arquivo app.R no RStudio

2.
Clique no botão "Run App" no canto superior direito

3.
O aplicativo será aberto em uma nova janela ou no navegador

Opção 2: Via Terminal/Console R

Plain Text


setwd("/Users/mac/Desktop/Amostragem")
shiny::runApp("app.R")


Opção 3: Via Terminal do Sistema

Bash


cd /Users/mac/Desktop/Amostragem
R -e "shiny::runApp('app.R')"





📁 Estrutura do Projeto

Plain Text


Amostragem/
├── app.R                      # Aplicativo Shiny principal
├── README.md                  # Este arquivo
├── copiar_para_desktop.sh     # Script auxiliar (Linux/Mac)
└── respostas.csv             # Arquivo gerado com as respostas (criado automaticamente)





📋 Estrutura do Questionário

Seção A — Perfil do Respondente

•
Curso e nível (Graduação/Pós-graduação)

•
Turno predominante

•
Frequência de uso do RU

•
Uso anterior à redução de preço

•
Faixa de renda familiar (opcional)

Seção B — Avaliação de Qualidade (escala 1-5)

•
Sabor da comida

•
Variedade do cardápio

•
Temperatura adequada

•
Higiene e limpeza

•
Frescor dos ingredientes

Seção C — Comparação: Antes vs. Depois

•
Qualidade geral antes da redução

•
Qualidade geral depois da redução

•
Percepção de mudança

Seção D — Expectativas e Sugestões

•
Expectativa de diminuição da qualidade

•
Atendimento da expectativa

•
Aspectos mais importantes (texto livre)

•
Sugestões de melhoria (texto livre)

•
E-mail para receber relatório (opcional)




💾 Armazenamento de Dados

Os dados são salvos automaticamente em um arquivo CSV (respostas.csv) no mesmo diretório do aplicativo. O arquivo é criado na primeira resposta e as respostas subsequentes são anexadas.

Formato do CSV

•
Codificação: UTF-8

•
Separador: vírgula (,)

•
Timestamp: formato ISO 8601 (YYYY-MM-DD HH:MM:SS)




🔐 Privacidade e Segurança

•
✅ Dados anônimos: Nenhuma informação pessoal identificável é coletada obrigatoriamente

•
✅ Consentimento explícito: Termo LGPD deve ser aceito antes do envio

•
✅ E-mail opcional: Fornecido apenas se o respondente desejar receber o relatório

•
✅ Uso acadêmico: Dados utilizados exclusivamente para pesquisa científica




📊 Análise Estatística

Após coletar as respostas, você pode realizar análises estatísticas usando R:

Plain Text


# Carregar os dados
dados <- read.csv("respostas.csv", encoding = "UTF-8")

# Estatísticas descritivas
summary(dados)

# Análise de qualidade média
mean(dados$sabor)
mean(dados$variedade)
mean(dados$temperatura)
mean(dados$higiene)
mean(dados$frescor)

# Comparação antes vs depois
t.test(dados$qualidade_antes, dados$qualidade_depois, paired = TRUE)

# Visualizações
library(ggplot2)
ggplot(dados, aes(x = mudanca)) + 
  geom_bar(fill = "#667eea") +
  labs(title = "Percepção de Mudança na Qualidade",
       x = "Mudança Percebida", y = "Frequência")





🎨 Personalização

Alterar Cores do Tema

Edite as seguintes linhas no CSS (dentro do tags$style):

CSS


/* Gradiente principal */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

/* Altere para suas cores preferidas */
background: linear-gradient(135deg, #SUA_COR_1 0%, #SUA_COR_2 100%);


Adicionar Novos Campos

No objeto ui, adicione novos inputs usando as funções do Shiny:

•
textInput() para texto simples

•
textAreaInput() para texto longo

•
selectInput() para seleção única

•
checkboxInput() para caixas de seleção

•
radioButtons() para botões de rádio

•
sliderInput() para escalas

Não se esqueça de adicionar os campos correspondentes no data.frame dentro do server.




🐛 Solução de Problemas

O aplicativo não inicia

•
Verifique se os pacotes shiny e shinyjs estão instalados

•
Confirme que você está no diretório correto

Erro ao salvar respostas

•
Verifique as permissões de escrita no diretório

•
Certifique-se de que não há outro processo usando o arquivo CSV

Layout quebrado

•
Limpe o cache do navegador

•
Verifique a conexão com Google Fonts




📞 Suporte

Para dúvidas ou sugestões sobre este projeto, entre em contato através do e-mail institucional fornecido na pesquisa.




📄 Licença

Este projeto é desenvolvido para fins acadêmicos na Universidade Federal da Paraíba (UFPB).




🙏 Agradecimentos

Agradecemos a todos os participantes que contribuírem com suas respostas para melhorar a qualidade do RU/UFPB!

Juntos, fazemos a diferença! 🎉




Desenvolvido com ❤️ para a comunidade UFPB

