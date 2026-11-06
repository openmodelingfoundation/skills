---
name: omfb
description: |
  Use this skill when planning or reviewing the implementation of a computational
  model as research software. Helps translate scientific models into maintainable
  implementations, preserve traceability to the conceptual model, identify
  implementation risks, and delegate platform-specific practices to specialized
  guidance.

  Expected output: implementation guidance, implementation review, implementation
  planning, and routing to platform-specific implementation guidance.
license: MIT
compatibility: Works with agent-based, system dynamics, statistical, simulation,
  optimization, and hybrid computational models.
metadata:
  omf-stewardship: stewardship.yaml
---

# Model Implementation Guidance

## Skill Contract

- **Activation:** Computational-model implementation planning or review; not conceptual modeling, lifecycle assessment, or language-specific coding.
- **Authority:** Implementation architecture, module mapping, parameter representation, verification planning, and implementation-introduced decisions.
- **Preconditions:** Authoritative scientific intent, preferably current OMFA artifacts, plus available platform and repository constraints.
- **Effects:** Create or revise `omf-artifacts/implementation/` and implementation recommendations; do not rewrite root scientific artifacts.
- **Invariants:** Preserve scientific intent and trace every implementation choice to evidence or an explicit implementation assumption.
- **Outputs:** Implementation plan, component map, parameter schema, verification plan, risk register, and handoff findings as applicable.
- **Handoffs:** Return scientific contradictions to `omfa`; route stewardship or execution-platform work to `fair`, `hpc`, or `ospool` with affected evidence.
- **Completion:** Required implementation artifacts are internally consistent, checked against scientific inputs, validated, and provenance-complete or visibly deferred.
- **Failure:** Stop affected work on missing or contradictory scientific prerequisites while continuing independent analysis when safe.
- **Provenance:** Record immutable implementation revisions, actual participants, authorization, and dependency assertions.
- **Commits:** Before a commit that could affect scientific claims, present its changes, affected claims, evidence, uncertainty, and full message; request approval of that specific commit and wait. Review one commit at a time. Wording approval alone is insufficient; prior approval covers only unchanged reviewed changes and message. Routine meaning-preserving commits still need authorization but no scientific gate. Prefer native approve/revise/defer choices with free-text feedback; otherwise use plain text. Defaults or silence are not approval. List actual contributing OMF skills in `OMF-Skills` and other contributing skills in `Agent-Skills`, using comma-separated names and omitting empty trailers. Preserve legitimate `Co-authored-by` attribution. Keep exact executed revisions and ownership in provenance; do not duplicate Git history. This rule does not itself authorize a commit.

## When to Use This Skill

Use this skill to:

- plan the implementation of a conceptual model into research software.
- review implementation decisions to ensure they preserve scientific intent.
- organize model architecture for maintainability and traceability.
- identify implementation risks or prepare a model for coding agents.

Do **not** use this skill when: performing conceptual modeling, uncertainty analysis, evaluation methodology, or seeking language-specific coding advice.

## OMFA Handoff Contract

OMFB consumes the reviewable scientific artifacts produced by OMFA. They are the authoritative description of scientific intent and SHOULD be treated as the implementation specification. Implementation artifacts supplement, but never supersede, them.

For agent-based models (ABMs), `omf-artifacts/abm-spec.md` is the authoritative implementation/planning artifact. If the work is ABM implementation or ABM implementation planning and that artifact is absent, pause and route to OMFA instead of inferring or reconstructing the ABM specification.

## Required Inputs

OMFB uses reviewable artifacts as the authoritative implementation specification.

Before substantial implementation begins, the following artifacts MUST exist unless the work is explicitly exploratory or the omission is justified.

| Artifact | Status | Purpose |
|----------|--------|---------|
| `omf-artifacts/conceptual-model.md` | REQUIRED | Authoritative conceptual specification. |
| `omf-artifacts/assumptions.md` | REQUIRED | Scientific assumptions that implementation must preserve. |
| `omf-artifacts/implementation/plan.md` | OPTIONAL | Existing implementation planning, if resuming work. |

### Conditional Inputs

Load these artifacts only when they materially affect implementation decisions.

| Artifact | When Required |
|----------|---------------|
| `omf-artifacts/research-questions.md` | When implementation choices affect the questions the model is intended to answer. |
| `omf-artifacts/problem-statement.md` | When project scope or intended use influences implementation priorities. |
| `omf-artifacts/uncertainty-register.md` | When stochasticity, calibration, numerical methods, or experimental design influence implementation. |
| `omf-artifacts/analysis-plan.md` | When implementation must support planned experiments, outputs, or evaluation. |
| `omf-artifacts/stakeholder-register.md` | When implementation decisions have governance, transparency, privacy, or participation implications. |
| `omf-artifacts/abm-spec.md` | When the work is ABM implementation or ABM implementation planning. Treat as authoritative; if absent, pause and route to OMFA rather than inferring it. |

