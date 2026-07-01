@echo off
set ORGONOMICON_DIST=%~dp0..
set ORGONOMICON_ROOT=%ORGONOMICON_DIST%\app
set ORGONOMICON_PRODUCTION=1
set ORGONOMICON_DISABLE_STARTUP_FINETUNE=1
set ORGONOMICON_DATA_DIR=%USERPROFILE%\.orgonomicon_data
set PYTHONPATH=%ORGONOMICON_ROOT%\src;%ORGONOMICON_ROOT%;%ORGONOMICON_ROOT%\llm
if exist "%ORGONOMICON_DIST%\.venv\Scripts\python.exe" (
  "%ORGONOMICON_DIST%\.venv\Scripts\python.exe" "%ORGONOMICON_ROOT%\src\cli\terminal_cli.pyc" %*
) else (
  python "%ORGONOMICON_ROOT%\src\cli\terminal_cli.pyc" %*
)
