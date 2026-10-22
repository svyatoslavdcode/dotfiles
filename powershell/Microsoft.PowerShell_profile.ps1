# Minimal profile: UTF‑8 + Fastfetch + Starship Pure prompt
try {
    [Console]::InputEncoding  = [System.Text.Encoding]::UTF8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $OutputEncoding = [System.Text.UTF8Encoding]::new($false)
    chcp 65001 > $null
} catch {}

if (-not [Console]::IsOutputRedirected) {
    Clear-Host

    # Force Fastfetch to use YOUR config every time (bypass path confusion)
    if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
        fastfetch -c "$HOME/.config/fastfetch/config.jsonc"
    }
}

if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}
