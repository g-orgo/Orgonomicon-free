# src/config — Runtime Defaults

Configurações padrão de runtime do Orgonomicon.

| Arquivo | Função |
|---|---|
| `runtime_defaults.py` | Constantes de configuração: timeouts, limites de contexto, paths padrão, variáveis de ambiente |

Fornece valores default para:
- `LLM_CONTEXT_WINDOW` — tamanho do contexto (padrão: 8192)
- Timeouts de ferramentas e chamadas LLM
- Diretórios de dados e logs
- Flags de feature toggle

Valores podem ser sobrescritos por variáveis de ambiente.
