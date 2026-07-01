# src/routes — FastAPI HTTP Routes

Ponto de entrada HTTP do Orgonomicon. O roteador principal vive em `orgonomicon.py` (~4000 linhas).

## Endpoints

| Rota | Função |
|---|---|
| `POST /orgonomicon/chat` | Chat não-streaming |
| `POST /orgonomicon/chat/stream` | Chat com SSE streaming |
| `GET /orgonomicon/health` | Healthcheck |
| `POST /orgonomicon/init` | Gera documentação inicial do projeto (PDF, manual) |
| `POST /orgonomicon/blueprint` | Gera blueprint de implementação |

## Fluxo de uma requisição de chat

1. **Recebe** `OrgonomiconChatRequest` com `text`, `session_id`, `context`
2. **Detecta** smalltalk, comandos diretos, `/compact`
3. **Analisa** o request via `analyze_request()` (tecnologias, intenção)
4. **Seleciona** perfil via `_select_profile_for_request()`
5. **Detecta** idioma do usuário via `detect_language()` (i18n)
6. **Roteia** para o fluxo adequado:
   - Determinístico (project overview, readme, quality gate, artifact export)
   - Conversacional (assistant, booksmith)
   - Desenvolvimento (V2 Pipeline com Planner → Executor → Validator → Corrector)
7. **Constrói** system prompt com perfil + regras + contexto dinâmico + change manifest
8. **Envia** para o LLM via provider shim
9. **Retorna** resposta como SSE events ou JSON
