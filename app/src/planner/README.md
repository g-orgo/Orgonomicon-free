# src/planner — Blueprint & Planning

Sistema de planejamento e blueprint do Orgonomicon. Gera planos de implementação que persistem entre sessões.

## Componentes

| Arquivo | Função |
|---|---|
| `blueprint.py` | `Blueprint` dataclass, geração de blueprint Markdown, sumário |
| `engine.py` | `create_and_save_blueprint()`, confirmação interativa |

## Fluxo

1. **Detecção**: CLI detecta que o pedido precisa de blueprint
2. **Geração**: `Blueprint.generate()` analisa o projeto, identifica tipo (FastAPI, React, vanilla-dom), faz brainstorming de passos, produz plano em Markdown
3. **Salvamento**: plano salvo em `~/.orgonomicon/blueprints/blueprint-{timestamp}-{slug}.md`
4. **Confirmação**: CLI pausa e pergunta se pode executar
5. **Execução**: plano executado pelo pipeline V2 (Planner → Executor → Validator → Corrector)
6. **Replan**: se falhar, volta ao passo 2

## Change Manifest

Blueprints registram automaticamente suas alterações no `ChangeManifest` com o nome da campanha. O agente consulta esse manifesto em sessões futuras para manter continuidade.
