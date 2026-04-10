[CmdletBinding()]
param(
    [string]$Context7ApiKey = $env:CONTEXT7_API_KEY,
    [string]$SupabaseProjectRef = "jfdxmawomfvylmzakohf"
)

$ErrorActionPreference = "Stop"

function Remove-ServerIfExists {
    param([Parameter(Mandatory = $true)][string]$Name)

    codex mcp get $Name *> $null
    if ($LASTEXITCODE -eq 0) {
        codex mcp remove $Name | Out-Null
    }
}

function Add-StdIoServer {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string[]]$LaunchCommand,
        [hashtable]$EnvVars = @{}
    )

    Remove-ServerIfExists -Name $Name

    $args = @("mcp", "add", $Name)
    foreach ($key in $EnvVars.Keys) {
        if (-not [string]::IsNullOrWhiteSpace($EnvVars[$key])) {
            $args += "--env"
            $args += "$key=$($EnvVars[$key])"
        }
    }

    $args += "--"
    $args += $LaunchCommand

    & codex @args
    if ($LASTEXITCODE -ne 0) {
        throw "Falha ao adicionar MCP stdio: $Name"
    }
}

function Add-HttpServer {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$Url
    )

    Remove-ServerIfExists -Name $Name

    codex mcp add $Name --url $Url
    if ($LASTEXITCODE -ne 0) {
        throw "Falha ao adicionar MCP HTTP: $Name"
    }
}

$context7Env = @{}
if (-not [string]::IsNullOrWhiteSpace($Context7ApiKey)) {
    $context7Env["CONTEXT7_API_KEY"] = $Context7ApiKey
}

$supabaseFeatures = [uri]::EscapeDataString("docs,account,database,debugging,development,functions,branching,storage")
$supabaseUrl = "https://mcp.supabase.com/mcp?project_ref=$SupabaseProjectRef&features=$supabaseFeatures"

Add-StdIoServer -Name "next-devtools" -LaunchCommand @("npx", "-y", "next-devtools-mcp@latest")
Add-StdIoServer -Name "shadcn" -LaunchCommand @("npx", "shadcn@latest", "mcp")
Add-StdIoServer -Name "chrome-devtools" -LaunchCommand @("npx", "-y", "chrome-devtools-mcp@latest")
Add-StdIoServer -Name "context7" -LaunchCommand @("npx", "-y", "@upstash/context7-mcp") -EnvVars $context7Env
Add-HttpServer -Name "supabase" -Url $supabaseUrl

Write-Host ""
Write-Host "MCPs configurados com sucesso."
Write-Host "Se for a primeira vez no ambiente, execute: codex mcp login supabase"
Write-Host ""
codex mcp list
