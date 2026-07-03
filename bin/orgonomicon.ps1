$Dist = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$App = Join-Path $Dist 'app'
$Python = Join-Path $Dist '.venv\Scripts\python.exe'
if (!(Test-Path $Python)) { $Python = 'python' }
$env:ORGONOMICON_DIST = $Dist
$env:ORGONOMICON_ROOT = $App
$env:ORGONOMICON_PRODUCTION = '1'
$env:ORGONOMICON_BACKEND_DETACHED = '1'
$env:ORGONOMICON_DISABLE_STARTUP_FINETUNE = '1'
$env:ORGONOMICON_DATA_DIR = Join-Path $env:USERPROFILE '.orgonomicon'
$env:PYTHONPATH = "$App\src;$App;$App\llm"
& $Python (Join-Path $App 'src\cli\terminal_cli.pyc') @args
