---
name: senior-fullstack
description: Comprehensive fullstack orchestrator skill for building complete web applications with React, Next.js, Node.js, GraphQL, and PostgreSQL. Includes project scaffolding, code quality analysis, architecture patterns, embedded best-practice packs for Fastify, Next.js, React performance, Service Worker, and TypeScript conventions, plus project memory grounding via .memory/product.md, .memory/structure.md, and .memory/tech.md with selective write-back (only high-signal changes). Also enforces automatic migration execution for database schema changes (Laravel and Supabase), escalating to the user only when execution fails.
---

# Senior Fullstack

Complete fullstack toolkit with automation scripts plus embedded specialist guidance.

## Quick Start

### Main Capabilities

This skill provides three core capabilities through automated scripts:

```bash
# Script 1: Fullstack Scaffolder
python scripts/fullstack_scaffolder.py [options]

# Script 2: Project Scaffolder
python scripts/project_scaffolder.py [options]

# Script 3: Code Quality Analyzer
python scripts/code_quality_analyzer.py [options]
```

## Project Memory Protocol (.memory)

Before planning, architecture decisions, or implementation, always ground context in:

- `.memory/product.md`
- `.memory/structure.md`
- `.memory/tech.md`

### Mandatory behavior

1. Read these three files first when they exist.
2. If `.memory` is missing, or any required file is missing, instruct the user to run `project-memory` skill to generate the baseline.
3. If files are shallow/outdated, recommend refreshing them with `project-memory` before major work.
4. Treat `.memory/*` as project source of truth for business and technical context unless user explicitly overrides.
5. Do not update memory by default after every change; write-back only when the Memory Write Gate approves.

### Memory Write Gate (Selective Updates)

Use this gate before any memory write-back. Update memory only when change has durable and reusable value.

Hard triggers (always write):

1. New or changed business rule, KPI definition, scope contract, pricing/policy rule.
2. Architecture or module-boundary decision affecting multiple features.
3. Data model or integration contract change (API schema, event contract, auth model, migration strategy).
4. Security/compliance/performance SLO decision.
5. Production incident outcome that changes runbook/guardrails.

Scored triggers (write only if score >= 8/12):

Score each criterion from 0-3:

1. Impact: how much this changes behavior, delivery, or risk.
2. Durability: expected lifetime of the decision (temporary vs long-lived).
3. Reusability: how often this context will help future tasks.
4. Risk/Cost of forgetting: potential regressions/confusion if not documented.

Write if total >= 8.

Do not write for low-signal changes:

1. Pure refactor without behavioral impact.
2. Cosmetic UI text/style tweaks with no product or flow impact.
3. Local bugfix with narrow scope and no architectural implication.
4. Routine dependency patch without policy/contract impact.
5. Temporary investigation notes that are already resolved.

If gate does not pass:

- explicitly state `Memory write skipped (low-signal change).`
- keep working normally without forcing `project-memory`.

If gate passes, expected write-back:

- update `.memory/product.md` only for business impact/rationale;
- update `.memory/structure.md` only for module/flow/contract impacts;
- update `.memory/tech.md` only for technical decisions, constraints, and trade-offs.
- keep updates compact and append archival links when details are too long.

Memory checkpoint at end of task:

1. summarize what changed in one short list;
2. apply Memory Write Gate;
3. if gate passes, update only the affected memory file(s);
4. if gate fails, explicitly report skip and do not write memory.

Reference:

- `references/memory-write-policy.md`

### How to instruct the user

Use direct guidance like:

`Para seguirmos com base solida, execute a skill project-memory para gerar/atualizar .memory/product.md, .memory/structure.md e .memory/tech.md.`

## Skill Orchestration Layer

`senior-fullstack` acts as a central orchestrator for related skills available in this toolkit.

### Skill routing rules

1. Use `project-memory` when context is missing/outdated, or when Memory Write Gate indicates a high-signal change.
2. Use `ui-ux-pro-max` whenever the task includes frontend visual/interface changes (layout, component behavior, interaction states, accessibility, responsive adjustments, design system updates).
3. Keep specialist packs (Fastify/Next.js/React/Service Worker/TypeScript) as technical guardrails while orchestrating memory and UX skills.

### Frontend mandatory routing

If the task touches frontend experience, always:

1. apply `ui-ux-pro-max` for implementation/review quality;
2. propagate only high-signal decisions to `.memory/*` via Memory Write Gate.

## Chrome DevTools MCP Test Protocol

When the user asks to test with `chrome-devtools` MCP:

1. If the user already provided URL/port, use it.
2. If URL/port is missing, do not block. Suggest testing common local ports based on stack:
   - Vite: `http://localhost:5173`
   - Next.js: `http://localhost:3000`
   - CRA/Webpack: `http://localhost:3000`
   - Angular: `http://localhost:4200`
   - Vue CLI: `http://localhost:8080`
