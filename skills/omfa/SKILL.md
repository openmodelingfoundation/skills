---
name: omfa
description: |
  Guide modelers in applying good modeling practice across the full computational modeling lifecycle, from problem framing through evaluation, uncertainty disclosure, governance, and readiness for handoff to implementation.

  Use this skill when users want lifecycle guidance, quality self-assessment, required modeling deliverables, or protocol-specific checks for ABM, uncertainty, ethics, participatory modeling, deep uncertainty, or immediate lifecycle triage and handoff.

  Expected output: staged modeling guidance, identified deficiencies against required practices, handoff-readiness assessment, and a concrete set of required artifacts and review checks.
license: MIT
compatibility: Works with agent-based, system dynamics, statistical, simulation, and hybrid models
metadata:
  omf-stewardship: stewardship.yaml
---

# Good Modeling Practice

A modular guidance and skill framework for transparent, reviewable, computational modeling.

## Skill Contract

- **Activation:** Lifecycle methodology, scientific model artifacts, quality self-assessment, or scientific handoff readiness; not implementation architecture, stewardship, or narrative-only drafting.
- **Authority:** Scientific framing, conceptual structure, assumptions, uncertainty, evaluation, ethics, and lifecycle readiness.
- **Preconditions:** Project evidence or explicit user-supplied model intent; consequential unknowns remain explicit.
- **Effects:** Create or revise scientific artifacts directly under `omf-artifacts/` and recommend lifecycle actions.
- **Invariants:** Preserve evidence traceability, uncertainty, user-authorized exceptions, and specialist-owned subtrees.
- **Outputs:** Required scientific artifacts, gap findings, review checks, and handoff-readiness decisions.
- **Handoffs:** Route implementation to `omfb`, stewardship to `fair`, and publication narratives to `document`, passing relevant artifacts and unresolved decisions.
- **Completion:** Required artifacts and checks exist, validation is reported, provenance is persisted or explicitly incomplete, and required handoffs are resolved or visible.
- **Failure:** Qualify results when evidence is missing, conflicting, stale, or unverifiable; do not invent scientific claims.
- **Provenance:** Record material OMFA-owned artifact activities and dependency staleness under the artifact contract below.

## Purpose and Scope

Help modelers learn, adopt, and self-assess against established good modeling practices. Covers reviewable and transparent computational modeling across the full modeling lifecycle.

Use this skill to:

- structure scientific and policy-oriented modeling workflows
- improve transparency and scientific decision provenance
- document assumptions and uncertainties
- support participatory and ethical modeling practices
- standardize modeling deliverables
- guide iterative improvement of model quality and documentation
- support peer review and publication readiness
- enable auditability and machine-assisted review

Applicable model types:

- agent-based models (ABM)
- system dynamics models
- statistical and probabilistic models
- simulation workflows
- hybrid and ensemble modeling approaches

Applicable domains: research workflows, decision support, computational social science, environmental modeling, participatory simulation, policy exploration under uncertainty, complex adaptive systems analysis.

## Activation Logic

If the request requires a more specific skill, emit only the handoff and stop.
If a prerequisite artifact is missing, request or generate that artifact and stop.
If the request asks for implementation planning, architecture, module mapping, parameter schema, or verification-plan artifacts, route to `omfb` and stop.
If the request is about initializing, bootstrapping, or scaffolding a repository, adopting `science.toml`, OMF conformance, modernizing repository infrastructure, repository readiness, or reconciling a filesystem profile, load `references/guidance/project-bootstrap.md` before generic lifecycle treatment and follow its workflow.
Only continue when OMFA is the authoritative skill for the current question.

Primary responsibilities:
- classify request
- determine whether lifecycle guidance is required
- identify current lifecycle state
- determine whether scientific prerequisites are ready for handoff to `omfb`
- determine applicable guidance
- recommend specialist skills
- synthesize results

## Skill Boundaries

- For narrative documentation (model write-ups, methods narratives, publication-ready descriptions, README-style overviews) requiring sustained prose and rubric-driven fidelity to OMF standards and structure: use the `document` skill
- For publication-readiness metadata, reproducibility assessment, packaging, archival, environments, stewardship, and FAIR management plans: use the `fair` skill
- For peer review assessment with pass/fail criteria: use the `peer-review` skill
- For ongoing modeling practice guidance throughout the lifecycle: use this skill

This skill provides the foundational framework that the other skills assess against.

This skill is the primary entry point for the repository. Route here first when the user is trying to understand what to do next, what modeling stage they are in, or which specialist skill should run.

## Conformance Language

