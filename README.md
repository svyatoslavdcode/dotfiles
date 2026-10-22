# Windows Dotfiles & Terminal Setup

Personal configuration for **Windows Terminal**, **PowerShell 7**, and **Command Prompt (CMD)** crafted in the Antigravity Dark aesthetic with custom Fastfetch banners and Clink integration.

---

## Features

### Windows Terminal
* **Font:** `Consolas`, `11.0 pt`, `normal` weight
* **Color Scheme:** `Antigravity Dark` (pure black `#000000` background with IDE-inspired syntax highlighting palette)
* **Cursor:** Thin bar (`#48A0C7`)
* **Padding:** `16px` on all sides
* **Scroll behavior:** `"snapOnInput": false` (prevents viewport jumping to prompt on Backspace or keypress)
* **Default window size:** `35` rows

### PowerShell 7
* Automated **Fastfetch** system telemetry (OS, Kernel, Host, Shell, Terminal, Uptime, CPU, GPU, RAM, Disks, Battery, IP/DNS)
* **Starship** Pure-style two-line minimalist prompt:
  * Top line: working directory, git branch (`git:main`), git status (`[!+]`), and execution duration (`took 2.4s`)
  * Bottom line: clean `❯` prompt character (`cyan` on success, `red` on error)
* UTF-8 output encoding by default
* Seamless prompt spacing

### Command Prompt (CMD)
* **Clink** integration for Unix-like keybindings, tab completion, and proper prompt spacing
* Minimalist Fastfetch header on tab launch (`user@host`, `OS`, `Kernel`, `Host`) with cleared screen

---

## Repository Structure

```text
dotfiles/
├── .config/
│   ├── fastfetch/
│   │   ├── ascii.txt      # Blade Runner 2049 ASCII art logo
│   │   ├── config.jsonc   # Full Fastfetch config for PowerShell
│   │   └── cmd.jsonc      # Minimal Fastfetch config for CMD
│   └── starship.toml      # Pure-style two-line prompt configuration
├── powershell/
│   └── Microsoft.PowerShell_profile.ps1
├── terminal/
│   └── settings.json      # Windows Terminal & Preview settings
├── clink/
│   └── prompt_space.lua   # Prompt formatting filter for Clink
├── install.ps1            # One-click automated installer
├── .gitignore
└── README.md
```

---

## Quick Installation

### 1. Prerequisites (install via WinGet)
```powershell
winget install Fastfetch-cli.Fastfetch
winget install Starship.Starship
winget install Microsoft.PowerShell
winget install chrisant996.clink
```

### 2. Clone & Install
```powershell
git clone https://github.com/svyatoslavdcode/dotfiles.git $HOME/dotfiles
powershell -ExecutionPolicy Bypass -File "$HOME\dotfiles\install.ps1"
```

The script automatically distributes configurations to their respective system targets:
* `$HOME\.config\fastfetch\`
* `$HOME\Documents\PowerShell\`
* `%LOCALAPPDATA%\clink\`
* `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_*\LocalState\`
