# Computational Modeling Lifecycle Guidance

## Purpose

Use this guidance to reason about the current stage of a computational modeling project, determine whether prerequisite artifacts and decisions are sufficiently developed, and identify the next methodological activities required before advancing.

This guidance coordinates the computational modeling lifecycle and routes to more specialized guidance documents. It emphasizes lifecycle readiness rather than implementation progress.

**Relationship to the parent skill:** the parent `SKILL.md` Activation Logic performs initial request classification (new project vs. existing model, specific concern vs. deliverable request). This guidance is loaded once a project is underway, to reason in more depth about lifecycle stage, readiness to advance, and regression triggers. Use the parent skill's Activation Logic to decide *whether* to load this file; use this file to decide what to do *once loaded*.

---

## Core Principle

Computational modeling progresses through the iterative refinement of explicit, reviewable artifacts. Changes to consequential analytical decisions propagate through dependent artifacts and require targeted review before subsequent conclusions can be trusted.

All reviewable artifacts SHOULD be placed under `artifacts/` at the project root. When `artifacts/` is first created, add `artifacts/README.md` indicating artifacts are living documents created early, revised throughout the project, and gated by explicit status/review triggers.

---

## Decision Context

**Use this guidance when:**

* initiating a new modeling project
* determining the current lifecycle stage
* identifying missing analyses or deliverables
* deciding what work should be performed next
* coordinating multiple modeling activities
* reviewing overall modeling practice

**Do not use this guidance when:**

* developing a conceptual representation of a system (`conceptual-modeling.md`)
* selecting modeling paradigms or abstractions (`conceptual-modeling.md`)
* evaluating uncertainty (`uncertainty.md` or `deep-uncertainty.md`)
* performing methodology-specific analyses such as sensitivity analysis, calibration, or reproducibility assessment

This guidance serves as the primary entry point for coordinating the modeling lifecycle. It complements rather than replaces specialized methodological guidance.

---

## Consequential Analytical Choices <!-- [MUST] -->

### Problem Formulation

Clearly define the scientific or decision-support objectives before selecting modeling methods. [MUST]

Document the intended use, scope, system boundaries, and primary research questions. [MUST]

Identify stakeholders and decision context when relevant to model design or interpretation. [SHOULD]

### Conceptual Modeling

Develop a reviewable conceptual model before implementation begins. [MUST]

Justify abstraction, simplification, and boundary decisions relative to model purpose. [MUST]

Maintain traceability between scientific questions, assumptions, and conceptual components. [MUST]

### Data and Evidence Assessment

Establish the provenance, quality, and sufficiency of the data and evidence the model will draw on before formalization proceeds. [MUST]

For each model component, parameter, behavioral rule, initial condition, or evaluation dataset, document whether supporting evidence is empirical, inferred, literature-derived, expert-elicited, or hypothetical. [MUST]

Identify data quality boundaries: known gaps, sparsity, sampling limitations, temporal or spatial mismatch with the model's intended scope, and any preprocessing applied before use. [MUST]

If defaults or expert judgement are used to compensate for missing evidence, document the rationale and resulting uncertainties. [MUST]

### Model Realization

Select implementation approaches that faithfully represent the conceptual model rather than allowing software constraints to drive scientific design. [MUST]

Document implementation assumptions, parameter sources, and computational approximations. [MUST]

### Evaluation

Treat verification, calibration, validation, uncertainty analysis, and sensitivity analysis as distinct analytical activities with different objectives. [MUST]

Justify which evaluation activities are applicable given the model purpose and available evidence. [MUST]

### Communication and Stewardship

Communicate limitations, appropriate use, assumptions, and remaining uncertainties alongside model results. [MUST]

Document provenance, reproducibility, and long-term stewardship where appropriate. [SHOULD]

---

## Lifecycle Phases

The computational modeling lifecycle is inherently iterative, not a waterfall. Treat the phases below as a map of where a project's reasoning currently stands, not a sequence to execute in strict order. A project may legitimately be active in more than one phase at once, and progress in a later phase routinely surfaces reasons to revisit an earlier one.

| Phase | Focus | Primary artifacts |
| --- | --- | --- |
| Problem formulation | Objectives, scope, research questions | `problem_statement.md`, `research_questions.md` |
| Conceptual modeling | Abstractions, boundaries, stakeholder framing | `conceptual_model.md`, `stakeholder_register.md`, `assumptions.md` |
| Data and evidence assessment | Provenance, quality, sufficiency | `assumptions.md` (data-sourcing entries) |
| Model implementation | Faithful realization of the conceptual model | `implementation_plan.md` |
| Verification | Does the implementation match the conceptual model/spec? | `verification_report.md` |
| Calibration | Parameter fitting against the model's intended purpose | `calibration_report.md` |
| Validation and evaluation | Does the model perform adequately for its stated purpose? | `validation_report.md` |
| Sensitivity and uncertainty analysis | Parameter, structural, and scenario uncertainty | `uncertainty_register.md`, `sensitivity_analysis.md` |
| Experimental analysis | Designed runs answering the research questions | `experiment_plan.md`, `results.md` |
| Communication and stewardship | Limitations, appropriate use, provenance | `limitations.md` |

**Regression is expected, not exceptional.** A substantive change discovered in a later phase SHOULD prompt the agent to flag the earlier phases it depends on for re-check — this is a flag for review, not an automatic edit. For example: a calibration result (Phase 6) that requires implausible parameter values SHOULD prompt the agent to flag the conceptual model (Phase 2) and data assessment (Phase 3) for re-examination, rather than proceeding to validation as though the conceptual model still holds. The agent should surface this regression explicitly to the user rather than silently revising upstream artifacts on their behalf.