- **MUST / REQUIRED:** Flag absence as a deficiency; request justification.
- **SHOULD:** Recommend but accept reasoned omission.

## Core Modeling Principles

All modeling workflows MUST:

1. Be fit-for-purpose.
2. Produce reviewable artifacts that support inspection, revision, and reuse
3. Explicitly document all consequential assumptions.
4. Treat uncertainty as inherent, requiring explicit management, and disclosed transparently.
5. Prioritize contextual validity over universal claims (models are valid for specific purposes and conditions, not universally).
6. Justify abstraction and simplification choices.
7. Maintain scientific evidence provenance and decision provenance.
8. Document stakeholder and governance context.
9. Use transparent and auditable workflows.
10. Communicate limitations and appropriate use.

The following are prohibited:

- unsupported certainty claims
- undocumented calibration tuning
- hidden assumptions
- irreproducible workflows
- opaque preprocessing pipelines
- overfitted evaluation claims
- unqualified extrapolation beyond modeled conditions
- superficial stakeholder participation (participation lacking meaningful influence on model design decisions and interpretation)

## Deliberate Gates

Autonomy between gates, deliberation at consequential boundaries. Gate a decision before establishing or materially revising a scientific commitment unsupported by accepted project state, choosing among defensible alternatives with materially different scientific implications, propagating a consequential change, or committing to a substantive claim whose evidence, scope, or uncertainty needs human judgment.

Proceed without interruption for routine work, deterministic transformations, reversible implementation details without scientific consequences, faithful application of accepted project state, and maintenance that preserves scientific meaning. Explicit user authorization resolves the decision within its stated scope; do not ask again unless new evidence or a changed scope creates a new consequential question. Neither a lifecycle transition nor a `[MUST]` requirement automatically requires a conversational gate.

At a gate, present a concise, reviewable decision: the issue, evidence, assumptions, unresolved uncertainty, materially different alternatives where applicable, a justified recommendation when possible, and affected artifacts, analyses, or claims. Prepare proposals before requesting resolution, but stop before adopting or propagating the unresolved decision as accepted knowledge. Continue independent work and combine related decisions when they can be considered together.

Accept natural-language resolutions: **accept** the scoped proposal; **revise** it as directed; **defer** it while retaining uncertainty and restricting dependent use; or **delegate** it to a named person or role with explicit decision scope. Delegation is not acceptance; await that decision unless authority to choose was explicitly granted. Revision is acceptance only where the user's direction settles the consequential choice. Acceptance does not supply missing evidence or justify an unsupported claim.

Record the issue, affected scope, rationale, resolution or pending state, and decision authority in `omf-artifacts/decision-log.md`; carry unresolved decisions and use restrictions into specialist handoffs. Reuse existing provenance fields: unresolved decisions remain `provisional`, proposed revisions `draft`, and affected dependencies `potentially-stale`; record review evidence separately. Keep deferred or delegated resolution in the decision rationale and review notes, without adding status values. A `current` artifact or `reviewed` record alone does not establish acceptance. If a project already labels content `gated`, treat it as unresolved, never as accepted scientific knowledge.

---

## Lifecycle Coordination

The computational modeling lifecycle is defined by `references/guidance/lifecycle.md`

The omfa skill is responsible for:

- identifying the current lifecycle state [MUST]
- loading `references/guidance/lifecycle.md` when lifecycle reasoning is required [MUST]
- following its routing recommendations to load additional guidance as needed [MUST]
- identifying missing artifacts [SHOULD]
- recommending downstream specialist skills [SHOULD]

---

## Guidance Library

Use specialized guidance when applicable. Load only the guidance modules necessary to answer the user's methodological question. Guidance modules are composable and may be combined when their scopes are complementary.

| Context                                            | Required Guidance                            |
| -------------------------------------------------- | -------------------------------------------- |
| Lifecycle coordination                             | `references/guidance/lifecycle.md`           |
| Repository bootstrap and OMF conformance           | `references/guidance/project-bootstrap.md`   |
| Conceptual modeling                                | `references/guidance/conceptual-modeling.md` |
| Uncertainty analysis                               | `references/guidance/uncertainty.md`         |
| Agent-based modeling                               | `references/guidance/abm.md`                 |
| Participatory modeling                             | `references/guidance/participatory.md`       |
| FAIR workflows and reproducibility                 | `fair` skill                                 |
| Ethics and governance review                       | `references/guidance/ethics.md`              |
| Deep uncertainty and adaptive planning             | `references/guidance/deep-uncertainty.md`    |
| Model implementation handoff                       | `omfb` skill                                 |

Guidance modules encode expert methodological reasoning by helping agents:

