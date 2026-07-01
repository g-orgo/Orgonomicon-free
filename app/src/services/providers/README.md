# src/services/providers — LLM Providers

Adaptadores para diferentes provedores de LLM. Todos implementam `ProviderInterface` (base.py).

## Provedores suportados

| Provedor | Arquivo | API Key |
|---|---|---|
| **Ollama** (local, fallback) | `ollama.py` | Nenhuma (localhost) |
| **OpenAI** | `openai.py` | `OPENAI_API_KEY` |
| **Anthropic** | `anthropic.py` | `ANTHROPIC_API_KEY` |
| **Gemini** | `gemini.py` | `GEMINI_API_KEY` |
| **Groq** | `groq.py` | `GROQ_API_KEY` |
| **OpenRouter** | `openrouter.py` | `OPENROUTER_API_KEY` |
| **xAI** | `xai.py` | `XAI_API_KEY` |
| **Azure** | `azure.py` | `AZURE_OPENAI_ENDPOINT` |

## Interface comum (`ProviderInterface`)

```python
class ProviderInterface(ABC):
    async def complete(self, messages, **kwargs) -> str
    async def complete_with_tools(self, messages, tools, **kwargs) -> tuple[str, list]
    async def complete_streaming(self, messages, **kwargs) -> AsyncIterator[str]
```

## Detecção automática

`ProviderRegistry.auto_detect()` varre variáveis de ambiente na ordem de prioridade acima.
Ollama é sempre o fallback local quando nenhuma API key cloud está configurada.

## Provider Shim

`provider_shim.py` re-exporta todos os providers e o registry para compatibilidade com código legado que importa de `services.provider_shim`.
