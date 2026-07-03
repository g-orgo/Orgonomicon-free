# Orgonomicon Distribution

This folder contains the production distribution for Orgonomicon: a local-first terminal agent with a FastAPI backend, an interactive CLI, deterministic safety routes, tool execution, and optional outsider model access. It is meant to be installed and used from this folder, without relying on development scripts from the source repository.

Orgonomicon can inspect projects, edit files, run commands, generate documentation, recover from common backend/tool failures, and keep runtime state under a local data folder. The production build ships protected runtime bytecode and the dependencies required for end-user execution.

## Install

```powershell
.\install.ps1
```

## Run

```powershell
orgonomicon
```

## Distribution Commands

- `.\install.ps1` - install or update the terminal command.
- `orgonomicon --help` - verify the CLI launcher.
- `orgonomicon` - start the CLI from the current terminal directory.

## Using The Agent

- Start with `orgonomicon` and type requests naturally, such as asking it to inspect a project, update a README, or fix a failing command.
- Use `/mode local-running` for the default local runtime.
- Use `/zen` or `/mode zen` to activate the free outsider shortcut for `deepseek-v4-flash-free` without registering a personal API key.
- Use `/mode outsider` and `/provider` only when you want BYOK provider configuration.
- The CLI starts and recovers its local backend automatically during normal use.
- Use the CLI diagnostic log command after a failed interaction to save a recovery bundle.

## Runtime Data

Runtime settings, logs, sessions, local memories, provider configuration, and generated diagnostics are stored in `.orgonomicon_data/`. Keep that folder out of Git and do not share it when it may contain local paths, API keys, or private project context.

## What Is Included

- `bin/` contains the Windows launchers used by the installed `orgonomicon` command.
- `app/` contains the protected runtime application and shared LLM/provider package.
- `install.ps1` installs or updates the command entry point.
- `requirements-production.txt` lists the Python packages expected by this distribution.
- `production-manifest.json` records how the package was produced.

## Troubleshooting

- If `orgonomicon` is not recognized, run `.\install.ps1` again and open a new terminal.
- If the backend stays offline, restart `orgonomicon`; the CLI will attempt recovery automatically.
- If a provider fails, try `/zen` for the free outsider shortcut or inspect `/provider status` in outsider mode.
- If a command fails, keep the generated debug log; it contains the backend events needed for recovery.

## Notes

- Do not use development commands from the source repository in this distribution folder.
- Production packages include protected runtime code and required dependencies, not raw training datasets.
