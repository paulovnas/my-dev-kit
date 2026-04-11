# Memory Compaction Guide (AI-Focused)

This guide defines safe compaction principles for `.memory/product.md`, `.memory/structure.md`, and `.memory/tech.md`.

## Goal

Increase memory density and retrieval quality without losing critical project context.

## Principles

1. Preserve facts first, compress wording second.
2. Keep active decisions explicit (with stable IDs like `DEC-*`).
3. Prefer hierarchical summaries over flat long text.
4. Move deep history to archive, do not delete silently.
5. Keep high-value items highly visible (top and end of long sections).

## Why these principles (research-backed)

1. Hierarchical summaries improve retrieval over long documents.
   - RAPTOR shows recursive summarization can improve multi-hop QA in long contexts.
2. Memory should include storage, reflection/synthesis, and retrieval.
   - Generative Agents and memory surveys emphasize that layered memory improves long-horizon behavior.
3. Context position matters for recall.
   - "Lost in the Middle" shows models may underuse information buried in long middle sections.
4. Compression must keep salient information.
   - Prompt compression work (LLMLingua / LongLLMLingua) highlights salience-aware compression.

## Compaction Checklist

Before compaction:

1. Create timestamped backup in `.memory/archive/`.
2. Identify critical units that cannot be lost:
   - active business rules;
   - active architecture constraints;
   - integration contracts;
   - open risks and open questions;
   - KPI/target definitions.

During compaction:

1. Remove redundancy and repeated explanations.
2. Convert verbose paragraphs to concise bullets.
3. Keep "current state" and "decisions" sections dense and explicit.
4. Move superseded historical detail to archive files with links.

After compaction:

1. Validate cross-file consistency (`product` x `structure` x `tech`).
2. Confirm all critical units are still present.
3. Report before/after size and archived items.

## Suggested Size Targets (soft limits)

- `product.md`: 120-220 lines
- `structure.md`: 140-260 lines
- `tech.md`: 160-300 lines

If context exceeds limits, archive depth first; keep operationally active knowledge in primary files.

## Sources

- RAPTOR: [https://arxiv.org/abs/2401.18059](https://arxiv.org/abs/2401.18059)
- Generative Agents: [https://arxiv.org/abs/2304.03442](https://arxiv.org/abs/2304.03442)
- Lost in the Middle: [https://arxiv.org/abs/2307.03172](https://arxiv.org/abs/2307.03172)
- MemGPT: [https://arxiv.org/abs/2310.08560](https://arxiv.org/abs/2310.08560)
- Memory Mechanism Survey: [https://arxiv.org/abs/2404.13501](https://arxiv.org/abs/2404.13501)
- LLMLingua: [https://arxiv.org/abs/2310.05736](https://arxiv.org/abs/2310.05736)
- LongLLMLingua: [https://arxiv.org/abs/2310.06839](https://arxiv.org/abs/2310.06839)
