[CmdletBinding()]
param(
    [ValidateSet("pull", "push", "both")]
    [string]$Mode = "both",
    [string]$SourceAgentsRoot = "$HOME\.agents",
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

$machineSkills = Join-Path $SourceAgentsRoot "skills"
$machineLock = Join-Path $SourceAgentsRoot ".skill-lock.json"

$repoSkillsRoot = Join-Path $RepoRoot "skills"
$repoGlobalSkills = Join-Path $repoSkillsRoot "global"
$repoOverrides = Join-Path $repoSkillsRoot "overrides"
$repoLock = Join-Path $repoSkillsRoot ".skill-lock.json"

$docsDir = Join-Path $RepoRoot "docs"
$skillsIndexFile = Join-Path $docsDir "skills-index.md"

function Copy-FolderContent {
    param(
        [Parameter(Mandatory = $true)][string]$SourceDir,
        [Parameter(Mandatory = $true)][string]$DestinationDir
    )

    if (-not (Test-Path $SourceDir)) {
        throw "Diretorio de origem nao encontrado: $SourceDir"
    }

    if (Test-Path $DestinationDir) {
        Remove-Item -Recurse -Force $DestinationDir
    }

    New-Item -ItemType Directory -Force -Path $DestinationDir | Out-Null
    Copy-Item -Recurse -Force (Join-Path $SourceDir "*") $DestinationDir
}

function Apply-OverridesToRepoGlobal {
    param(
        [Parameter(Mandatory = $true)][string]$OverridesRoot,
        [Parameter(Mandatory = $true)][string]$TargetSkillsRoot
    )

    $applied = 0

    if (-not (Test-Path $OverridesRoot)) {
        return $applied
    }

    $overrideDirs = Get-ChildItem -Path $OverridesRoot -Directory
    foreach ($overrideDir in $overrideDirs) {
        $targetSkillDir = Join-Path $TargetSkillsRoot $overrideDir.Name
        New-Item -ItemType Directory -Force -Path $targetSkillDir | Out-Null
        Copy-Item -Recurse -Force (Join-Path $overrideDir.FullName "*") $targetSkillDir
        $applied++
    }

    return $applied
}

function Backup-MachineSkills {
    param(
        [Parameter(Mandatory = $true)][string]$AgentsRoot,
        [Parameter(Mandatory = $true)][string]$MachineSkillsDir,
        [Parameter(Mandatory = $true)][string]$MachineLockFile
    )

    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $backupsRoot = Join-Path $AgentsRoot "backups"
    $backupDir = Join-Path $backupsRoot "skills-sync-$timestamp"

    New-Item -ItemType Directory -Force -Path $backupDir | Out-Null

    if (Test-Path $MachineSkillsDir) {
        Copy-Item -Recurse -Force $MachineSkillsDir (Join-Path $backupDir "skills")
    }

    if (Test-Path $MachineLockFile) {
        Copy-Item -Force $MachineLockFile (Join-Path $backupDir ".skill-lock.json")
    }

    return $backupDir
}

function Update-SkillsIndex {
    param(
        [Parameter(Mandatory = $true)][string]$RepoGlobalSkillsDir,
        [Parameter(Mandatory = $true)][string]$IndexFile
    )

    $skillDirs = @()
    if (Test-Path $RepoGlobalSkillsDir) {
        $skillDirs = Get-ChildItem -Path $RepoGlobalSkillsDir -Directory | Sort-Object Name
    }

    $lines = @(
        "# Inventario de Skills",
        "",
        "Gerado automaticamente por `scripts/sync-global-skills.ps1`.",
        "",
        "| Skill | Caminho | Arquivos |",
        "| --- | --- | --- |"
    )

    foreach ($skillDir in $skillDirs) {
        $fileCount = (Get-ChildItem -Path $skillDir.FullName -Recurse -File | Measure-Object).Count
        $lines += "| $($skillDir.Name) | `skills/global/$($skillDir.Name)` | $fileCount |"
    }

    Set-Content -Path $IndexFile -Value $lines -Encoding utf8
}

if (-not (Test-Path $SourceAgentsRoot)) {
    throw "Pasta base de agentes nao encontrada: $SourceAgentsRoot"
}

New-Item -ItemType Directory -Force -Path $repoSkillsRoot | Out-Null
New-Item -ItemType Directory -Force -Path $docsDir | Out-Null

$appliedOverrides = 0
$backupDir = "-"

switch ($Mode) {
    "pull" {
        Copy-FolderContent -SourceDir $machineSkills -DestinationDir $repoGlobalSkills

        if (Test-Path $machineLock) {
            Copy-Item -Force $machineLock $repoLock
        }

        $appliedOverrides = Apply-OverridesToRepoGlobal -OverridesRoot $repoOverrides -TargetSkillsRoot $repoGlobalSkills
    }
    "push" {
        if (-not (Test-Path $repoGlobalSkills)) {
            throw "Diretorio nao encontrado para push: $repoGlobalSkills"
        }

        $appliedOverrides = Apply-OverridesToRepoGlobal -OverridesRoot $repoOverrides -TargetSkillsRoot $repoGlobalSkills
        $backupDir = Backup-MachineSkills -AgentsRoot $SourceAgentsRoot -MachineSkillsDir $machineSkills -MachineLockFile $machineLock

        Copy-FolderContent -SourceDir $repoGlobalSkills -DestinationDir $machineSkills

        if (Test-Path $repoLock) {
            Copy-Item -Force $repoLock $machineLock
        }
    }
    "both" {
        Copy-FolderContent -SourceDir $machineSkills -DestinationDir $repoGlobalSkills

        if (Test-Path $machineLock) {
            Copy-Item -Force $machineLock $repoLock
        }

        $appliedOverrides = Apply-OverridesToRepoGlobal -OverridesRoot $repoOverrides -TargetSkillsRoot $repoGlobalSkills
        $backupDir = Backup-MachineSkills -AgentsRoot $SourceAgentsRoot -MachineSkillsDir $machineSkills -MachineLockFile $machineLock

        Copy-FolderContent -SourceDir $repoGlobalSkills -DestinationDir $machineSkills

        if (Test-Path $repoLock) {
            Copy-Item -Force $repoLock $machineLock
        }
    }
}

Update-SkillsIndex -RepoGlobalSkillsDir $repoGlobalSkills -IndexFile $skillsIndexFile

$syncedSkills = 0
if (Test-Path $repoGlobalSkills) {
    $syncedSkills = (Get-ChildItem -Path $repoGlobalSkills -Directory | Measure-Object).Count
}

Write-Host "Modo de sincronizacao: $Mode"
Write-Host "Skills sincronizadas (repo/global): $syncedSkills"
Write-Host "Overrides aplicados: $appliedOverrides"
Write-Host "Backup global: $backupDir"
Write-Host "Inventario atualizado: $skillsIndexFile"