---

## Lifecycle readiness

A phase SHOULD be considered ready to hand off when:

- required artifacts exist
- consequential analytical choices are documented
- unresolved issues have been identified
- assumptions requiring downstream evaluation are explicit

---

## Transparency

Explicitly distinguish:

* observed evidence supporting model design
* inferred conclusions
* expert judgment
* user-supplied assumptions
* unresolved uncertainty

Document the current lifecycle stage, completed artifacts, outstanding methodological questions, and rationale for advancing or revisiting previous stages. [MUST]

Maintain traceability between scientific objectives, conceptual assumptions, implementation decisions, evaluation results, and reported conclusions. [MUST]

---

## Intermediate Artifacts

Expected intermediate artifacts include:

* `problem_statement.md`
* `research_questions.md`
* `stakeholder_register.md`
* `conceptual_model.md`
* `assumptions.md`
* `implementation_plan.md`
* `verification_report.md`
* `calibration_report.md`
* `validation_report.md`
* `uncertainty_register.md`
* `sensitivity_analysis.md`
* `experiment_plan.md`
* `results.md`
* `limitations.md`

These artifacts should evolve throughout the project and remain available for downstream specialist skills. `conceptual_model.md`, `assumptions.md`, and `uncertainty_register.md` are shared with the parent `SKILL.md` Required Deliverables list — this guidance does not introduce separate copies; it tracks the same files across lifecycle phases.

Store these artifacts in `artifacts/` at the project root, and keep `artifacts/README.md` current with artifact status and review-trigger conventions.

**Dependency edges.** These artifacts are not independent; a change to one frequently invalidates claims in another. Dependency edges are intentionally sparse. Only record dependencies that are consequential and likely to invalidate downstream reasoning. At minimum, track:

* A change to `assumptions.md` MUST trigger a review of `validation_report.md` and `uncertainty_register.md` for continued consistency.
* A change to `conceptual_model.md` MUST trigger a review of `implementation_plan.md`, `verification_report.md`, and any completed `calibration_report.md` or `validation_report.md`.
* A change to data sourcing recorded under Data and Evidence Assessment MUST trigger a review of `calibration_report.md`, `uncertainty_register.md`, and `sensitivity_analysis.md`.
* A change to `calibration_report.md` MUST trigger a review of `validation_report.md`.

When flagging a downstream review, name the specific artifact and the reason it may now be stale — do not flag broadly across all artifacts by default, as that erodes the signal value of the flag.

---

## Common Failure Patterns

* Beginning implementation before developing a conceptual model.
* Treating code completion as evidence of scientific validity.
* Allowing software constraints to determine scientific scope.
* Confusing calibration with validation.
* Omitting verification because model behavior appears plausible.
* Treating uncertainty analysis as optional.
* Failing to revisit conceptual assumptions after evaluation.
* Losing traceability between research questions, assumptions, implementation, and conclusions.
* Discarding intermediate reasoning artifacts that justify analytical decisions.
* Treating the lifecycle phases as a strict waterfall and resisting return to an earlier phase when evidence warrants it.
* Silently revising an upstream artifact after a downstream finding instead of flagging the inconsistency for user review.

---

## Routing

**Primary entry point**

Use this guidance to coordinate the overall computational modeling lifecycle and determine which specialized guidance should be applied next. Routing decisions below are conditional gates, not a fixed reading order. Evaluate the condition against the project's current state.

* Route to `conceptual-modeling.md` IF the project has a problem statement but lacks a reviewable conceptual model, or IF abstraction, system boundaries, or modeling paradigm decisions need to be made or revisited.
* Route to `uncertainty.md` IF uncertainty can be meaningfully characterized using probability distributions or standard sensitivity methods.
* Route to `deep-uncertainty.md` IF key uncertainties cannot be meaningfully represented probabilistically due to structural uncertainty, contested assumptions, or multiple plausible futures. Note that `uncertainty.md` and `deep-uncertainty.md` are mutually exclusive entry points for a **particular uncertainty** under consideration, but multiple uncertainties of different types and characterizations can coexist within a project.
* Route to `abm.md` IF the model represents autonomous, interacting agents and agent-based design decisions (entity definition, interaction rules, emergence) are under discussion.
* Route to `participatory.md` IF stakeholders are intended to influence model design, framing, calibration, or interpretation.
* Route to `reproducibility.md` IF reproducibility practices are being established or assessed.
* Route to `ethics.md` IF the model has governance, policy, or societal implications, or affects vulnerable populations.

**Specialist execution skills**

Specialist skills may implement:

* implementation planning
* calibration
* sensitivity analysis
* uncertainty analysis
* visualization
* model evaluation
* peer review

**Downstream consumer skills**

Nearly all modeling skills consume artifacts produced throughout the lifecycle, including implementation assistants, evaluation tools, publication support, reproducibility assessments, and peer review workflows.

---

## Primary References

### Computational Modeling Lifecycle

* Jakeman et al. (2006)
* Jakeman et al. (2024)
* Refsgaard & Henriksen (2004)

### Model Development and Evaluation

* Grimm et al. (2006, 2010, 2020)
* Grimm et al. (2014)
* Augusiak et al. (2014)
* Hamilton et al. (2019)
* Oberkampf & Roy (2010)

### Computational Science Practice

* Wilson (2006)
* Lemmen et al. (2024)

See `references/REFERENCES.md` for complete citations.