3. Ask the user to confirm which URL is active if the first guess fails.
4. Never assume production URLs when local context indicates development.

### Dev server startup rule

- Do not automatically execute server startup commands such as `npm run dev`, `pnpm dev`, `yarn dev`.
- Request the user to start the server (or confirm it is already running) before browser MCP validation.

Suggested message:

`Para validar com chrome-devtools MCP, me confirme a URL ativa. Se preferir, teste primeiro em http://localhost:5173 (Vite) ou http://localhost:3000 (Next/React).`

## Embedded Specialist Packs

This skill now incorporates the scope of the following best-practice skills from `ts-dev-kit`:

- `fastify-best-practices`
- `nextjs-best-practices`
- `react-best-practices`
- `service-worker`
- `typescript-conventions`

All imported references are stored under:

- `references/incorporated-skills/fastify-best-practices/`
- `references/incorporated-skills/nextjs-best-practices/`
- `references/incorporated-skills/react-best-practices/`
- `references/incorporated-skills/service-worker/`
- `references/incorporated-skills/typescript-conventions/`

### Trigger-to-Reference Mapping

When a task matches any topic below, load and apply the related pack before coding or reviewing:

- Fastify routes/plugins/hooks/validation/errors:
  - `references/incorporated-skills/fastify-best-practices/SKILL.source.md`
  - `references/incorporated-skills/fastify-best-practices/references/*.md`
- Next.js App Router, RSC boundaries, route handlers, metadata, hydration:
  - `references/incorporated-skills/nextjs-best-practices/SKILL.source.md`
  - `references/incorporated-skills/nextjs-best-practices/references/*.md`
- React rendering/performance/bundle optimization:
  - `references/incorporated-skills/react-best-practices/SKILL.source.md`
  - `references/incorporated-skills/react-best-practices/references/*.md`
- Service Worker, PWA caching, push, background sync:
  - `references/incorporated-skills/service-worker/SKILL.source.md`
  - `references/incorporated-skills/service-worker/references/*.md`
- Type safety conventions, unions/generics/narrowing/import patterns:
  - `references/incorporated-skills/typescript-conventions/SKILL.source.md`

### Execution Rule

For mixed fullstack requests, combine packs as needed:

1. Apply `typescript-conventions` baseline first.
2. Apply framework pack(s): Fastify, Next.js, React.
3. Apply Service Worker pack for offline/push requirements.
4. Keep architecture and workflow alignment with this skill's native references.
5. Reconcile decisions against `.memory/product.md`, `.memory/structure.md`, and `.memory/tech.md`.
6. Route frontend changes through `ui-ux-pro-max`.
7. Route context creation and refresh through `project-memory` only when Memory Write Gate passes.
8. For browser MCP tests, use port inference protocol and ask user confirmation if URL is unknown.
9. Execute required migrations whenever schema changes are part of the implementation.

## Mandatory Post-Change Quality Gate

After code changes, always validate that nothing broke:

1. Run `typecheck` command for the project.
2. Run `build` command for the project.
3. Report pass/fail clearly and summarize errors when failures happen.

### Command resolution order

Use project scripts first (in `package.json`):

1. `npm run typecheck` (or `pnpm typecheck` / `yarn typecheck`)
2. If no `typecheck` script exists, run a safe equivalent for the stack (for TypeScript: `npx tsc --noEmit`).
3. Run `npm run build` (or `pnpm build` / `yarn build`).

### Important

- Do not skip these checks after modifications unless the user explicitly asks to skip.
- If checks cannot run, explain why and what is missing.

## Database Migration Execution Policy

Whenever database schema changes are introduced (new field, removed field, type change, constraints, indexes), migration execution is mandatory.

### Mandatory behavior

1. Create or update migration files as part of the change.
2. Execute migrations automatically in the current environment.
3. Confirm migration success and report status.
4. If migration execution fails, provide the exact error and ask the user to run the command/tool when available.

### Laravel migration flow

Use Laravel workflow by default in Laravel projects:

1. generate/edit migration file;
2. execute `php artisan migrate`;
3. if command fails, ask user to run `php artisan migrate` and share output.

### Supabase migration flow

Use Supabase migration workflow in Supabase projects:

1. if Supabase MCP is installed/available, execute migration through MCP first (`apply_migration` for DDL and related MCP calls for validation/listing);
2. if MCP is not available, use Supabase CLI migration flow;
3. execute migration against target environment (`supabase db push` or project-standard command);
4. if execution fails, ask user to run the migration command and share output.

### Do not skip

- Never leave schema changes unapplied.
- Only defer execution when environment/access limitations prevent running migration commands.
- In defer cases, clearly hand off the exact command to the user.

## Core Capabilities

### 1. Fullstack Scaffolder

