# Uncertainty Guidance

## Purpose

Use this guidance whenever uncertainty materially affects the development, calibration, evaluation, interpretation, or communication of a computational model.

The objective is not to eliminate uncertainty, but to characterize it, communicate its implications, and prevent unwarranted certainty claims.

This guidance assumes uncertainty can be meaningfully characterized, analyzed, or bounded using scientific evidence and appropriate methods.

---

## Core Principle

Uncertainty is an inherent property of scientific modeling.

Treat uncertainty as information to be characterized and documented rather than a deficiency to be hidden.

Avoid overstating confidence, and ensure claims remain proportional to available evidence.

---

## Decision Context

**Use this guidance when:**

* uncertainty can be credibly characterized using evidence and established methods
* uncertainty materially affects explanation, prediction, inference, or decision support
* appropriate analytical methods can be selected to characterize or propagate uncertainty

**Do not use this guidance when:**

* important uncertainties cannot be adequately characterized
* defensible probability distributions cannot be assigned
* the primary objective is supporting robust decisions across many plausible futures

Use `deep-uncertainty.md` in those situations.

---

## Characterize Uncertainty

Explicitly distinguish among:

* parameter uncertainty
* structural uncertainty
* conceptual uncertainty
* model-form uncertainty
* input data uncertainty
* observational uncertainty
* implementation uncertainty
* scenario uncertainty

Different uncertainty sources require different analytical methods.

---

## Consequential Analytical Choices <!-- [MUST] -->

Document and justify:

* uncertainty sources considered
* uncertainty sources omitted
* sensitivity analysis strategy
* calibration approach
* parameter ranges
* prior assumptions
* stochastic treatment
* replication strategy

Document the rationale for each consequential choice and generate reviewable intermediate artifacts where appropriate.

---

## Transparency <!-- [MUST] -->

Clearly distinguish:

* observed evidence
* inferred conclusions
* expert judgment
* unresolved uncertainty

Explicitly document:

* assumptions
* omitted uncertainty sources
* known limitations
* confidence bounds
* uncertainty that remains uncharacterized

Avoid presenting uncertainty estimates as evidence of predictive certainty.

---

## Intermediate Artifacts

Generate or maintain, as appropriate:

* `uncertainty-register.md`
* `assumptions.md`
* `sensitivity-plan.md`
* `calibration-notes.md`
* `method-selection.md`

Use predictable, semantic filenames under `artifacts/` at the project root. These artifacts should support downstream review, documentation, and reproducibility. If `artifacts/` is created during this work, also create `artifacts/README.md` describing artifacts as living documents created early, revised throughout the project, and gated by explicit status/review triggers.

---

## Common Failure Patterns

Watch for:

* deterministic conclusions from uncertain inputs
* calibration presented as validation
* undocumented parameter ranges
* ignored structural or conceptual uncertainty
* confidence claims unsupported by evidence
* sensitivity analysis performed after interpretation instead of informing it
* treating parameter uncertainty as the only important uncertainty

---

## Routing

Describe how this guidance relates to the rest of the guidance library and specialist skills.

* **Primary entry point** — This guidance and `deep-uncertainty.md` are mutually exclusive entry points. Use this guidance when uncertainty can be credibly characterized using evidence and established methods; use `deep-uncertainty.md` when important uncertainties cannot be adequately characterized or assigned defensible probabilities.
* **Specialist execution skills** — `sensitivity-analysis`, `statistical-analysis`, and future uncertainty propagation or calibration skills.
* **Downstream consumer skills** — `document`, `peer-review`, and `fair4rs`, which should communicate assumptions, uncertainty characterization, and analytical limitations.

---

## Primary References

### Foundational Concepts

* Walker et al. (2003)
* Beven (2006)

### Operational Guidance

* Saltelli et al. (2008)
* Pianosi et al. (2016)

### Applied Practice

* Saltelli et al. (2019)

See `references/REFERENCES.md` for complete citations.
