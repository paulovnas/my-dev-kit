# Memory Write Policy (Senior Fullstack)

This policy defines when `senior-fullstack` should write to `.memory/*` and when it should skip updates.

## Objective

Prevent memory bloat while preserving high-value, durable knowledge for future tasks.

## Decision Rule

Write memory only if one of these conditions is true:

1. Hard trigger happened (contract, architecture, security/compliance, SLO, incident runbook change).
2. Scored trigger reached threshold (`Impact + Durability + Reusability + Risk of Forgetting >= 8`).

Otherwise, skip memory write.

## Why this policy

1. Long context quality depends on key information density and position.
2. Overloaded memory harms retrieval and increases noise.
3. Hierarchical memory with selective retention outperforms flat accumulation.

## Practical Heuristics

Write:

- cross-feature decisions;
- contract and data-model changes;
- operational guardrails and risk controls;
- business decisions that will influence future implementation.

Skip:

- purely local edits;
- cosmetic adjustments without behavior impact;
- temporary notes already resolved in current task.

## Memory Placement

- `product.md`: business rules, scope, KPI definitions, product rationale.
- `structure.md`: module boundaries, flow/contract impacts.
- `tech.md`: stack constraints, integration/security/perf decisions, migration strategy.

## Compaction Link

If files become large, use `project-memory` compaction flow and archive details instead of keeping all raw history in main files.

## Sources

- LongLLMLingua: [https://arxiv.org/abs/2310.06839](https://arxiv.org/abs/2310.06839)
- LLMLingua: [https://arxiv.org/abs/2310.05736](https://arxiv.org/abs/2310.05736)
- Lost in the Middle: [https://arxiv.org/abs/2307.03172](https://arxiv.org/abs/2307.03172)
- MemGPT: [https://arxiv.org/abs/2310.08560](https://arxiv.org/abs/2310.08560)
- Memory Survey: [https://arxiv.org/abs/2404.13501](https://arxiv.org/abs/2404.13501)
- LangGraph Memory Overview: [https://docs.langchain.com/oss/python/langgraph/memory](https://docs.langchain.com/oss/python/langgraph/memory)
