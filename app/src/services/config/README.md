# src/services/config — Configuração

Subsistema de configuração do Orgonomicon. Gerencia configuração de projeto, provedores e caminhos.

## Módulos

| Arquivo | Função |
|---|---|
| `project_config.py` | Carrega `knowledge.md` do projeto para injeção no system prompt. Busca em: `knowledge.md`, `orgonomicon.config.md`, `CLAUDE.md`, `.orgonomicon/config.md` |
| `project_paths.py` | Resolução de caminhos do projeto (CWD, raiz do repositório, diretórios de dados) |
| `provider_config.py` | Configuração de provedores LLM (endpoints, API keys, modelos padrão) |

## knowledge.md

O arquivo `knowledge.md` na raiz do projeto é a principal fonte de configuração. Contém:
- Stack tecnológica
- Estrutura de diretórios
- Convenções de código
- Regras de ferramentas
- Comandos de build/teste

Injetado automaticamente no system prompt para que o agente entenda o contexto do projeto.