Automated tool for fullstack scaffolder tasks.

**Features:**
- Automated scaffolding
- Best practices built-in
- Configurable templates
- Quality checks

**Usage:**
```bash
python scripts/fullstack_scaffolder.py <project-path> [options]
```

### 2. Project Scaffolder

Comprehensive analysis and optimization tool.

**Features:**
- Deep analysis
- Performance metrics
- Recommendations
- Automated fixes

**Usage:**
```bash
python scripts/project_scaffolder.py <target-path> [--verbose]
```

### 3. Code Quality Analyzer

Advanced tooling for specialized tasks.

**Features:**
- Expert-level automation
- Custom configurations
- Integration ready
- Production-grade output

**Usage:**
```bash
python scripts/code_quality_analyzer.py [arguments] [options]
```

## Reference Documentation

### Tech Stack Guide

Comprehensive guide available in `references/tech_stack_guide.md`:

- Detailed patterns and practices
- Code examples
- Best practices
- Anti-patterns to avoid
- Real-world scenarios

### Architecture Patterns

Complete workflow documentation in `references/architecture_patterns.md`:

- Step-by-step processes
- Optimization strategies
- Tool integrations
- Performance tuning
- Troubleshooting guide

### Development Workflows

Technical reference guide in `references/development_workflows.md`:

- Technology stack details
- Configuration examples
- Integration patterns
- Security considerations
- Scalability guidelines

### Incorporated Best-Practices References

- Fastify pack: `references/incorporated-skills/fastify-best-practices/`
- Next.js pack: `references/incorporated-skills/nextjs-best-practices/`
- React pack: `references/incorporated-skills/react-best-practices/`
- Service Worker pack: `references/incorporated-skills/service-worker/`
- TypeScript conventions pack: `references/incorporated-skills/typescript-conventions/`

## Tech Stack

**Languages:** TypeScript, JavaScript, Python, Go, Swift, Kotlin
**Frontend:** React, Next.js, React Native, Flutter
**Backend:** Node.js, Express, GraphQL, REST APIs
**Database:** PostgreSQL, Prisma, NeonDB, Supabase
**DevOps:** Docker, Kubernetes, Terraform, GitHub Actions, CircleCI
**Cloud:** AWS, GCP, Azure

## Development Workflow

### 1. Setup and Configuration

```bash
# Install dependencies
npm install
# or
pip install -r requirements.txt

# Configure environment
cp .env.example .env
```

### 2. Run Quality Checks

```bash
# Use the analyzer script
python scripts/project_scaffolder.py .

# Review recommendations
# Apply fixes
```

### 3. Implement Best Practices

Follow the patterns and practices documented in:
- `references/tech_stack_guide.md`
- `references/architecture_patterns.md`
- `references/development_workflows.md`
- `references/incorporated-skills/fastify-best-practices/`
- `references/incorporated-skills/nextjs-best-practices/`
- `references/incorporated-skills/react-best-practices/`
- `references/incorporated-skills/service-worker/`
- `references/incorporated-skills/typescript-conventions/`

## Best Practices Summary

### Code Quality
- Follow established patterns
- Write comprehensive tests
- Document decisions
- Review regularly

### Performance
- Measure before optimizing
- Use appropriate caching
- Optimize critical paths
- Monitor in production

### Security
- Validate all inputs
- Use parameterized queries
- Implement proper authentication
- Keep dependencies updated

### Maintainability
- Write clear code
- Use consistent naming
- Add helpful comments
- Keep it simple

## Common Commands

Use `dev` only when the user explicitly asks for server startup or confirms it is needed for validation.

```bash
# Development
npm run dev
npm run build
npm run test
npm run lint

# Analysis
python scripts/project_scaffolder.py .
python scripts/code_quality_analyzer.py --analyze

# Deployment
docker build -t app:latest .
docker-compose up -d
kubectl apply -f k8s/
```

## Troubleshooting

### Common Issues

Check the comprehensive troubleshooting section in `references/development_workflows.md`.

### Getting Help

- Review reference documentation
- Check script output messages
- Consult tech stack documentation
- Review error logs

## Resources

- Pattern Reference: `references/tech_stack_guide.md`
- Workflow Guide: `references/architecture_patterns.md`
- Technical Guide: `references/development_workflows.md`
- Fastify Best Practices: `references/incorporated-skills/fastify-best-practices/SKILL.source.md`
- Next.js Best Practices: `references/incorporated-skills/nextjs-best-practices/SKILL.source.md`
- React Best Practices: `references/incorporated-skills/react-best-practices/SKILL.source.md`
- Service Worker: `references/incorporated-skills/service-worker/SKILL.source.md`
- TypeScript Conventions: `references/incorporated-skills/typescript-conventions/SKILL.source.md`
- Tool Scripts: `scripts/` directory
