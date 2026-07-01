# src — Orgonomicon Runtime

Pacote principal do Orgonomicon. Contém o servidor FastAPI, o CLI interativo, o sistema de ferramentas, o pipeline cognitivo multi-camada, provedores LLM e o sistema de perfis.

## Estrutura

| Diretório | Função |
|---|---|
| `routes/` | Rotas HTTP (chat, streaming, init, blueprint) |
| `cli/` | Terminal interativo (Rich TUI) |
| `tools/` | Definição e execução de ferramentas do agente |
| `planner/` | Sistema de blueprint e planejamento |
| `services/` | Orquestração central: pipeline, ferramentas, perfis, provedores |
| `services/profiles/` | Perfis de persona do agente (JSON + loader) |
| `services/providers/` | Adaptadores para provedores LLM (Ollama, OpenAI, Anthropic, etc.) |
| `services/config/` | Configuração de projeto e provedores |
| `config/` | Runtime defaults |

## Fluxo principal

```
CLI → routes/orgonomicon.py → profiles/loader.py → providers/* → LLM
                                                          ↓
                                              pipeline.py (Planner → Executor → Validator → Corrector)
```

O ponto de entrada é `backend_app.py`, que inicializa o servidor FastAPI na porta 9000.
