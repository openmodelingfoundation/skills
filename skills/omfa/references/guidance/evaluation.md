# Evaluation Guidance

## Purpose

Use this guidance when planning, conducting, or interpreting the evaluation of a computational model.

The objective is to determine whether a model is credible and fit for its intended purpose, not to establish that it is universally valid or "correct."

---

## Core Principle

Evaluation establishes the credibility of a model relative to its stated purpose.

No single evaluation method is sufficient. Credibility is built from complementary evidence, transparent assumptions, documented limitations, and appropriate evaluation strategies.

---

## Decision Context

**Use this guidance when:**

* selecting an evaluation strategy
* determining whether evaluation evidence is sufficient
* distinguishing calibration, verification, and validation
* communicating model credibility

**Do not use this guidance when:**

* selecting uncertainty analysis methods (`uncertainty.md`)
* supporting decisions under deep uncertainty (`deep-uncertainty.md`)
* determining whether agent-based modeling is an appropriate paradigm (`abm.md`)

---

## Consequential Analytical Choices <!-- [MUST] -->

### Evaluation Objectives

Document and justify:

* what the evaluation is intended to demonstrate
* why those criteria are appropriate for the model's purpose
* which claims the evaluation supports

### Evidence

Document:

* empirical evidence used
* theoretical expectations
* qualitative evidence
* expert judgment

Do not treat all evidence as equally strong.

### Evaluation Strategy

Document and justify:

* conceptual validation
* implementation verification
* behavioral validation
* calibration assessment
* sensitivity or robustness evidence

Explain why each form of evaluation is appropriate.

### Scope

Clearly distinguish:

* evaluated behavior
* unevaluated behavior
* supported conclusions
* unsupported extrapolations

Document the rationale for each consequential choice and generate reviewable intermediate artifacts where appropriate.

---

## Method Selection <!-- optional -->

When multiple evaluation frameworks are applicable, select one appropriate to the modeling context.

Examples include:

* TRACE
* pattern-oriented modeling
* empirical validation
* qualitative evaluation
* expert review

Describe why the selected framework is appropriate and what aspects of credibility it addresses.

---

## Transparency <!-- [MUST] -->

Clearly distinguish:

* verification
* validation
* calibration
* expert judgment
* empirical evidence
* unresolved limitations

Avoid presenting successful calibration or agreement with observations as proof that a model is "validated."

---

## Intermediate Artifacts

Generate or maintain, as appropriate:

* `evaluation-plan.md`
* `evaluation-criteria.md`
* `validation-report.md`
* `calibration-notes.md`
* `limitations.md`

Use predictable, semantic filenames under `artifacts/` at the project root. These artifacts should support downstream review, documentation, and reproducibility. If `artifacts/` is created during this work, also create `artifacts/README.md` describing artifacts as living documents created early, revised throughout the project, and gated by explicit status/review triggers.

---

## Common Failure Patterns

Watch for:

* confusing calibration with validation
* relying on a single evaluation metric
* evaluating only outputs that support the hypothesis
* claiming predictive validity beyond the evaluation context
* treating agreement with observations as proof of correctness
* failing to document evaluation limitations
* evaluating implementation while ignoring conceptual validity

---

## Routing

Describe how this guidance relates to the rest of the guidance library and specialist skills.

* **Primary entry point** — This guidance is complementary to `abm.md`, `uncertainty.md`, and `deep-uncertainty.md`. Those guidance modules help determine what should be represented and how uncertainty should be treated; this guidance addresses how resulting claims should be evaluated.
* **Specialist execution skills** — `peer-review`, `statistical-analysis`, `sensitivity-analysis`, and future verification or calibration skills.
* **Downstream consumer skills** — `document`, `document-review`, and `fair4rs`, which should communicate evaluation strategy, supporting evidence, and model limitations.

---

## Primary References

### Foundational Concepts

* Oreskes et al. (1994)
* Hamilton et al. (2019)

### Operational Guidance

* Augusiak et al. (2014)
* Grimm et al. (2014) TRACE
* Schmolke et al. (2010)

### Applied Practice

* Jakeman et al. (2024)

See `references/REFERENCES.md` for complete citations.
