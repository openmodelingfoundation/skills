# uncertainty.md

# Uncertainty Guidance

Use this guidance whenever a computational model is developed, calibrated, evaluated, or interpreted.

The objective is not to eliminate uncertainty but to characterize, communicate, and reason about it appropriately.

This guidance assumes uncertainty can be meaningfully characterized, analyzed, or bounded using scientific evidence and appropriate methods.

If important uncertainties cannot be credibly characterized or assigned defensible probabilities, use `deep-uncertainty.md` instead.

---

## Core Principle

Uncertainty is an inherent property of scientific modeling.

Treat uncertainty as information to be documented rather than a deficiency to be hidden.

Avoid overstating confidence.

---

## Characterize Uncertainty

Explicitly distinguish among:

* parameter uncertainty
* structural uncertainty
* input data uncertainty
* observational uncertainty
* scenario uncertainty
* implementation uncertainty

Different uncertainty sources require different methods.

---

## Decision Context

Determine whether uncertainty primarily affects:

- explanation
- prediction
- inference
- decision support

Different scientific objectives require different uncertainty analyses.

---

## Consequential Analytical Choices

Document and justify:

* sensitivity analysis methods
* calibration approaches
* parameter ranges
* prior assumptions
* stochastic treatment
* replication strategy

Surface alternatives when multiple defensible choices exist.

---

## Evaluation

Do not evaluate uncertainty using a single metric.

Prefer complementary evidence such as:

* local or global sensitivity analysis
* uncertainty propagation
* robustness analysis
* calibration diagnostics
* predictive intervals where appropriate

---

## Transparency

Explicitly document:

* assumptions
* omitted uncertainty sources
* known limitations
* confidence bounds
* unresolved ambiguity

Separate observed evidence from inferred conclusions.

---

## Intermediate Artifacts

Generate when appropriate:

* `uncertainty-register.md`
* `assumptions.md`
* `sensitivity-plan.md`
* `calibration-notes.md`

---

## Common Failure Patterns

Watch for:

* deterministic conclusions from uncertain inputs
* calibration presented as validation
* undocumented parameter ranges
* ignored structural uncertainty
* confidence claims unsupported by evidence
* sensitivity analysis performed after interpretation instead of informing it

---

## Routing

If users need:

* implementation of sensitivity methods → `sensitivity-analysis`
* statistical uncertainty estimation → `statistical-analysis`
* publication documentation → `document`
* software publication → `fair4rs`

---

# Primary References

## Characterizing and Managing Uncertainty

* Walker et al. (2003)
* Beven (2006)

## Sensitivity Analysis

* Saltelli et al. (2008)
* Pianosi et al. (2016)
* Saltelli et al. (2019)

See `references/REFERENCES.md` for complete citations.
