# src/services/profiles — Sistema de Perfis

Cada perfil define uma persona e conjunto de regras para o agente LLM. Perfis são arquivos JSON carregados sob demanda e injetados no system prompt.

## Estrutura

```json
{
  "profile": "developer",
  "version": "2.0.0",
  "description": "...",
  "model": { "provider": "ollama", "name": "..." },
  "rules": [ "regra 1", "regra 2" ],
  "capabilities": { "file_ops": true, "code_gen": true },
  "protocols": ["debug", "validate"],
  "priority": ["code_gen"],
  "failure_conditions": [...],
  "autonomy_rules": [...]
}
```

## Perfis disponíveis

| Perfil | Função |
|---|---|
| `assistant` | Assistente conversacional padrão |
| `developer` | Engenheiro de software sênior (ferramentas, código, git) |
| `booksmith` | Escrita editorial, livros, documentação, PDFs |
| `architect` | Análise de impacto arquitetural |
| `planner` | Planejamento de tarefas complexas |
| `executor` | Execução pura de ferramentas (sem decisão) |
| `validator` | Validação de resultados (compile, test, lint) |
| `corrector` | Correção de falhas |
| `debugger` | Debug de código |
| `code-reviewer` | Revisão de código |
| `tester` | Criação e execução de testes |
| `os-specialist` | Operações de sistema operacional |

## Loader (`loader.py`)

- `load_profile(name)` — carrega JSON do disco com cache
- `format_profile_rules(profile, locale)` — formata regras como texto, remove regras de idioma hardcoded, injeta instrução dinâmica de i18n
- `build_system_prompt(profile_name, dynamic_parts, locale)` — monta o system prompt completo com regras + intent engine + partes dinâmicas + change manifest