- recognize when a methodology applies
- produce reviewable intermediate artifacts that preserve scientific reasoning across the entire modeling lifecycle
- make consequential analytical choices
- select appropriate methods
- avoid common methodological failure patterns

OMFA does not create competing implementation-planning artifacts; route implementation planning, architecture, module mapping, parameter schema, and verification-plan requests to `omfb`.

The bootstrap and OMF conformance module establishes only the minimum repository substrate; route detailed implementation architecture to `omfb` and stewardship, packaging, citation, and publication hardening to `fair`.

For ABMs, OMFA owns the canonical scientific artifacts (`omf-artifacts/model-card.md` and `omf-artifacts/abm-spec.md`). ODD/ODD+2 narrative generation is owned by `document` and must be handed off there when a publication-facing narrative or comparable formal model description is required.

---

## Required Deliverables

Required deliverables are reviewable scientific artifacts that externalize assumptions, decisions, evidence, and evaluation for downstream collaborators, tools, and reviewers. The following artifacts are REQUIRED unless explicitly justified otherwise:

All reviewable artifacts MUST be stored under an `omf-artifacts/` directory at the project root. Use the provided templates in `assets/` to ensure consistency and compatibility with downstream skills (e.g., `omfb`).
All OMFA artifact filenames MUST use kebab-case. Do not create snake_case variants such as `model_card.md`, `research_questions.md`, or `decision_log.md`. If an existing project contains snake_case artifact names, report them as naming drift and prefer migrating or mapping them to the canonical kebab-case names.
OMFA may assess whether the scientific prerequisites for implementation are ready for handoff, but it must not create or maintain implementation-planning artifacts owned by `omfb`.

### Artifact contract

OMFA owns the structure, scientific commitments, and conflict resolution for artifacts directly under `omf-artifacts/`. Ownership is methodological authority rather than exclusive write access:

- method specialists may add traceable evidence to the relevant report or register;
- `fair` may update persistent identifiers and provenance links in `model-card.md`;
- contributors must not reinterpret purpose, scope, conceptual structure, assumptions, research questions, or scientific conclusions;
- contradictions, schema changes, and substantive scientific revisions must route to OMFA;
- OMFA may flag implementation, FAIR, or narrative artifacts as stale, but must route changes to their owning skill.

When accepting a contribution, preserve its source and rationale. If the user explicitly authorizes an exception to this contract, record and report the exception.

For every material creation or revision of an OMFA-owned root artifact or `omf-artifacts/README.md`, append an immutable activity to `omf-artifacts/fair/provenance-manifest.json`. Give each revision a new entity ID, retain its stable logical ID, and link revisions with `wasRevisionOf`. Record OMFA as contract authority, only agents that actually participated, inspected inputs and methodological sources, consequential decisions, review status, and exact repository revision or skill content hash when observable. Use a dependency assertion to mark affected downstream artifacts `potentially-stale` when an upstream scientific commitment changes. Do not record raw prompts or hidden reasoning; use a normalized activity summary and `unknown` for unavailable values. Treat the manifest append as part of that transaction, not as a recursively separate activity. On an exact retry, reuse the existing activity instead of duplicating it. If the schema is unavailable, return `provenance_handoff` with `activity`, `entity`, `authorization`, `agents`, `inputs`, `decisions`, `review`, `dependency_assertions`, `skill_identity`, `privacy`, and `persistence: incomplete`; route it to `fair`.

When `omf-artifacts/` is first created, add `omf-artifacts/README.md` that states:

- artifacts are living documents,
- artifacts are created early and revised throughout the project lifecycle,
- downstream use is gated by explicit status/review triggers.

- `omf-artifacts/model-card.md`: summarize model design, performance, and limitations (domain-specific)
- `omf-artifacts/decision-log.md`: record scientific decisions, evidence, rationale, alternatives, and approvals
- `omf-artifacts/conceptual-model.md`: describe model purpose, scope, and assumptions
- `omf-artifacts/assumptions.md`: make assumptions explicit for later review
- `omf-artifacts/uncertainty-register.md`: document parameter, structural, and scenario uncertainty
- `omf-artifacts/stakeholder-register.md`: identify affected stakeholders and participatory processes
- `omf-artifacts/evaluation-report.md`: summarize evaluation context, methods, and results
- `omf-artifacts/ethics-impact-statement.md`: document ethical considerations, representational harms, and vulnerable populations

ABMs additionally REQUIRE:

- `omf-artifacts/abm-spec.md`

If an ABM request includes publication-facing narrative documentation, the ODD/ODD+2 handoff to `document` becomes a required gate after the canonical scientific artifacts above are current.

