# app.R - Pesquisa RU/UFPB com Design Aprimorado
library(shiny)
library(shinyjs)

ui <- fluidPage(
  useShinyjs(),
  
  # CSS customizado para design jovial e moderno
  tags$head(
    tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap');
      
      body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 20px 0;
      }
      
      .container-fluid {
        max-width: 900px;
        margin: 0 auto;
      }
      
      .main-card {
        background: white;
        border-radius: 20px;
        padding: 40px;
        box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        margin-bottom: 30px;
        animation: fadeIn 0.8s ease-in;
      }
      
      @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
      }
      
      .header-section {
        text-align: center;
        margin-bottom: 30px;
        padding: 20px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 15px;
        color: white;
      }
      
      .header-section h1 {
        font-weight: 700;
        font-size: 2.5em;
        margin-bottom: 10px;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
      }
      
      .header-section .subtitle {
        font-size: 1.1em;
        opacity: 0.95;
        font-weight: 300;
      }
      
      .stats-banner {
        display: flex;
        justify-content: space-around;
        margin: 30px 0;
        padding: 20px;
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        border-radius: 15px;
        color: white;
      }
      
      .stat-item {
        text-align: center;
        flex: 1;
      }
      
      .stat-number {
        font-size: 2.5em;
        font-weight: 700;
        display: block;
      }
      
      .stat-label {
        font-size: 0.9em;
        opacity: 0.9;
        font-weight: 300;
      }
      
      .section-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 15px 25px;
        border-radius: 10px;
        margin: 30px 0 20px 0;
        font-weight: 600;
        font-size: 1.3em;
        display: flex;
        align-items: center;
        gap: 15px;
      }
      
      .section-icon {
        font-size: 1.5em;
      }
      
      .form-group {
        margin-bottom: 25px;
        transition: all 0.3s ease;
      }
      
      .form-group:hover {
        transform: translateX(5px);
      }
      
      label {
        font-weight: 600;
        color: #333;
        margin-bottom: 8px;
        display: block;
      }
      
      .form-control, .selectize-input {
        border: 2px solid #e0e0e0;
        border-radius: 10px;
        padding: 12px;
        transition: all 0.3s ease;
        font-size: 1em;
      }
      
      .form-control:focus, .selectize-input.focus {
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      }
      
      .slider-container {
        padding: 10px 0;
      }
      
      .irs--shiny .irs-bar {
        background: linear-gradient(to right, #667eea, #764ba2);
        border: none;
      }
      
      .irs--shiny .irs-handle {
        background: #667eea;
        border: 3px solid white;
        box-shadow: 0 2px 8px rgba(0,0,0,0.2);
      }
      
      .irs--shiny .irs-from, .irs--shiny .irs-to, .irs--shiny .irs-single {
        background: #667eea;
        font-weight: 600;
      }
      
      .radio-inline, .checkbox {
        font-weight: 500;
        color: #555;
      }
      
      .checkbox input[type='checkbox'] {
        width: 20px;
        height: 20px;
        margin-right: 10px;
      }
      
      .consent-box {
        background: #fff3cd;
        border: 2px solid #ffc107;
        border-radius: 10px;
        padding: 20px;
        margin: 20px 0;
      }
      
      .consent-box h4 {
        color: #856404;
        font-weight: 600;
        margin-bottom: 15px;
      }
      
      .btn-primary {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        border-radius: 10px;
        padding: 15px 40px;
        font-size: 1.2em;
        font-weight: 600;
        color: white;
        width: 100%;
        margin-top: 30px;
        transition: all 0.3s ease;
        cursor: pointer;
      }
      
      .btn-primary:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
      }
      
      .btn-primary:active {
        transform: translateY(-1px);
      }
      
      .info-card {
        background: #e3f2fd;
        border-left: 4px solid #2196f3;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
      }
      
      .info-card p {
        margin: 0;
        color: #1565c0;
        font-weight: 500;
      }
      
      .progress-indicator {
        text-align: center;
        margin: 20px 0;
        font-size: 1.1em;
        color: #667eea;
        font-weight: 600;
      }
      
      hr {
        border: none;
        height: 2px;
        background: linear-gradient(to right, transparent, #667eea, transparent);
        margin: 30px 0;
      }
      
      .emoji-icon {
        font-size: 1.5em;
        margin-right: 10px;
      }
      
      .modal-content {
        border-radius: 15px;
        border: none;
      }
      
      .modal-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-radius: 15px 15px 0 0;
      }
      
      .modal-body {
        padding: 30px;
        font-size: 1.1em;
      }
      
      .quality-scale {
        display: flex;
        justify-content: space-between;
        margin-top: 5px;
        font-size: 0.85em;
        color: #666;
      }
      
      .sampling-info {
        background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
        padding: 20px;
        border-radius: 15px;
        margin: 20px 0;
        text-align: center;
      }
      
      .sampling-info h5 {
        font-weight: 700;
        color: #333;
        margin-bottom: 10px;
      }
      
      .sampling-info p {
        color: #555;
        margin: 5px 0;
      }
    "))
  ),
  
  div(class = "main-card",
    # Cabeçalho principal
    div(class = "header-section",
      h1("🍽️ Pesquisa RU/UFPB"),
      div(class = "subtitle", "Qualidade Percebida • Anônima • ~3 min • LGPD")
    ),
    
    # Banner estatístico
    div(class = "stats-banner",
      div(class = "stat-item",
        span(class = "stat-number", "📊"),
        span(class = "stat-label", "Amostragem Científica")
      ),
      div(class = "stat-item",
        span(class = "stat-number", "🎯"),
        span(class = "stat-label", "Inferência Estatística")
      ),
      div(class = "stat-item",
        span(class = "stat-number", "✨"),
        span(class = "stat-label", "Sua Opinião Importa!")
      )
    ),
    
    # Informação sobre amostragem
    div(class = "sampling-info",
      h5("🔬 Por que sua participação é importante?"),
      p("Cada resposta contribui para uma amostra representativa da comunidade UFPB!"),
      p("Com técnicas de inferência estatística, sua opinião ajuda a melhorar o RU para todos.")
    ),
    
    # Termo de consentimento
    div(class = "consent-box",
      h4("📋 Termo de Consentimento (LGPD)"),
      helpText(
        strong("Finalidade:"), "pesquisa acadêmica sobre qualidade percebida do RU/UFPB. ",
        strong("Dados:"), "respostas ao questionário (anônimas e agregadas). ",
        strong("Base legal:"), "consentimento livre e informado. ",
        strong("Armazenamento:"), "uso exclusivamente acadêmico e anonimizado. ",
        strong("Contato:"), "você pode fornecer e-mail institucional opcional para receber o relatório."
      ),
      checkboxInput('concordo', 
                    HTML('<strong>✅ Li e concordo com o tratamento dos dados conforme descrito acima.</strong>'), 
                    FALSE)
    ),
    
    hr(),
    
    # Seção A - Perfil
    div(class = "section-header",
      span(class = "section-icon", "👤"),
      "Seção A — Perfil do Respondente"
    ),
    
    selectInput('curso_nivel', 
                '🎓 Curso e nível', 
                c('Selecione...' = '', 'Graduação','Pós-graduação')),
    
    selectInput('turno', 
                '🕐 Turno predominante de estudo', 
                c('Selecione...' = '', 'Manhã','Tarde','Noite')),
    
    selectInput('frequencia', 
                '📅 Com que frequência você utiliza o RU?', 
                c('Selecione...' = '', 'Diária','3–4 vezes/semana','1–2 vezes/semana','Ocasional')),
    
    radioButtons('usava_antes', 
                 '🔄 Você utilizava o RU antes da redução de preço?', 
                 c('Sim','Não'), 
                 inline=TRUE),
    
    selectInput('renda', 
                '💰 Faixa de renda familiar (opcional)', 
                c('Selecione...' = '', 'Até 1 SM','1–3 SM','Mais de 3 SM','Prefiro não informar')),
    
    hr(),
    
    # Seção B - Qualidade
    div(class = "section-header",
      span(class = "section-icon", "⭐"),
      "Seção B — Avaliação de Qualidade (escala 1–5)"
    ),
    
    div(class = "info-card",
      p("📌 Avalie cada aspecto da qualidade do RU usando a escala de 1 (muito ruim) a 5 (excelente)")
    ),
    
    div(
      sliderInput('sabor', '🍲 Sabor da comida', min=1, max=5, value=3, step=1),
      div(class = "quality-scale",
        span("1 = Muito ruim"),
        span("3 = Regular"),
        span("5 = Excelente")
      )
    ),
    
    div(
      sliderInput('variedade', '🥗 Variedade do cardápio', min=1, max=5, value=3, step=1),
      div(class = "quality-scale",
        span("1 = Muito ruim"),
        span("3 = Regular"),
        span("5 = Excelente")
      )
    ),
    
    div(
      sliderInput('temperatura', '🌡️ Temperatura adequada', min=1, max=5, value=3, step=1),
      div(class = "quality-scale",
        span("1 = Muito ruim"),
        span("3 = Regular"),
        span("5 = Excelente")
      )
    ),
    
    div(
      sliderInput('higiene', '🧼 Higiene e limpeza', min=1, max=5, value=3, step=1),
      div(class = "quality-scale",
        span("1 = Muito ruim"),
        span("3 = Regular"),
        span("5 = Excelente")
      )
    ),
    
    div(
      sliderInput('frescor', '🥬 Frescor dos ingredientes', min=1, max=5, value=3, step=1),
      div(class = "quality-scale",
        span("1 = Muito ruim"),
        span("3 = Regular"),
        span("5 = Excelente")
      )
    ),
    
    hr(),
    
    # Seção C - Antes vs Depois
    div(class = "section-header",
      span(class = "section-icon", "📊"),
      "Seção C — Comparação: Antes vs. Depois da Redução"
    ),
    
    sliderInput('qualidade_antes', 
                '📉 Qualidade geral (ANTES da redução de preço)', 
                min=1, max=5, value=3, step=1),
    
    sliderInput('qualidade_depois', 
                '📈 Qualidade geral (DEPOIS da redução de preço)', 
                min=1, max=5, value=3, step=1),
    
    selectInput('mudanca', 
                '🔄 Como você percebe a mudança na qualidade?', 
                c('Selecione...' = '', 'Melhorou','Manteve-se igual','Piorou')),
    
    hr(),
    
    # Seção D - Expectativas
    div(class = "section-header",
      span(class = "section-icon", "💭"),
      "Seção D — Expectativas e Sugestões"
    ),
    
    radioButtons('esperava_diminuir', 
                 '🤔 Você esperava que a qualidade diminuísse após a redução de preço?', 
                 c('Sim','Não'), 
                 inline=TRUE),
    
    selectInput('expectativa_atendida', 
                '✅ Sua expectativa foi atendida?', 
                c('Selecione...' = '', 'Melhor do que esperava','Igual ao esperado','Pior do que esperava')),
    
    textAreaInput('importante_qualidade', 
                  '💡 O que você considera MAIS importante para a qualidade do RU? (opcional)', 
                  '', 
                  rows = 3,
                  placeholder = "Ex: sabor, variedade, atendimento, ambiente..."),
    
    textAreaInput('sugestoes', 
                  '✍️ Sugestões para melhoria do RU (opcional)', 
                  '', 
                  rows = 3,
                  placeholder = "Compartilhe suas ideias para tornar o RU ainda melhor!"),
    
    textInput('email', 
              '📧 E-mail institucional (opcional, para receber o relatório final)', 
              '',
              placeholder = "seu.email@academico.ufpb.br"),
    
    hr(),
    
    div(class = "progress-indicator",
      "🎉 Você está quase lá! Clique em enviar para contribuir com a pesquisa!"
    ),
    
    actionButton('enviar', 
                 '📤 Enviar Respostas', 
                 class = "btn-primary")
  )
)

