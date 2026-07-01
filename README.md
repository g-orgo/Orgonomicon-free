# Orgonomicon Distribution

This folder contains the production distribution for Orgonomicon. Use only the commands available in this folder when installing or running it.

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

## Runtime Data

Runtime settings, logs, and local memories are stored in `.orgonomicon_data/`.

## Notes

- Do not use development commands from the source repository in this distribution folder.
- Production packages include protected runtime code and required dependencies, not raw training datasets.