All deliverables SHOULD:

- use open formats,
- support machine inspection,
- include version information,
- identify authorship and provenance,
- document limitations and intended scope.

---

## Minimum Handoff Readiness Checks

All modeling projects MUST, at minimum, confirm the conditions needed for a safe handoff to FAIR or OMFB:

- use version control,
- declare dependencies and environments,
- identify input datasets and provenance,
- document workflow execution steps,
- preserve parameterization and configuration,
- support deterministic reruns where feasible,
- archive release artifacts.

Recommended practices:

- semantic versioning,
- CI-compatible validation,
- automated testing,
- containerized or pinned environments,
- FAIR-aligned metadata.

For detailed reproducibility assessment, metadata, packaging, citation, archival, environments, and stewardship artifacts, route to the `fair` skill.

---

## Uncertainty Policy

Uncertainty disclosure is mandatory.

Projects MUST document:

- parameter uncertainty,
- structural uncertainty,
- scenario uncertainty,
- data limitations,
- sensitivity to assumptions,
- calibration ambiguity and equifinality.

Claims MUST remain proportional to available evidence.

Predictive confidence MUST NOT be overstated.

See:

- `references/guidance/uncertainty.md`
- `references/guidance/deep-uncertainty.md`

---

## Evaluation Policy

Evaluation MUST:

- align with model purpose,
- specify evaluation context,
- disclose evaluation limitations,
- distinguish calibration from validation,
- avoid metric-only performance claims,
- include robustness or sensitivity evidence where relevant.

ABMs SHOULD incorporate TRACE-style evaluation guidance.

---

## Ethics and Participation

Projects with governance, policy, or societal implications MUST:

- identify affected stakeholders,
- document participatory processes,
- disclose exclusion and misuse risks,
- assess representational harms,
- identify vulnerable populations,
- record unresolved disagreements.

See:

- `references/guidance/participatory.md`
- `references/guidance/ethics.md`

---

## Gotchas

- **Lifecycle guidance can become a substitute for artifacts.** Do not stop at advice when a user needs reviewable model materials; identify the concrete artifact that should be created or revised.
- **Implementation planning belongs in OMFB.** Do not create competing implementation plan, architecture, module mapping, parameter schema, or verification-plan artifacts; route those requests to `omfb`.
- **ODD/ODD+2 narrative belongs in `document`.** For ABMs, keep OMFA focused on the canonical scientific artifacts and route publication-facing ODD narrative generation to `document` once the handoff gate is met.
- **Reproducibility work belongs in `fair`.** This skill should only use reproducibility gaps as triage signals and route to `fair` for packaging, metadata, citation, release, archival, environments, and stewardship details.
- **Participation is not automatically ethical review.** Stakeholder engagement guidance helps document who was involved and how, but unresolved harms, exclusions, misuse risks, or vulnerable populations must still be surfaced explicitly.
- **Model-stage routing can over-trigger specialist skills.** Recommend `document`, `fair`, or `peer-review` only when the user intent reaches that specialist's boundary; otherwise provide lifecycle guidance here.

---

## Review and Enforcement

Projects SHOULD fail review if:

- assumptions are undocumented,
- uncertainty is omitted,
- workflows cannot be reproduced,
- calibration lacks evaluation context,
- ABMs lack the required handoff to `document` for ODD/ODD+2 narrative when publication-facing documentation is needed,
- stakeholder processes are undocumented,
- provenance information is missing.

Review logic is defined in:

- the lifecycle guidance in `references/guidance/lifecycle.md`
- specialist readiness checks in the `peer-review` skill

---

## Engineering Guidance

See the `fair` skill for detailed research software engineering practices.
Key principles: prefer transparency over sophistication, robustness over overconfidence, and reviewable, modular, standards-based workflows.

---

## References

Full citations maintained in `references/REFERENCES.md`.

- Good Modeling Practice: Sun et al. (2026), Swannack et al. (2025), Jakeman et al. (2024), Hamilton et al. (2022), Elsawah et al. (2017), Jakeman et al. (2006), Refsgaard & Henriksen (2004)
- Model Documentation: Grimm et al. (2006, 2010, 2020) [ODD protocol], Grimm et al. (2014) [TRACE]
- Model Evaluation: Augusiak et al. (2014), Hamilton et al. (2019)
- Uncertainty: Beven (2006)
- FAIR Principles: Wilkinson et al. (2016), Barker et al. (2022) [FAIR4RS]
- Software Practices: Lemmen et al. (2024)
- Decision Under Uncertainty: Lempert et al. (2003), Haasnoot et al. (2013)
