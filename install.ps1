# Dotfiles installer for Windows Terminal, PowerShell & CMD (Fastfetch & Clink)
[CmdletBinding()]
param(
    [switch]$Force
)

$ErrorActionPreference = "Stop"

Write-Host "`n🚀 Installing dotfiles..." -ForegroundColor Cyan

$scriptDir = $PSScriptRoot
if (-not $scriptDir) {
    $scriptDir = (Get-Location).Path
}

# 1. Fastfetch config
$fastfetchTarget = Join-Path $HOME ".config\fastfetch"
if (-not (Test-Path $fastfetchTarget)) {
    New-Item -ItemType Directory -Path $fastfetchTarget -Force | Out-Null
}
Copy-Item (Join-Path $scriptDir ".config\fastfetch\*") $fastfetchTarget -Force
Write-Host "  ✓ Fastfetch configs installed -> $fastfetchTarget" -ForegroundColor Green

# 2. PowerShell Profile
$docsFolders = @(
    (Join-Path ([Environment]::GetFolderPath('MyDocuments')) "PowerShell"),
    (Join-Path $HOME "Documents\PowerShell")
) | Select-Object -Unique

foreach ($dir in $docsFolders) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    Copy-Item (Join-Path $scriptDir "powershell\Microsoft.PowerShell_profile.ps1") $dir -Force
    Write-Host "  ✓ PowerShell profile installed -> $dir" -ForegroundColor Green
}

# 3. Clink (CMD prompt customization)
$clinkTarget = Join-Path $env:LOCALAPPDATA "clink"
if (-not (Test-Path $clinkTarget)) {
    New-Item -ItemType Directory -Path $clinkTarget -Force | Out-Null
}
Copy-Item (Join-Path $scriptDir "clink\prompt_space.lua") $clinkTarget -Force
Write-Host "  ✓ Clink lua script installed -> $clinkTarget" -ForegroundColor Green

# 4. Windows Terminal & Preview Settings
$wtPackages = Get-ChildItem (Join-Path $env:LOCALAPPDATA "Packages") -Filter "*WindowsTerminal*" -ErrorAction SilentlyContinue
$sourceSettings = Join-Path $scriptDir "terminal\settings.json"

if ($wtPackages) {
    foreach ($pkg in $wtPackages) {
        $localState = Join-Path $pkg.FullName "LocalState"
        if (Test-Path $localState) {
            Copy-Item $sourceSettings (Join-Path $localState "settings.json") -Force
            Write-Host "  ✓ Windows Terminal settings installed -> $($pkg.Name)" -ForegroundColor Green
        }
    }
} else {
    Write-Host "  ! Windows Terminal package folder not found yet." -ForegroundColor Yellow
}

# 5. Check Recommended Tools
Write-Host "`n🔍 Checking prerequisites..." -ForegroundColor Cyan

$tools = @(
    @{ Name = "Fastfetch"; Command = "fastfetch"; Install = "winget install Fastfetch-cli.Fastfetch --accept-source-agreements --accept-package-agreements" },
    @{ Name = "PowerShell 7"; Command = "pwsh"; Install = "winget install Microsoft.PowerShell --accept-source-agreements --accept-package-agreements" },
    @{ Name = "Clink"; Command = "clink"; Install = "winget install chrisant996.clink --accept-source-agreements --accept-package-agreements" }
)

foreach ($tool in $tools) {
    if (Get-Command $tool.Command -ErrorAction SilentlyContinue) {
        Write-Host "  ✓ $($tool.Name) is installed." -ForegroundColor Green
    } else {
        Write-Host "  ! $($tool.Name) not found. To install, run:" -ForegroundColor Yellow
        Write-Host "    $($tool.Install)" -ForegroundColor Gray
    }
}

Write-Host "`n✨ Dotfiles installation completed successfully!`n" -ForegroundColor Cyan
