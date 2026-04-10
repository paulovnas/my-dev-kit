# Checklist de Projeto Novo (Skills-First)

## 1) Sincronizar skills

```powershell
pwsh -NoProfile -File .\scripts\sync-global-skills.ps1 -Mode both
```

## 2) Garantir memoria base do projeto

1. Criar pasta `.memory` na raiz do projeto (se nao existir).
2. Garantir:
   - `.memory/product.md`
   - `.memory/structure.md`
   - `.memory/tech.md`
3. Se faltar contexto, usar `project-memory`.

## 3) Executar com senior-fullstack

1. Pedir analise inicial do projeto.
2. Pedir definicao de plano tecnico + negocio com base em `.memory/*`.
3. Em mudancas de frontend, garantir uso de `ui-ux-pro-max`.

## 4) Fechar ciclo com atualizacao de memoria

Ao final de mudancas relevantes, atualizar `.memory/*` novamente para manter contexto vivo.
