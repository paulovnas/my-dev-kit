---
name: senior-fullstack
description: Comprehensive fullstack orchestrator skill for building complete web applications with React, Next.js, Node.js, GraphQL, and PostgreSQL. Includes project scaffolding, code quality analysis, architecture patterns, embedded best-practice packs for Fastify, Next.js, React performance, Service Worker, and TypeScript conventions, plus mandatory project memory grounding and updates via .memory/product.md, .memory/structure.md, and .memory/tech.md.
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
5. After relevant changes, update memory artifacts through `project-memory` (not only reading).

### Mandatory write-back to memory

Trigger `project-memory` updates whenever there is:

1. New business rule, KPI, scope change, or product decision.
2. Architecture/module boundary change.
3. Stack/dependency/infrastructure/security/performance decision change.
4. Significant frontend UX/UI or navigation flow change.

Expected write-back:

- update `.memory/product.md` for business impact and product rationale;
- update `.memory/structure.md` for module/flow impacts;
- update `.memory/tech.md` for technical decisions and trade-offs.

### How to instruct the user

Use direct guidance like:

`Para seguirmos com base solida, execute a skill project-memory para gerar/atualizar .memory/product.md, .memory/structure.md e .memory/tech.md.`

## Skill Orchestration Layer

`senior-fullstack` acts as a central orchestrator for related skills available in this toolkit.

### Skill routing rules

1. Use `project-memory` when context is missing, outdated, or after major decisions to persist project knowledge.
2. Use `ui-ux-pro-max` whenever the task includes frontend visual/interface changes (layout, component behavior, interaction states, accessibility, responsive adjustments, design system updates).
3. Keep specialist packs (Fastify/Next.js/React/Service Worker/TypeScript) as technical guardrails while orchestrating memory and UX skills.

### Frontend mandatory routing

If the task touches frontend experience, always:

1. apply `ui-ux-pro-max` for implementation/review quality;
2. propagate relevant decisions to `.memory/*` via `project-memory`.

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
7. Route context creation and refresh through `project-memory`.
8. For browser MCP tests, use port inference protocol and ask user confirmation if URL is unknown.

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
