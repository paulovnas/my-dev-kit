---
name: design-system-memory
description: Cria e atualiza o arquivo .memory/design-system.md com um design system completo para projetos React/Next.js usando Tailwind CSS como fundacao. Use esta skill sempre que o projeto nao tiver design-system.md, quando houver mudancas visuais relevantes, ou quando for necessario padronizar tokens e componentes reutilizaveis com estados. Essa skill deve ser priorizada antes de implementacoes de UI que dependem de consistencia visual.
---

# Design System Memory

Skill para gerar e manter uma fonte unica de verdade de design system no arquivo `.memory/design-system.md`.

## Contrato Obrigatorio

Sempre cumprir:

1. Garantir a pasta `.memory` na raiz do projeto.
2. Garantir o arquivo `.memory/design-system.md`.
3. Se o arquivo nao existir, criar imediatamente.
4. Se o arquivo existir, atualizar sem perder decisoes validas.
5. Entregar em pagina unica, com todas as secoes no mesmo arquivo.

## Fontes de Referencia (Web)

Use estas referencias ao montar o design system:

- Catalyst (Tailwind UI): https://catalyst.tailwindui.com/docs
- Tailwind tokens/theme variables: https://tailwindcss.com/docs/customizing-spacing/
- Material Symbols guide (eixos e pesos): https://developers.google.com/fonts/docs/material_symbols
- Next.js App Router setup/base: https://nextjs.org/docs/app/getting-started/installation
- React componentes reutilizaveis: https://react.dev/learn/your-first-component
- Design Tokens Community Group (W3C): https://www.w3.org/community/design-tokens/

## Padrrao de Criacao

Base obrigatoria:

- Stack alvo: Next.js + React.js
- Foundation: Tailwind CSS
- Iconografia: Material Symbols (peso 200)
- Resultado final: `.memory/design-system.md`

## Estrutura Obrigatoria do design-system.md

Use exatamente esta estrutura de alto nivel:

1. Foundation
2. Design Principles
3. Design Tokens (baseados em Tailwind CSS)
4. Primitives
5. Components
6. Technical Requirements
7. Implementation Code Samples
8. Open Questions

### 1) Foundation

Registrar:

- objetivos do sistema visual;
- contexto do produto;
- escopo de aplicacao (web app, dashboard, etc.);
- stack (Next.js + React + Tailwind);
- icon system (Material Symbols, weight 200).

### 2) Design Principles

Definir principios curtos e acionaveis (ex.: clareza, consistencia, acessibilidade, escalabilidade, performance perceptiva).

### 3) Design Tokens (Tailwind)

Documentar tokens em formato semantico e utilitario:

- Colors (paleta Tailwind + papeis semanticos: primary, secondary, surface, border, success, warning, danger)
- Spacing com a escala obrigatoria:
  - `0, 1, 2, 4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96`
- Typography:
  - families, sizes, weights, line-height
- Border Radius:
  - `rounded-none, rounded-sm, rounded-md, rounded-lg, rounded-xl, rounded-2xl, rounded-3xl, rounded-full`

### 4) Primitives

Listar tokens base e como eles compoem componentes.

### 5) Components (Obrigatorios)

Documentar no minimo:

- Buttons (primary, secondary, outline, ghost; tamanhos sm/md/lg)
- Icons (16, 20, 24, 32, 40)
- Menu/Navigation
- Inputs (text, search)
- Dropdowns/Select
- Checkboxes & Radio buttons

Para cada componente incluir:

- objetivo;
- variacoes;
- estados: `default, hover, active, disabled, focus`;
- regras de uso;
- anti-padroes.

### 6) Technical Requirements

Garantir:

1. uso de design tokens do Tailwind;
2. componentes reutilizaveis;
3. estados completos documentados;
4. compatibilidade com Next.js e React;
5. orientacao para adocao incremental.

### 7) Implementation Code Samples

Incluir exemplos de codigo por componente com:

- snippet React/Next + Tailwind;
- classes semanticas e consistentes;
- exemplos de estados.

### 8) Open Questions

Registrar lacunas de decisao que dependem do usuario/time.

## Execucao Recomendada

Se quiser scaffolding inicial rapido, use:

```bash
python scripts/init_design_system_memory.py --project-root . --project-name "Meu Projeto"
```

Para sobrescrever baseline:

```bash
python scripts/init_design_system_memory.py --project-root . --force
```

## Regra de Linguagem de UI

No conteudo de exemplo e naming de interface:

- usar linguagem direta;
- evitar excesso tecnico para usuario final;
- preferir titulos simples e claros.

Exemplo:

- bom: `Listagem de itens`
- evitar: `Listagem de itens ativos (softdelete nao incluso)`

## Saida Esperada

Ao concluir, sempre reportar:

1. arquivo `.memory/design-system.md` criado/atualizado;
2. secoes preenchidas e componentes cobertos;
3. pendencias em `Open Questions`.
