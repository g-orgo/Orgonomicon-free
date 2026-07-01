# src/cli — Terminal Interface

CLI interativo do Orgonomicon. Dois modos de interface:

## Modos

- **Rich TUI** (`_run_rich_tui`): interface colorida com Rich, typewriter effect, painéis de transcrição, barras de progresso. Modo padrão.
- **Plain CLI** (`_run_plain_cli`): fallback simples quando Rich não está disponível.

## Fluxo

```
Usuário digita → prompt_toolkit → intent resolution → POST /orgonomicon/chat/stream
                                                          ↓
                                               SSE events (assistant_delta, thinking,
                                               tool_start, tool_result, done)
                                                          ↓
                                               Typewriter effect + painéis Rich
```

## Funcionalidades

- **`@path`** — expansão de caminhos com tab completion
- **Modos**: `agent` (ferramentas), `claude-like` (texto puro), `outsider` (nichos específicos)
- **Blueprint**: gera plano, pausa para confirmação, executa ou replaneja
- **Sessões**: múltiplas sessões com histórico persistido em SQLite
- **Streaming**: resposta em tempo real com efeito typewriter
- **Logs**: HTML interativo com abas de ferramentas, erros e debug
