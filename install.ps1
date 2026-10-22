# Dotfiles installer for Windows Terminal, PowerShell & CMD
$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "Installing dotfiles..." -ForegroundColor Cyan

$scriptDir = $PSScriptRoot
if (-not $scriptDir) {
    $scriptDir = (Get-Location).Path
}

# 1. Fastfetch config
$fastfetchTarget = "$HOME\.config\fastfetch"
if (-not (Test-Path $fastfetchTarget)) {
    New-Item -ItemType Directory -Path $fastfetchTarget -Force | Out-Null
}
Copy-Item "$scriptDir\.config\fastfetch\*" $fastfetchTarget -Force
Write-Host "  [+] Fastfetch configs installed -> $fastfetchTarget" -ForegroundColor Green

# 1.1 Starship prompt config
$starshipSource = "$scriptDir\.config\starship.toml"
if (Test-Path $starshipSource) {
    Copy-Item $starshipSource "$HOME\.config\starship.toml" -Force
    Write-Host "  [+] Starship config installed -> $HOME\.config\starship.toml" -ForegroundColor Green
}

# 2. PowerShell Profile
$myDocs = [Environment]::GetFolderPath('MyDocuments')
$profileDirs = @("$myDocs\PowerShell", "$HOME\Documents\PowerShell")
foreach ($dir in $profileDirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    Copy-Item "$scriptDir\powershell\Microsoft.PowerShell_profile.ps1" $dir -Force
    Write-Host "  [+] PowerShell profile installed -> $dir" -ForegroundColor Green
}

# 3. Clink (CMD prompt customization)
$clinkTarget = "$env:LOCALAPPDATA\clink"
if (-not (Test-Path $clinkTarget)) {
    New-Item -ItemType Directory -Path $clinkTarget -Force | Out-Null
}
Copy-Item "$scriptDir\clink\prompt_space.lua" $clinkTarget -Force
Write-Host "  [+] Clink lua script installed -> $clinkTarget" -ForegroundColor Green

# 4. Windows Terminal & Preview Settings
$packagesDir = "$env:LOCALAPPDATA\Packages"
if (Test-Path $packagesDir) {
    $wtPackages = Get-ChildItem -Path $packagesDir -Filter "*WindowsTerminal*" -ErrorAction SilentlyContinue
    $sourceSettings = "$scriptDir\terminal\settings.json"
    foreach ($pkg in $wtPackages) {
        $localState = "$($pkg.FullName)\LocalState"
        if (Test-Path $localState) {
            Copy-Item $sourceSettings "$localState\settings.json" -Force
            Write-Host "  [+] Windows Terminal settings installed -> $($pkg.Name)" -ForegroundColor Green
        }
    }
}

# 5. Check Recommended Tools
Write-Host ""
Write-Host "Checking prerequisites..." -ForegroundColor Cyan

if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    Write-Host "  [+] Fastfetch is installed." -ForegroundColor Green
} else {
    Write-Host "  [!] Fastfetch not found. Run: winget install Fastfetch-cli.Fastfetch" -ForegroundColor Yellow
}

if (Get-Command starship -ErrorAction SilentlyContinue) {
    Write-Host "  [+] Starship is installed." -ForegroundColor Green
} else {
    Write-Host "  [!] Starship not found. Run: winget install Starship.Starship" -ForegroundColor Yellow
}

if (Get-Command pwsh -ErrorAction SilentlyContinue) {
    Write-Host "  [+] PowerShell 7 is installed." -ForegroundColor Green
} else {
    Write-Host "  [!] PowerShell 7 not found. Run: winget install Microsoft.PowerShell" -ForegroundColor Yellow
}

if (Get-Command clink -ErrorAction SilentlyContinue) {
    Write-Host "  [+] Clink is installed." -ForegroundColor Green
} else {
    Write-Host "  [!] Clink not found. Run: winget install chrisant996.clink" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Dotfiles installation completed successfully!" -ForegroundColor Cyan
Write-Host ""