## Guidance Library

Load only the implementation guidance required from `references/`.

| Context | Guidance |
|----------|----------|
| General implementation planning | `references/implementation-planning.md` |
| Architecture and modularization | `references/architecture.md` |
| Verification planning           | `references/verification.md` |
| Stochastic simulation           | `references/stochastic.md` |
| Performance optimization        | `references/performance.md` |
| Parallel execution              | `references/parallel.md` |
| Language and framework idioms   | `references/platform-guidance.md` |

Use `references/platform-guidance.md` to choose the platform; detailed language or framework idioms belong in the project's tooling or another applicable specialist.

## Deliverables

OMFB creates or maintains:

| Artifact | Purpose |
|----------|---------|
| `omf-artifacts/implementation/plan.md` | Implementation plan |
| `omf-artifacts/implementation/architecture.md` | Implementation architecture |
| `omf-artifacts/implementation/module-mapping.md` | Mapping from conceptual model to implementation |
| `omf-artifacts/implementation/parameter-schema.md` | Externalized parameters and configuration |
| `omf-artifacts/implementation/verification-plan.md` | Implementation verification plan |

### Artifact contract

OMFB owns the structure, implementation decisions, and conflict resolution for `omf-artifacts/implementation/`. Verification, platform, and execution work may update evidence, status, and measured constraints in the applicable artifact when the source and rationale remain traceable. Contributors must not change inherited scientific intent or silently redesign the implementation architecture.

Route structural implementation changes to OMFB. If implementation evidence requires changing an OMFA-owned assumption, conceptual element, or scientific claim, preserve the upstream artifact, record the finding in the applicable implementation artifact, and route the scientific revision to OMFA.

For every material creation or revision under `omf-artifacts/implementation/`, append an immutable activity to `omf-artifacts/fair/provenance-manifest.json`. Give each revision a new entity ID, retain its stable logical ID, and link revisions with `wasRevisionOf`. Record OMFB as contract authority, actual participants, inspected OMFA artifacts and code revisions as inputs, consequential implementation decisions, and explicit dependency assertions for upstream artifacts made potentially stale. Treat the manifest append as part of the recorded transaction and deduplicate only exact retries. Do not record raw prompts or hidden reasoning. If the schema is unavailable, return `provenance_handoff` with `activity`, `entity`, `authorization`, `agents`, `inputs`, `decisions`, `review`, `dependency_assertions`, `skill_identity`, `privacy`, and `persistence: incomplete`; route it to `fair`.

## Implementation Contract

OMFB MUST:

- preserve traceability between conceptual models and implementation;
- preserve separation between scientific logic and implementation infrastructure;
- document consequential implementation decisions and implementation-introduced assumptions;
- produce reviewable implementation artifacts;
- delegate language- and platform-specific guidance when appropriate;
- return implementation findings that require revision of upstream conceptual artifacts.

OMFB MUST NOT:

- silently modify the conceptual model;
- reinterpret scientific assumptions for implementation convenience;
- introduce implementation-driven behavior without documenting and justifying it.

If an implementation choice materially changes scientific meaning, pause only the dependent work and route the proposed choice, evidence, alternatives, and affected artifacts to OMFA under its Deliberate Gates contract. Do not adopt unresolved scientific decisions, including deferred or delegated ones, as implementation specifications. Proceed with independent work and routine choices that preserve accepted scientific intent; do not re-gate an explicitly authorized decision within its accepted scope.

## Gotchas

- **Implementation can silently redefine the conceptual model.** Watch for data structures, scheduling logic, or approximation choices that change the scientific meaning of entities or relationships. Surface these explicitly rather than letting them become implicit behavior.
- **OMFB is not a coding tutor.** It provides architecture and traceability guidance; use `references/platform-guidance.md` for platform selection, and keep detailed language/framework idioms in the project's tooling or another applicable specialist.
- **Traceability without reviewability is insufficient.** A mapping from conceptual model to code is useful only if it is kept current and reviewed when either side changes.
- **Do not duplicate OMFA's work.** Conceptual modeling, uncertainty analysis, and evaluation methodology remain OMFA responsibilities; OMFB consumes their outputs, not replace them.
