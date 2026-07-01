# src/services — Orquestração Central

Núcleo de orquestração do Orgonomicon. Contém ~50 módulos que gerenciam pipeline, ferramentas, estado, contexto, plano, provedores e ciclo de vida do agente.

## Subsistemas

### Pipeline Cognitivo (`pipeline.py`)
Arquitetura multi-camada: **PlannerLayer** → **ExecutorLayer** → **ValidatorLayer** → **CorrectorLayer**.
Cada camada é um `CognitiveLayer` que recebe o estado atual e retorna ações.
```
Planner: interpreta o pedido, quebra em intents
Executor: executa intents via IntentEngine
Validator: valida resultados (compile, test, lint)
Corrector: corrige falhas (loop até MAX_CORRECTION_LOOPS=3)
```

### Gerenciamento de Estado

| Módulo | Função |
|---|---|
| `session_store.py` | Sessões e mensagens em SQLite |
| `evidence_memory.py` | Memória de tentativas (sucesso/falha), cross-session |
| `change_manifest.py` | Manifesto de alterações para continuidade entre sessões |
| `context_tracker.py` | Rastreamento de contexto por sessão |
| `auto_compact.py` | Compactação automática de histórico longo |

### Execução de Ferramentas

| Módulo | Função |
|---|---|
| `tool_loop.py` | Loop principal de ferramentas (nativo + legado) |
| `tool_schemas.py` | Schema, validação, registro e execução de ferramentas |
| `tool_call_adapter.py` | Normalização de chamadas de diferentes provedores |
| `tool_contracts.py` | Contratos de segurança e metadados das ferramentas |
| `register_tools.py` | Registro global de ferramentas + MCP |

### Conhecimento e Contexto

| Módulo | Função |
|---|---|
| `config/project_config.py` | Carrega `knowledge.md` do projeto para injeção no prompt |
| `project_context_runtime.py` | Detecta tipo de projeto dinamicamente |
| `project_documentation.py` | Gera PROJECT_OVERALL.md, PDF, manual booksmith |
| `research_runtime.py` | Pesquisa web integrada ao fluxo |
| `request_analyzer.py` | Análise de intenção, tecnologias e perfil |

### Provedores e Modelos

| Módulo | Função |
|---|---|
| `providers/` | Adaptadores para Ollama, OpenAI, Anthropic, Gemini, Groq, etc. |
| `provider_shim.py` | Camada de compatibilidade entre providers |
| `provider_config.py` | Configuração de provedores por ambiente |
| `model_router.py` | Roteamento de requisições para o modelo adequado |
| `pricing.py` | Estimativa de custos por provedor/modelo |

### Planos e Tarefas

| Módulo | Função |
|---|---|
| `planner.py` | Planejamento de ações |
| `generate_plan.py` | Geração de planos de execução |
| `scheduler.py` | Agendamento multi-projeto |
| `task_decomposer.py` | Decomposição de tarefas complexas |
| `task_graph.py` | Grafo de dependências entre tarefas |

### Outros

| Módulo | Função |
|---|---|
| `permissions.py` | Controle de permissões de ferramentas |
| `sandbox.py` | Sandbox para execução segura |
| `event_logger.py` | Logging estruturado de eventos |
| `skills_manager.py` | Gerenciamento de skills |
| `subagent_runner.py` | Execução de subagentes especialistas |
| `mcp_manager.py` | Gerenciamento de servidores MCP |
| `protcols.py` | Protocolos de comunicação entre camadas |
