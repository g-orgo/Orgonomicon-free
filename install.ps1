param(
    [string]$InstallRoot = (Join-Path $env:LOCALAPPDATA 'Orgonomicon')
)

$ErrorActionPreference = 'Stop'
$Source = (Resolve-Path $PSScriptRoot).Path
$InstallRoot = [IO.Path]::GetFullPath($InstallRoot)
$StagingRoot = "$InstallRoot.new"
$PreviousRoot = "$InstallRoot.previous"

function Normalize-PathEntry([string]$PathEntry) {
    return $PathEntry.Trim().TrimEnd('\\').ToLowerInvariant()
}

function Test-OrgonomiconBin([string]$PathEntry) {
    $Launcher = Join-Path $PathEntry 'orgonomicon.cmd'
    if (!(Test-Path $Launcher)) { return $false }
    return (Get-Content -LiteralPath $Launcher -Raw -ErrorAction SilentlyContinue) -match 'ORGONOMICON_'
}

# Discover launchers written by prior versions before replacing the stable install.
$UserPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$LegacyBins = @($UserPath -split ';' | Where-Object {
    $_ -and (Test-OrgonomiconBin $_)
})
$RegistryPath = 'HKCU:\Software\Orgonomicon'
if (Test-Path $RegistryPath) {
    $RegisteredRoot = (Get-ItemProperty -Path $RegistryPath -Name InstallRoot -ErrorAction SilentlyContinue).InstallRoot
    if ($RegisteredRoot) { $LegacyBins += Join-Path $RegisteredRoot 'bin' }
}
$LegacyBinKeys = @($LegacyBins | ForEach-Object { Normalize-PathEntry $_ })

if ((Normalize-PathEntry $Source) -ne (Normalize-PathEntry $InstallRoot)) {
    Remove-Item -LiteralPath $StagingRoot -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $PreviousRoot -Recurse -Force -ErrorAction SilentlyContinue
    Copy-Item -LiteralPath $Source -Destination $StagingRoot -Recurse -Force
    if (Test-Path $InstallRoot) { Move-Item -LiteralPath $InstallRoot -Destination $PreviousRoot -Force }
    Move-Item -LiteralPath $StagingRoot -Destination $InstallRoot -Force
    Remove-Item -LiteralPath $PreviousRoot -Recurse -Force -ErrorAction SilentlyContinue
}

$Python = Join-Path $InstallRoot '.venv\Scripts\python.exe'
if (!(Test-Path $Python)) {
    python -m venv (Join-Path $InstallRoot '.venv')
    $Python = Join-Path $InstallRoot '.venv\Scripts\python.exe'
}
& $Python -m pip install --upgrade pip
& $Python -m pip install -r (Join-Path $InstallRoot 'requirements-production.txt')

$Bin = Join-Path $InstallRoot 'bin'
$PathEntries = @($UserPath -split ';' | Where-Object {
    $_ -and (Normalize-PathEntry $_) -ne (Normalize-PathEntry $Bin) -and
    $LegacyBinKeys -notcontains (Normalize-PathEntry $_)
})
$UpdatedUserPath = ($PathEntries + $Bin) -join ';'
[Environment]::SetEnvironmentVariable('Path', $UpdatedUserPath, 'User')

# Make the command available in this PowerShell session too; new terminals read User PATH.
$SessionEntries = @($env:Path -split ';' | Where-Object {
    $_ -and (Normalize-PathEntry $_) -ne (Normalize-PathEntry $Bin) -and
    $LegacyBinKeys -notcontains (Normalize-PathEntry $_)
})
$env:Path = ($SessionEntries + $Bin) -join ';'

New-Item -Path $RegistryPath -Force | Out-Null
New-ItemProperty -Path $RegistryPath -Name InstallRoot -Value $InstallRoot -PropertyType String -Force | Out-Null
Write-Host "Orgonomicon instalado em $InstallRoot. Use 'orgonomicon' neste terminal ou em um novo terminal."
