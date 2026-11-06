# Agent Skills Creation Reference

This document defines the design standard for Agent Skills within the OMF repository.

---

## Part 1: Agent Skills Fundamentals

### The Core Model

A skill is a self-contained unit of domain-specific procedure.

- **Structure**: `folder` $\rightarrow$ `SKILL.md` (instructions) + optional `references/` (knowledge), `scripts/` (logic), and `assets/` (templates).
- **Loading**: Progressive disclosure. Discovery (name/description) $\rightarrow$ Activation (`SKILL.md`) $\rightarrow$ On-demand (resources).

### Description & Activation

Optimize for user intent, not keywords.

- **Goal-Oriented**: Describe what the user is trying to accomplish and the expected outcome.
- **Concise**: Keep activation text specific but brief.
- **Example**: Prefer _"Use when a user wants to document a computational model"_ over _"Triggers: document model, generate ODD."_

### Output Contracts

Every skill must define a predictable contract:

- **Inputs/Outputs**: Clear requirements and expected deliverables.
- **Success/Failure**: Explicit criteria for a "complete" task and conditions that trigger failure.
- **Structure**: Use structured outputs (JSON/YAML) when the result is consumed by downstream skills.

### Skill Interface Contracts

Every skill must expose a compact operational contract covering:

- **Activation boundary**: when the skill should and should not run.
- **Decision authority**: which methodological or operational decisions it may make or revise.
- **Inputs and preconditions**: what it requires and how it handles missing or conflicting inputs.
- **Permitted effects**: what it may create, modify, execute, publish, or only recommend.
- **Invariants**: commitments it must preserve while acting.
- **Outputs and completion**: promised deliverables and the conditions for claiming completion.
- **Handoffs and failure behavior**: when to route, what evidence to pass, and whether to stop or continue.
- **Provenance obligations**: which activities and outputs require a traceable record.

Use `docs/skill-contracts.md` for the shared vocabulary. Keep the independently useful operational subset in each `SKILL.md`; do not repeat the repository-wide explanation in every skill.

Frontmatter metadata must point to the portable stewardship record with
`omf-stewardship: stewardship.yaml`. Put mutable maintenance, stability,
review, evaluation, and guidance-provenance state in that record rather than
duplicating it in activation context. Follow
`docs/skill-stewardship-contract.md` and update the subject manifest whenever
behavior-affecting skill content changes.

### Artifact Authority

Artifact ownership defines methodological authority, not exclusive write access. The owning skill defines an artifact's purpose, structure, invariants, and acceptance criteria and resolves conflicting changes. A contributing skill may modify only the fields or sections named in the artifact contract. A consuming skill may read and reference the artifact but does not modify it.

Every shared artifact contract should identify:

- the owning skill;
- permitted contributors and the scope of their changes;
- protected decisions contributors must not reinterpret;
- the conditions that require routing a proposed change to the owner.

Any skill may flag contradictory or stale content. It should not silently correct content outside its contribution scope. Explicit user direction may authorize an exceptional change, but the agent should preserve provenance and report the contract exception.

Use `docs/artifact-contracts.md` as the repository-wide registry. Keep the operational subset needed by an independently installed skill in that skill's `SKILL.md`.

### Provenance for Skill-Produced Artifacts

Treat a skill as a versioned provenance agent. For each material creation or revision under `omf-artifacts/`, record:

- the artifact and activity identifiers;
- the artifact's contract authority and the skills that actually participated;
- repository source, release version when available, and exact Git revision or content hash when observable;
- input artifacts, templates, software, datasets, and methodological sources used;
- consequential decisions and their rationale;
- creation or revision time and review status;
- user-authorized contract exceptions;
- relations to upstream, derived, superseded, or invalidated artifacts.

