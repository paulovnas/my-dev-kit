# my-dev-kit

Kit central para uso de **skills** no Codex, com sincronizacao entre repositorio e skills globais da maquina.

## Foco Atual

Este repositorio esta focado em skills (nao em agents).  
Objetivo: manter um baseline de skills versionado e publicar rapidamente no ambiente global.

## Skills-chave

- `senior-fullstack` (orquestrador):
  - centraliza decisao de uso de outras skills;
  - usa `project-memory` para ler **e** escrever melhorias em `.memory/*`;
  - usa `ui-ux-pro-max` quando houver alteracoes de frontend.
- `project-memory`:
  - garante `.memory/product.md`, `.memory/structure.md`, `.memory/tech.md`;
  - gera baseline e atualiza memoria tecnica e de negocio.
- `ui-ux-pro-max`:
  - politica `shadcn-first` para projetos web;
  - usa MCP do shadcn sempre que disponivel;
  - evita copy tecnico verboso em labels/titulos (texto direto ao ponto).

## Estrutura

```text
my-dev-kit/
  docs/
    skills-index.md
  scripts/
    sync-global-skills.ps1
  skills/
    .skill-lock.json
    global/
    overrides/
```

## Sincronizacao de Skills

Script principal:

- [sync-global-skills.ps1](C:/Users/pauli/Documents/Foxtag/my-dev-kit/scripts/sync-global-skills.ps1)

Modos:

- `pull`: maquina global -> repositorio (`skills/global`) + aplica overrides locais.
- `push`: repositorio (`skills/global` + overrides) -> maquina global.
- `both` (padrao): faz pull, aplica overrides, cria backup e faz push.

### Comandos

```powershell
# Pull apenas
pwsh -NoProfile -File .\scripts\sync-global-skills.ps1 -Mode pull

# Push apenas
pwsh -NoProfile -File .\scripts\sync-global-skills.ps1 -Mode push

# Sincronizacao completa (recomendado)
pwsh -NoProfile -File .\scripts\sync-global-skills.ps1 -Mode both
```

## Backup de seguranca

Nos modos `push` e `both`, o script cria backup automatico das skills globais em:

- `C:\Users\pauli\.agents\backups\skills-sync-<timestamp>`

## Fluxo recomendado (skills-first)

1. Atualizar/salvar customizacoes em `skills/overrides/`.
2. Rodar `sync-global-skills.ps1 -Mode both`.
3. Abrir nova conversa/sessao no Codex para usar as skills atualizadas.
4. Para tarefas de projeto, acionar `senior-fullstack`.

## Teste rapido do senior-fullstack

Depois do sync (`-Mode both`), teste com prompts como:

1. "Analise este projeto e atualize a memoria .memory com melhorias de produto, estrutura e tecnologia."
2. "Refatore esta tela e aplique melhorias de UX responsiva."

Resultado esperado:

- no prompt 1: roteamento para `project-memory`;
- no prompt 2: roteamento para `ui-ux-pro-max` e atualizacao de memoria quando necessario.
