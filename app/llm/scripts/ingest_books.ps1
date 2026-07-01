# ingest_books.ps1 — Ingere livros no perfil developer
# Uso: .\llm\scripts\ingest_books.ps1
# Parametros adicionais sao repassados ao script Python, ex:
#   .\llm\scripts\ingest_books.ps1 --force
#   .\llm\scripts\ingest_books.ps1 --profile goresolve

param(
    [string]$Profile = "developer",
    [switch]$Force,
    [switch]$AllProfiles
)

$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
Push-Location $RepoRoot

$args_list = @("--profile", $Profile)
if ($Force) { $args_list += "--force" }
if ($AllProfiles) { $args_list = @() }  # sem --profile = todos os perfis

Write-Host "Ingerindo livros para perfil: $(if ($AllProfiles) { 'todos' } else { $Profile })"
uv run --no-sync python scripts/ingest_books.py @args_list

Pop-Location
