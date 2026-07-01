#!/bin/sh
set -eu

OLLAMA_HOST="${OLLAMA_HOST:-http://ollama:11434}"
OLLAMA_BASE_MODEL="${OLLAMA_BASE_MODEL:-llama3.2:3b}"
OLLAMA_CHAT_MODEL="${OLLAMA_CHAT_MODEL:-qwen2.5:7b}"

export OLLAMA_HOST

echo "Esperando Ollama em ${OLLAMA_HOST}..."
until ollama list >/dev/null 2>&1; do
  sleep 2
done

echo "Garantindo modelo base: ${OLLAMA_BASE_MODEL}"
ollama pull "${OLLAMA_BASE_MODEL}"

echo "Garantindo modelo do adaptador GoResolve: ${OLLAMA_CHAT_MODEL}"
ollama pull "${OLLAMA_CHAT_MODEL}"

echo "Bootstrap do Ollama concluido."