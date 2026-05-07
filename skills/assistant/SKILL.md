# Good Modeling Practice

A modular skill framework for computational socio-environmental and complex adaptive systems modeling.

## Purpose and Scope

Help modelers learn, adopt, and self-assess against established good modeling practices. Covers transparent, reviewable, and reproducible computational modeling across the full modeling lifecycle.

Use this skill to:

* structure scientific and policy-oriented modeling workflows,
* improve transparency and reproducibility,
* document assumptions and uncertainties,
* support participatory and ethical modeling practices,
* standardize modeling deliverables,
* enable auditability and machine-assisted review.

Applicable model types:

* agent-based models (ABM),
* system dynamics models,
* statistical and probabilistic models,
* simulation workflows,
* hybrid and ensemble modeling approaches.

Applicable domains: research workflows, decision support, computational social science, environmental modeling, participatory simulation, policy exploration under uncertainty, complex adaptive systems analysis.

## Activation Logic

- If user is starting a new modeling project → begin with Problem Framing and Stakeholder Analysis
- If user has an existing model and wants quality feedback → route to Review and Enforcement
- If user asks about a specific concern (uncertainty, ethics, reproducibility) → route to the relevant protocol
- If user wants to produce deliverables → route to Required Deliverables and templates
- If user asks "is my model ready for publication" → use the peer-review skill instead

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
2. Explicitly document assumptions.
3. Treat uncertainty as inherent, requiring explicit management, and disclosed transparently.
4. Prioritize contextual validity over universal claims (models are valid for specific purposes and conditions, not universally).
5. Justify abstraction and simplification choices.
6. Maintain provenance and reproducibility.
7. Document stakeholder and governance context.
8. Support inspection, review, and revision.
9. Use transparent and auditable workflows.
10. Communicate limitations and appropriate use.

The following are prohibited:

* unsupported certainty claims
* undocumented calibration tuning
* hidden assumptions
* irreproducible workflows
* opaque preprocessing pipelines
* overfitted evaluation claims
* unqualified extrapolation beyond modeled conditions
* superficial stakeholder participation (participation lacking meaningful influence on model design decisions and interpretation)

---

## Required Workflow Stages

All projects SHOULD address the following stages:

1. Problem framing
2. Stakeholder analysis
3. Conceptual modeling
4. Data and evidence management
5. Model formalization
6. Implementation
7. Calibration
8. Validation and evaluation
9. Uncertainty analysis
10. Communication and interpretation
11. Governance, maintenance, and stewardship

Each stage MUST:

* define objectives,
* document assumptions,
* identify uncertainties,
* specify outputs and artifacts,
* record review criteria,
* identify known limitations.

See:

* `workflow.md`
* `checks.md`
* `deliverables.md`

---

## Protocol Routing

Use specialized protocols when applicable.

| Context                                | Required Protocol               |
| -------------------------------------- | ------------------------------- |
| Uncertainty analysis                   | `protocols/uncertainty.md`      |
| Agent-based modeling                   | `protocols/abm.md`              |
| Participatory modeling                 | `protocols/participatory.md`    |
| Reproducibility and FAIR workflows     | `protocols/reproducibility.md`  |
| Ethics and governance review           | `protocols/ethics.md`           |
| Deep uncertainty and adaptive planning | `protocols/deep_uncertainty.md` |

Protocols define:

* minimum documentation requirements,
* review procedures,
* anti-patterns,
* expected artifacts,
* pass/fail checks.

---

## Required Deliverables

The following artifacts are REQUIRED unless explicitly justified otherwise:

* `model_card.md`
* `conceptual_model.md`
* `assumptions.md`
* `uncertainty_register.md`
* `stakeholder_register.md`
* `evaluation_report.md`
* `provenance_manifest.json`
* `ethics_impact_statement.md`
* `maintenance_plan.md`

ABMs additionally REQUIRE:

* `abm_odd_spec.md`

All deliverables SHOULD:

* use open formats,
* support machine inspection,
* include version information,
* identify authorship and provenance,
* document limitations and intended scope.

See templates in `templates/`.

---

## Minimum Reproducibility Requirements

All modeling projects MUST:

* use version control,
* declare dependencies and environments,
* identify input datasets and provenance,
* document workflow execution steps,
* preserve parameterization and configuration,
* support deterministic reruns where feasible,
* archive release artifacts.

Recommended practices:

* semantic versioning,
* CI-compatible validation,
* automated testing,
* containerized or pinned environments,
* FAIR-aligned metadata.

See `protocols/reproducibility.md`.

---

## Uncertainty Policy

Uncertainty disclosure is mandatory.

Projects MUST document:

* parameter uncertainty,
* structural uncertainty,
* scenario uncertainty,
* data limitations,
* sensitivity to assumptions,
* calibration ambiguity and equifinality.

Claims MUST remain proportional to available evidence.

Predictive confidence MUST NOT be overstated.

See:

* `protocols/uncertainty.md`
* `protocols/deep_uncertainty.md`

---

## Evaluation Policy

Evaluation MUST:

* align with model purpose,
* specify evaluation context,
* disclose evaluation limitations,
* distinguish calibration from validation,
* avoid metric-only performance claims,
* include robustness or sensitivity evidence where relevant.

ABMs SHOULD incorporate TRACE-style evaluation guidance.

---

## Ethics and Participation

Projects with governance, policy, or societal implications MUST:

* identify affected stakeholders,
* document participatory processes,
* disclose exclusion and misuse risks,
* assess representational harms,
* identify vulnerable populations,
* record unresolved disagreements.

See:

* `protocols/participatory.md`
* `protocols/ethics.md`

---

## Review and Enforcement

Projects SHOULD fail review if:

* assumptions are undocumented,
* uncertainty is omitted,
* workflows cannot be reproduced,
* calibration lacks evaluation context,
* ABMs lack ODD documentation,
* stakeholder processes are undocumented,
* provenance information is missing.

Review logic is defined in:

* `checks.md`
* `tools/review_checklist.md`
* `tools/scoring_rubric.md`
* `tools/red_flags.md`

---

## Engineering Guidance

See the `fair4rs` skill for detailed research software engineering practices. 
Key principles: prefer transparency over sophistication, robustness over overconfidence, and inspectable, modular, standards-based workflows.

---

## References

Full citations maintained in `references/REFERENCES.md`.

Key foundations:
- Good Modeling Practice: Jakeman et al. (2024), Jakeman et al. (2006), Refsgaard & Henriksen (2004)
- Model Documentation: Grimm et al. (2006, 2010, 2020) [ODD protocol], Grimm et al. (2014) [TRACE]
- Model Evaluation: Augusiak et al. (2014), Hamilton et al. (2019)
- Uncertainty: Beven (2006)
- FAIR Principles: Wilkinson et al. (2016), Barker et al. (2022) [FAIR4RS]
- Software Practices: Lemmen et al. (2024)
- Decision Under Uncertainty: Lempert et al. (2003), Haasnoot et al. (2013)