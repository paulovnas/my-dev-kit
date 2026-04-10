[CmdletBinding()]
param(
    [string]$Context7ApiKey = $env:CONTEXT7_API_KEY,
    [string]$SupabaseProjectRef = "jfdxmawomfvylmzakohf",
    [switch]$SkipMcpSetup
)

$ErrorActionPreference = "Stop"

$syncScript = Join-Path $PSScriptRoot "sync-global-skills.ps1"
$mcpScript = Join-Path $PSScriptRoot "setup-codex-mcps.ps1"

Write-Host "Sincronizando skills globais..."
& $syncScript

if (-not $SkipMcpSetup) {
    Write-Host ""
    Write-Host "Configurando MCPs do Codex..."
    & $mcpScript -Context7ApiKey $Context7ApiKey -SupabaseProjectRef $SupabaseProjectRef
}
else {
    Write-Host ""
    Write-Host "Setup de MCP ignorado por -SkipMcpSetup."
}

Write-Host ""
Write-Host "Bootstrap finalizado."
