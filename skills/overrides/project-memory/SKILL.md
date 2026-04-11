---
name: project-memory
description: Cria, mantem e otimiza memoria tecnica e de negocio para projetos no padrao .memory (product.md, structure.md, tech.md). Use sempre que iniciar projeto novo, onboarding, descoberta de contexto, definicao de arquitetura, quando o senior-fullstack precisar de base solida, e tambem para compactar/otimizar memorias existentes sem perder informacoes criticas.
---

# Project Memory

Skill para organizar memoria de projeto com foco em decisao de negocio e execucao tecnica, incluindo modo de compactacao segura para reduzir volume sem perder contexto essencial.

## Contrato Obrigatorio

Sempre cumprir este contrato:

1. Garantir a pasta `.memory` na raiz do projeto.
2. Garantir os 3 arquivos obrigatorios:
   - `.memory/product.md`
   - `.memory/structure.md`
   - `.memory/tech.md`
3. Se faltar qualquer arquivo, criar imediatamente com alto nivel de detalhe.
4. Se os arquivos existirem, atualizar sem perder informacao valida.
5. Permitir arquivos extras de memoria definidos pelo usuario, sem alterar o contrato base.
6. Quando o usuario solicitar otimizacao/compactacao, executar processo de compactacao segura.

## Quando Usar

Use esta skill quando:

- projeto novo ainda sem contexto documentado;
- contexto fragmentado em README, codigo, tickets e notas;
- o usuario pedir para "entender o projeto" antes de implementar;
- o `senior-fullstack` precisar de base de produto e tecnologia;
- houver mudanca relevante de negocio, arquitetura ou stack.
- as memorias crescerem demais e precisarem ser otimizadas/compactadas.

## Modos de Operacao

### Modo A: Bootstrap (criar do zero)

Use quando `.memory` nao existir ou estiver incompleto.

### Modo B: Update (atualizar memoria)

Use quando arquivos existem, mas precisam refletir mudancas recentes.

### Modo C: Optimize/Compact (otimizar sem perda critica)

Use quando os arquivos estao extensos, redundantes, com repeticoes ou dificeis de recuperar.
O objetivo e aumentar densidade de informacao sem apagar decisoes, contratos, riscos e contexto operacional importante.

## Fluxo de Execucao

### 1) Descobrir contexto antes de escrever

Colete contexto do projeto por esta ordem:

1. `README.md`
2. `package.json`, lockfiles, scripts de build/test/lint
3. estrutura de pastas e modulos principais
4. configuracoes de infraestrutura e deploy
5. docs existentes (arquitetura, ADRs, runbooks)

Se faltarem dados, registre lacunas explicitas em "Open Questions".

### 2) Criar ou preparar base de memoria

Use os templates:

- `references/product-template.md`
- `references/structure-template.md`
- `references/tech-template.md`

Opcionalmente, use o script:

```bash
python scripts/init_memory.py --project-root . --project-name "Meu Projeto"
```

Para sobrescrever com novo baseline:

```bash
python scripts/init_memory.py --project-root . --force
```

### 3) Otimizacao e compactacao segura (quando aplicavel)

Antes de compactar semanticamente, execute compactacao estrutural segura:

```bash
python scripts/optimize_memory.py --project-root . --dry-run
python scripts/optimize_memory.py --project-root .
```

Regras obrigatorias de compactacao segura:

1. Criar backup versionado em `.memory/archive/compaction-<timestamp>/` antes de alterar.
2. Preservar obrigatoriamente:
   - decisoes de negocio/tecnicas ativas;
   - contratos internos/externos e integracoes;
   - riscos, dependencias, constraints e open questions;
   - KPIs/metas e definicoes de sucesso.
3. Remover redundancia (duplicatas, repeticoes e verbosidade) sem remover fatos importantes.
4. Reorganizar para recuperacao rapida:
   - resumo executivo no topo;
   - itens criticos no inicio/fim de secoes longas;
   - historico detalhado movido para arquivos de archive quando necessario.
5. Registrar o que foi compactado, o que foi preservado e o que foi arquivado.

Guia de referencia para compactacao focada em IA:

- `references/memory-compaction-guide.md`

### 4) Preencher com profundidade maxima

Nao deixe seco ou generico. Cada arquivo deve trazer:

- estado atual;
- decisoes tomadas e rationale;
- riscos e trade-offs;
- itens em aberto com proximo passo.

### 5) Validar consistencia cruzada

Antes de finalizar:

1. conferir se `product.md` conversa com `tech.md` (KPIs vs limites tecnicos);
2. conferir se `structure.md` reflete o codigo atual;
3. listar conflitos e incertezas em "Open Questions".
4. verificar se nenhum item critico foi perdido no processo de compactacao.

## Padrao de Qualidade por Arquivo

### `.memory/product.md`

Deve cobrir:

- problema de negocio e proposta de valor;
- personas/usuarios e casos de uso;
- escopo in/out e prioridades;
- metricas de sucesso (KPIs) e metas;
- roadmap curto prazo e riscos de produto.

### `.memory/structure.md`

Deve cobrir:

- mapa de modulos e responsabilidades;
- fronteiras entre camadas/contextos;
- fluxos de dados e contratos internos;
- estrategia de qualidade (testes, lint, gates);
- debito tecnico conhecido e plano de evolucao.

### `.memory/tech.md`

Deve cobrir:

- stack e versoes;
- dependencias criticas e integracoes externas;
- seguranca, performance e observabilidade;
- CI/CD, ambientes e release strategy;
- riscos tecnicos, migracoes e guardrails.

## Integracao com Senior Fullstack

Esta skill existe para elevar a qualidade do `senior-fullstack`.

Sempre que a tarefa envolver planejamento, arquitetura ou execucao ampla:

1. gerar/atualizar `.memory/*` com esta skill;
2. orientar o uso do `senior-fullstack` com base nesses arquivos;
3. apos mudancas grandes, sugerir refresh da memoria.

## Saida Esperada

Ao concluir, sempre reportar:

1. arquivos criados/atualizados em `.memory/`;
2. principais decisoes de produto e tecnologia capturadas;
3. lacunas criticas que ainda precisam resposta do usuario;
4. resultado da compactacao (antes/depois, itens preservados, itens arquivados), quando o modo Optimize/Compact for usado.
