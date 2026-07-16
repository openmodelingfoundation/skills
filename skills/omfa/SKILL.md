---
name: omfa
description: |
  Guide modelers in applying good modeling practice across the full computational modeling lifecycle,
  from problem framing through evaluation, uncertainty disclosure, governance, and maintenance.

  Use this skill when users want lifecycle guidance, quality self-assessment, required modeling deliverables, or protocol-specific checks for ABM, uncertainty, reproducibility, ethics, participatory modeling, and deep uncertainty.

  Expected output: staged modeling guidance, identified deficiencies against required practices, and a concrete set of required artifacts and review checks.
license: MIT
compatibility: Works with agent-based, system dynamics, statistical, simulation, and hybrid models
metadata:
  domain: computational-modeling
  maturity: beta
  audience: researchers who code, research software engineers
  category: methodology
---

# Good Modeling Practice

A modular guidance and skill framework for transparent, reviewable, computational modeling.

## Purpose and Scope

Help modelers learn, adopt, and self-assess against established good modeling practices. Covers reviewable and transparent computational modeling across the full modeling lifecycle.

Use this skill to:

- structure scientific and policy-oriented modeling workflows
- improve transparency and reproducibility
- document assumptions and uncertainties
- support participatory and ethical modeling practices
- standardize modeling deliverables
- guide iterative improvement of model quality and documentation
- support peer review and publication readiness
- enable auditability and machine-assisted review

Applicable model types:

- agent-based models (ABM),
- system dynamics models,
- statistical and probabilistic models,
- simulation workflows,
- hybrid and ensemble modeling approaches.

Applicable domains: research workflows, decision support, computational social science, environmental modeling, participatory simulation, policy exploration under uncertainty, complex adaptive systems analysis.

## Activation Logic

Primary responsibilities:
- classify request
- determine whether lifecycle guidance is required
- identify current lifecycle state
- determine applicable guidance
- recommend specialist skills
- synthesize results

## Skill Boundaries

- For publication-readiness metadata and archival: use the `fair4rs` skill
- For formal peer review assessment with pass/fail criteria: use the `peer-review` skill
- For ongoing modeling practice guidance throughout the lifecycle: use this skill

This skill provides the foundational framework that the other skills assess against.

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
7. Maintain provenance and reproducibility.
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

---

## Lifecycle Coordination

The computational modeling lifecycle is defined by `references/guidance/lifecycle.md`

The omfa skill is responsible for:

- identifying the current lifecycle state
- loading `references/guidance/lifecycle.md` when lifecycle reasoning is required
- following its routing recommendations to load additional guidance as needed
- identifying missing artifacts
- recommending downstream specialist skills

---

## Guidance Library

Use specialized guidance when applicable. Load only the guidance modules necessary to answer the user's methodological question. Guidance modules are composable and may be combined when their scopes are complementary.

| Context                                | Required Guidance               |
| -------------------------------------- | ------------------------------- |
| Lifecycle coordination | `references/guidance/lifecycle.md` |
| Conceptual modeling | `references/guidance/conceptual-modeling.md` |
| Uncertainty analysis                   | `references/guidance/uncertainty.md`      |
| Agent-based modeling                   | `references/guidance/abm.md`              |
| Participatory modeling                 | `references/guidance/participatory.md`    |
| Reproducibility and FAIR workflows     | `references/guidance/reproducibility.md`  |
| Ethics and governance review           | `references/guidance/ethics.md`           |
| Deep uncertainty and adaptive planning | `references/guidance/deep-uncertainty.md` |

Guidance modules encode expert methodological reasoning by helping agents:

- recognize when a methodology applies
- produce reviewable intermediate artifacts that preserve scientific reasoning across the entire modeling lifecycle
- make consequential analytical choices
- select appropriate methods
- avoid common methodological failure patterns

---

## Required Deliverables

Required deliverables are reviewable scientific artifacts that externalize assumptions, decisions, evidence, and evaluation for downstream collaborators, tools, and reviewers. The following artifacts are REQUIRED unless explicitly justified otherwise:

All reviewable artifacts MUST be stored under an `artifacts/` directory at the project root.

When `artifacts/` is first created, add `artifacts/README.md` that states:

- artifacts are living documents,
- artifacts are created early and revised throughout the project lifecycle,
- downstream use is gated by explicit status/review triggers.

- `artifacts/model_card.md`: summarize model design, performance, and limitations (domain-specific)
- `artifacts/conceptual_model.md`: describe model purpose, scope, and assumptions
- `artifacts/assumptions.md`: make assumptions explicit for later review
- `artifacts/uncertainty_register.md`: document parameter, structural, and scenario uncertainty
- `artifacts/stakeholder_register.md`: identify affected stakeholders and participatory processes
- `artifacts/evaluation_report.md`: summarize evaluation context, methods, and results
- `artifacts/provenance_manifest.json`: record data, code, and workflow provenance
- `artifacts/ethics_impact_statement.md`: document ethical considerations, representational harms, and vulnerable populations
- `artifacts/maintenance_plan.md`: (optional) describe stewardship, versioning, and plans for long-term maintenance

ABMs additionally REQUIRE:

- `artifacts/abm_spec.md`

All deliverables SHOULD:

- use open formats,
- support machine inspection,
- include version information,
- identify authorship and provenance,
- document limitations and intended scope.

---

## Minimum Reproducibility Requirements

All modeling projects MUST:

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

See `references/guidance/reproducibility.md`.

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

## Review and Enforcement

Projects SHOULD fail review if:

- assumptions are undocumented,
- uncertainty is omitted,
- workflows cannot be reproduced,
- calibration lacks evaluation context,
- ABMs lack ODD documentation,
- stakeholder processes are undocumented,
- provenance information is missing.

Review logic is defined in:

- `checks.md`
- `tools/review_checklist.md`
- `tools/scoring_rubric.md`
- `tools/red_flags.md`

---

## Engineering Guidance

See the `fair4rs` skill for detailed research software engineering practices.
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
