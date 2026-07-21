# Computational Modeling Agent Skills: Unified Reference

## Core model

- A **skill = folder + SKILL.md + optional resources**
- Purpose: inject **domain-specific procedures + context** into an agent
- Loading uses **progressive disclosure**:
  1. name + description (discovery)
  2. full instructions (activation)
  3. referenced files (on demand)

---

## Skill design principles

### Encode expert workflows

Capture knowledge that is difficult to infer from general training:

- methodological tradeoffs
- scientific and community standards
- threats to validity and reproducibility
- consequential analytical choices

Include demonstrably effective criteria to select methods, evaluate assumptions, interpret results, and maintain transparency and provenance.

Avoid generic best-practice summaries.

### Transparency and provenance

Skills should surface consequential decisions, assumptions, and transformations.

Where applicable:

- document selected methods and their rationale
- record assumptions and defaults
- identify inferred or missing information
- expose analytical choices requiring user review
- preserve provenance sufficient for reproduction and audit

Avoid silently making consequential scientific decisions on behalf of the user.

### Intermediate artifacts

Skills should emit intermediate artifacts at important staging points rather than hiding the full workflow inside a single large output.

Capture the steps that matter for review, validation, or reuse, including:

- extracted inputs
- selected frameworks or methods
- inferred assumptions
- validation checks
- draft outputs before finalization

Avoid opaque one-shot outputs when the intermediate decisions affect transparency, provenance, or downstream use.

### Extract reusable patterns

Capture:

- successful step sequences
- corrections you applied
- edge cases encountered
- concrete inputs/outputs

---

## Scope and structure

### Coherent unit of work

- Like a function: **one composable responsibility**
- Too small → fragmentation
- Too large → bloated context

### Progressive disclosure design

- Keep `SKILL.md` focused
- Move detail into:
  - `references/` — reasoning guidance, standards, and examples
  - `scripts/` — executable logic
  - `assets/` — reusable output materials and templates

Rule of thumb:
teaches → `references/`, executes → `scripts/`, outputs → `assets`

- Explicitly instruct when to load additional resources

Example:

```text
If documenting an agent-based model → read references/odd-protocol.md

If generating a CodeMeta record → load assets/codemeta-template.json

If validating metadata completeness → run scripts/validate_metadata.py
```

---

## Composability

Skills should be designed as reusable units.

Good skills:

- have clear inputs
- have clear outputs
- avoid hidden state
- can participate in larger workflows

A skill should behave like a function:
predictable inputs, predictable outputs.

## SKILL.md structure (canonical)

### Frontmatter (required + optional)

```yaml
name: short-identifier
description: when to use this skill (≤1024 chars)
compatibility: optional environment requirements
allowed-tools: optional allowlist
metadata:
  key: value
```

### Body (no strict schema, but recommended)

Include:

- step-by-step instructions
- input/output examples and contracts
- edge cases and failure handling

---

## Writing effective instructions

### Add only what the agent lacks

- Include:
  - methodological assumptions
  - domain-specific standards, tools, and methods
  - non-obvious pitfalls

- Exclude:
  - general knowledge (HTTP, PDFs, etc.)

### Be concrete and opinionated

- Prefer:
  - “Use library X”
  - “Check condition Y”

- Avoid:
  - vague guidance
  - multiple equivalent options without default

### Optimize for execution traces

If the agent:

- hesitates → instructions too vague
- tries many paths → missing defaults
- wastes steps → irrelevant instructions

Refine accordingly

---

## Output Contracts

Skills should define:

- expected outputs
- output structure
- success criteria
- failure conditions
- consequential analytical choices (method selection, priors, exclusions, calibration strategies)

Prefer structured outputs when downstream skills may consume results.

A skill should be predictable to both users and other skills.

---

## Missing information

Skills should explicitly state:

- what may be inferred
- what must not be inferred

When information is unavailable:

- identify the gap
- explain limitations
- request clarification if necessary

Prefer incomplete but accurate outputs over fabricated details.

## Description (activation-critical)

- Format: **imperative trigger**
  - “Use this skill when…”

- Focus on **user intent**, not implementation
- Include implicit cases (not just explicit keywords)
- Keep concise but specific

### Optimize for user intent

Descriptions should describe:

- what the user is trying to accomplish
- when the skill is appropriate
- expected inputs and outputs

Avoid keyword lists unless they clarify ambiguous cases.

Prefer: "Use when a user wants to document a computational model."

Over: "Triggers: document model, generate ODD, write narrative."

---

## Context efficiency

- Every token competes with:
  - conversation
  - system prompt
  - other skills

- Rule:

  > If the agent would succeed without it, remove it

---

## Scripts (optional)

Use `scripts/` when:

- commands are complex or error-prone

Guidelines:

- self-contained or declare dependencies
- deterministic outputs
- clear stdout/stderr for agent decisions
- prefer version-pinned tools

---

## References (optional)

Use `references/` for:

- large documentation
- schemas, formats, domain rules

Guidelines:

- small, focused files
- shallow linking (avoid deep chains)
- load only when needed

---

## Evaluation loop (required for quality)

### Test structure

Each test:

- representative prompt (realistic)
- representative artifacts
- expected outcomes

### Method

Run:

- with skill
- without skill

Compare:

- correctness
- efficiency
- failure modes

### Iterate

Refine based on:

- false positives
- missed cases
- unnecessary steps

---

## Trigger evaluation (description testing)

- Build ~20 queries:
  - should trigger
  - should not trigger

- Include:
  - vague phrasing
  - realistic context
  - near-miss negatives
  - prompts intended for neighboring skills

---

## Directory layout (reference)

```text
my-skill/
├── SKILL.md
├── scripts/        # executable logic
├── references/     # optional docs
├── assets/         # templates/data
└── evals/          # tests
```

---

## Heuristics checklist

**Good skill:**

- grounded in real workflows
- scoped to one composable responsibility
- minimal but specific
- has clear trigger conditions
- surfaces consequential decisions and assumptions
- produces predictable outputs
- tested against realistic prompts and artifacts

**Bad skill:**

- generic advice
- redundant with base model ability
- overly verbose
- ambiguous activation
- hides important decisions or transformations
- produces inconsistent outputs
- untested

---

## Design mantra

Encode how experienced practitioners make, justify, and document consequential decisions.

## References

This document was heavily influenced by the following:

- [Agent Skills Overview](https://agentskills.io/home)
- [Best Practices for Skill Creators](https://agentskills.io/skill-creation/best-practices)
- [Specification](https://agentskills.io/specification)
- [Optimizing Skill Descriptions](https://agentskills.io/skill-creation/optimizing-descriptions)
- [Using Scripts in Skills](https://agentskills.io/skill-creation/using-scripts)
- [Evaluating Skill Output Quality](https://agentskills.io/skill-creation/evaluating-skills)