server <- function(input, output, session) {
  observeEvent(input$enviar, {
    # Validar consentimento
    if (!isTRUE(input$concordo)) {
      showModal(modalDialog(
        title = div(style = "color: #d32f2f; font-weight: bold;", "⚠️ Atenção!"),
        div(style = "font-size: 1.1em;",
          p("Para participar da pesquisa, você precisa concordar com o termo de consentimento (LGPD)."),
          p(style = "color: #666;", "Seus dados serão tratados de forma anônima e exclusivamente para fins acadêmicos.")
        ),
        easyClose = TRUE,
        footer = modalButton("Entendi")
      ))
      return()
    }
    
    # Validar campos obrigatórios
    if (input$curso_nivel == '' || input$turno == '' || 
        input$frequencia == '' || input$mudanca == '' || 
        input$expectativa_atendida == '') {
      showModal(modalDialog(
        title = div(style = "color: #f57c00; font-weight: bold;", "📝 Campos Obrigatórios"),
        div(style = "font-size: 1.1em;",
          p("Por favor, preencha todos os campos obrigatórios antes de enviar."),
          p(style = "color: #666;", "Os campos com seleção 'Selecione...' precisam ser preenchidos.")
        ),
        easyClose = TRUE,
        footer = modalButton("OK")
      ))
      return()
    }
    
    # Criar registro da resposta
    row <- data.frame(
      timestamp = format(Sys.time(), '%Y-%m-%d %H:%M:%S'),
      curso_nivel = input$curso_nivel,
      turno = input$turno,
      frequencia = input$frequencia,
      usava_antes = input$usava_antes,
      renda = input$renda,
      sabor = input$sabor,
      variedade = input$variedade,
      temperatura = input$temperatura,
      higiene = input$higiene,
      frescor = input$frescor,
      qualidade_antes = input$qualidade_antes,
      qualidade_depois = input$qualidade_depois,
      mudanca = input$mudanca,
      esperava_diminuir = input$esperava_diminuir,
      expectativa_atendida = input$expectativa_atendida,
      importante_qualidade = input$importante_qualidade,
      sugestoes = input$sugestoes,
      email = input$email,
      stringsAsFactors = FALSE
    )
    
    # Salvar em CSV
    fn <- 'respostas.csv'
    if (!file.exists(fn)) {
      write.csv(row, fn, row.names = FALSE, fileEncoding = "UTF-8")
    } else {
      write.table(row, fn, sep = ',', col.names = FALSE, row.names = FALSE, 
                  append = TRUE, fileEncoding = "UTF-8")
    }
    
    # Mensagem de sucesso
    showModal(modalDialog(
      title = div(style = "color: #4caf50; font-weight: bold;", "🎉 Obrigado pela Participação!"),
      div(style = "font-size: 1.1em; text-align: center;",
        p(style = "font-weight: 600;", "Sua resposta foi registrada com sucesso!"),
        p("Sua contribuição é fundamental para melhorar a qualidade do RU/UFPB."),
        p(style = "color: #666; font-size: 0.95em;", 
          "Os resultados da pesquisa serão analisados com técnicas de inferência estatística."),
        br(),
        p(style = "color: #667eea; font-weight: 600;", "📊 Juntos, fazemos a diferença!")
      ),
      easyClose = TRUE,
      footer = modalButton("Fechar")
    ))
  })
}

shinyApp(ui, server)
