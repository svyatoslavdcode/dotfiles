# ⚡ Windows Dotfiles & Terminal Setup

Персональная конфигурация **Windows Terminal**, **PowerShell 7** и **Command Prompt (CMD)** в визуальном стиле Antigravity Dark с кастомными баннерами Fastfetch и Clink.

---

## 🎨 Особенности

* **Windows Terminal:**
  * **Шрифт:** `Consolas`, размер `11.0 pt`
  * **Тема:** `Antigravity Dark` (глубокий черный фон `#000000`, акцентные цвета подсветки синтаксиса)
  * **Курсор:** тонкая палочка (`bar`) бирюзового цвета (`#48A0C7`)
  * **Отступы:** `16px` со всех сторон
  * **Поведение скролла:** `snapOnInput: false` (экран не срывается вниз при нажатии Backspace или редактировании)
  * **Размер окна:** `35` строк по умолчанию

* **PowerShell 7:**
  * Автозапуск **Fastfetch** с фирменным оранжевым ASCII-логотипом *Blade Runner 2049*
  * Полный набор системных характеристик (OS, Kernel, Host, Shell, Terminal, Uptime, CPU, GPU, RAM, Disks, Battery, IP/DNS)
  * UTF-8 по умолчанию
  * Чистый prompt с правильным интервалом

* **Command Prompt (CMD):**
  * Интеграция с **Clink** (поддержка Unix-горячих клавиш, автодополнения и правильный пробел после `>`)
  * Компактный заголовок Fastfetch без логотипа при открытии вкладки (`user@host`, `OS`, `Kernel`, `Host`)

---

## 📁 Структура репозитория

```text
dotfiles/
├── .config/
│   └── fastfetch/
│       ├── ascii.txt      # Логотип Blade Runner 2049 (ASCII art)
│       ├── config.jsonc   # Основной конфиг для PowerShell
│       └── cmd.jsonc      # Компактный конфиг для CMD
├── powershell/
│   └── Microsoft.PowerShell_profile.ps1
├── terminal/
│   └── settings.json      # Настройки Windows Terminal & Preview
├── clink/
│   └── prompt_space.lua   # Скрипт пробела после prompt для Clink
├── install.ps1            # Скрипт автоматической установки в 1 клик
└── README.md
```

---

## 🚀 Быстрая установка

### 1. Необходимые утилиты (если еще не установлены):
```powershell
winget install Fastfetch-cli.Fastfetch
winget install Microsoft.PowerShell
winget install chrisant996.clink
```

### 2. Клонирование и установка:
```powershell
git clone https://github.com/svyatoslavdcode/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
.\install.ps1
```

Скрипт автоматически скопирует конфигурационные файлы в нужные директории Windows:
* `$HOME\.config\fastfetch\`
* `$HOME\Documents\PowerShell\`
* `%LOCALAPPDATA%\clink\`
* `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_*\LocalState\`
