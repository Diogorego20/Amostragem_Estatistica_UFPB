# Guia de Publicação no GitHub

Este guia fornece instruções passo a passo para publicar este repositório no GitHub.

## 📋 Pré-requisitos

- Git instalado no seu computador
- Conta no GitHub
- Repositório criado: `https://github.com/Diogorego20/Atividades_amostragem_estatistica.git`

## 🚀 Passos para Publicação

### 1. Abrir Terminal/Prompt de Comando

Navegue até o diretório onde está o projeto:

```bash
cd caminho/para/Atividades_amostragem_estatistica
```

### 2. Inicializar Repositório Git (se ainda não foi feito)

```bash
git init
```

### 3. Configurar Informações do Autor

```bash
git config user.name "Diogo Rego"
git config user.email "seu_email@exemplo.com"
```

### 4. Adicionar Todos os Arquivos

```bash
git add .
```

### 5. Fazer o Primeiro Commit

```bash
git commit -m "feat: Adicionar soluções completas dos exercícios dos Capítulos 2 e 3

- Implementação em R dos exercícios 2.1, 2.2 e 3.1
- Documentação detalhada em Markdown
- Estrutura profissional do repositório
- Gráficos comparativos e análises estatísticas"
```

### 6. Conectar ao Repositório Remoto

```bash
git remote add origin https://github.com/Diogorego20/Atividades_amostragem_estatistica.git
```

### 7. Verificar Branch Principal

```bash
git branch -M main
```

### 8. Fazer Push para o GitHub

```bash
git push -u origin main
```

Se solicitado, faça login com suas credenciais do GitHub.

## 📝 Comandos Úteis para Futuras Atualizações

### Verificar Status

```bash
git status
```

### Adicionar Arquivos Modificados

```bash
git add .
```

### Fazer Commit das Mudanças

```bash
git commit -m "descrição das mudanças"
```

### Enviar para o GitHub

```bash
git push
```

### Ver Histórico de Commits

```bash
git log --oneline
```

## 🎯 Boas Práticas de Commit

Use mensagens de commit claras e descritivas seguindo o padrão:

- `feat:` para novas funcionalidades
- `fix:` para correções de bugs
- `docs:` para mudanças na documentação
- `refactor:` para refatoração de código
- `style:` para formatação
- `test:` para testes

**Exemplos:**
```bash
git commit -m "feat: Adicionar análise de variância para Exercício 3.1"
git commit -m "docs: Atualizar README com instruções de instalação"
git commit -m "fix: Corrigir cálculo de probabilidades no Plano B"
```

## 🔧 Solução de Problemas

### Erro: "remote origin already exists"

```bash
git remote remove origin
git remote add origin https://github.com/Diogorego20/Atividades_amostragem_estatistica.git
```

### Erro de Autenticação

Use um Personal Access Token (PAT) em vez de senha:
1. Acesse: GitHub → Settings → Developer settings → Personal access tokens
2. Gere um novo token com permissões de `repo`
3. Use o token como senha ao fazer push

### Forçar Push (use com cuidado!)

```bash
git push -f origin main
```

⚠️ **Atenção:** Isso sobrescreverá o histórico remoto. Use apenas se tiver certeza!

## 📚 Recursos Adicionais

- [Documentação Oficial do Git](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)

---

**Boa sorte com a publicação! 🎉**
