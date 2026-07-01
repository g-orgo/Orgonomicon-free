# src/tools — Ferramentas do Agente

Catálogo e execução de ferramentas que o agente LLM pode chamar. Centralizado em `dev_tools.py` (~2100 linhas).

## Ferramentas principais

| Ferramenta | Função |
|---|---|
| `write_file` | Cria ou sobrescreve arquivo com validação (lint, py_compile, pyright) |
| `edit_file` | Substitui texto em arquivo existente |
| `create_dir` | Cria diretório |
| `delete_file` | Remove arquivo/diretório com backup |
| `append_file` | Adiciona conteúdo ao final de arquivo |
| `read_file` | Lê arquivo com offset/limit |
| `list_dir` | Lista diretório |
| `run_command` | Executa comando shell (git, python, npm, etc.) |
| `glob` / `grep` | Busca arquivos e conteúdo |
| `web_search` / `fetch_url` | Acesso à web |
| `generate_code` | Gera código via CODE_SPECIALIST |
| `todo_write` / `todo_read` | Gerenciamento de tarefas |
| `remember_preference` | Memória persistente do usuário |
| `git_*` | Operações Git |

## Integração

As ferramentas são registradas via `ToolRegistry` em `tool_schemas.py` e expostas ao LLM:
- **Tool calling nativo**: via API do provedor (Ollama/OpenAI tool calls)
- **Legado**: via parsing de tags `<tool_call>` no texto

Toda execução de ferramenta passa por `ToolRegistry.execute()`, que valida parâmetros, executa o handler e registra a mudança no `ChangeManifest` para continuidade entre sessões.