Use `omf-artifacts/fair/provenance-manifest.json` as the canonical project-level lineage record. Model material revisions as immutable entities and activities: retain a stable logical ID, issue a new revision ID, and link the new revision to its predecessor. Treat the manifest append as part of the transaction it records, not a recursively separate material change. Record artifact contract authority separately from agents that actually participated. Do not store raw prompts, hidden reasoning, secrets, or unnecessary personal data. Record a normalized activity summary, explicit parameters, evidence, decisions, sensitivity, and redaction status instead. Use `unknown` rather than inventing unavailable identity or runtime values.

Skill identity follows the repository release when installed from a release. Record the exact Git revision when running from a checkout; otherwise record a content hash when practical. The manifest schema is owned by `fair`; other skills may append conforming evidence for artifacts they create or revise.

Every independently installed skill must retain the operational commit rule: request explicit approval of every consequential commit capable of affecting scientific claims, presenting its changes, scientific implications, and complete message before committing. Message approval alone is insufficient; routine meaning-preserving commits need no scientific gate. Use compact `OMF-Skills` and `Agent-Skills` trailers for actual contributing OMF and other skills respectively; omit empty trailers and retain exact executed revisions in provenance records. Follow `docs/skill-contracts.md` under Commit provenance and message review. Keep artifact ownership in the manifest and avoid duplicating Git history. Prefer native choices plus free-text feedback when available, with a plain-text fallback for other agents; no default or silence constitutes approval.

### Evaluation

Evaluation gathers scoped evidence about observed skill behavior; it does not
verify universal quality or scientific correctness. Agent behavior depends on
the model, runtime, grader, prompts, artifacts, and context, and the available
evaluation methods remain a dark art that may never be fully vettable.

- **A/B Testing**: Run identical realistic prompts with and without the skill.
- **Metrics**: Compare satisfaction of named criteria, efficiency (steps taken), and observed failure modes.
- **Concrete Triggers**: Test with realistic user phrasing, including "near-miss" cases that should NOT trigger the skill.
- **Evidence scope**: Grade the agent's behavior and task outputs, including any
  artifacts it creates. Keep evidence about the evaluated skill in evaluation
  results and stewardship records; do not reuse it as evidence about the
  scientific model, dataset, workflow, or other task artifact. Likewise,
  evidence about a task artifact does not establish that the skill is reliable.
- **Calibrated reporting**: Record the exact conditions, observations,
  limitations, and unresolved uncertainty. Never turn a passing case, aggregate
  score, review, or recent date into a guarantee or certification.

---

## Part 2: OMF Design Philosophy

### The Golden Rule: Add Only What the Agent Lacks

Do not waste context on generic knowledge.

- **Encode**: Expert workflows, community standards, non-obvious pitfalls, and methodological tradeoffs.
- **Exclude**: General software engineering or common modeling advice that foundation models already handle reliably.
- **Mantra**: If the agent would succeed without it, remove it.

### Externalize Consequential Reasoning

Transparency is a requirement, not an option. Skills must prevent "silent" scientific decisions.

- **Provenance**: Surface all consequential analytical choices (method selection, assumptions, priors).
- **Justification**: Require the agent to explain _why_ a specific path was taken based on encoded standards.
- **Intermediate Artifacts**: Emit staging artifacts (e.g., inferred assumptions list) for user review before finalization.

### Composability & Scope Discipline

Prefer many small, specialized skills over few comprehensive ones.

- **One Responsibility**: Each skill owns a single methodological step.
- **Predictability**: Minimal hidden state; clear input $\rightarrow$ clear output.
- **Routing over Expansion**: Favor routing over expanding a skill's scope. If a concern belongs to another skill, route the user to it instead of duplicating guidance.

### Architectural Rule: Favor Routing

Do not build "God-skills." When a workflow spans multiple domains:

1. Identify the specialist skill for the sub-task.
2. Instruct the current skill to delegate or route to that specialist.
3. Maintain a clean boundary between orchestration and execution.

---

## Design Mantra

**Encode how experienced practitioners make, justify, document, and communicate consequential decisions while minimizing context cost.**
