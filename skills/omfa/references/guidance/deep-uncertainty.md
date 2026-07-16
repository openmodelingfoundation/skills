# Deep Uncertainty Guidance

## Purpose

Use this guidance when computational models support decisions under conditions where important uncertainties cannot be adequately characterized, agreed upon, or assigned defensible probabilities.

The objective is not to predict a single future, but to evaluate the robustness and adaptability of decisions across many plausible futures.

---

## Core Principle

Deep uncertainty changes how computational models should support decisions. Rather than optimizing for a single predicted future, use models to explore plausible futures, identify vulnerabilities, compare robust alternatives, and inform adaptive decision-making.

---

## Decision Context

**Use this guidance when:**

* uncertainties cannot be credibly characterized using defensible probability distributions
* stakeholders disagree on appropriate models, objectives, or system dynamics
* decisions must remain robust across many plausible futures rather than optimized for one
* surprise, adaptation, and changing conditions are expected

**Do not use this guidance when:**

* uncertainty can be credibly characterized using evidence and established methods
* the primary objective is estimating uncertainty rather than supporting robust decisions

Use `uncertainty.md` in those situations.

---

## Consequential Analytical Choices <!-- [MUST] -->

Document and justify:

* why deep uncertainty applies
* which uncertainties are treated as deep rather than characterizable
* which futures or scenarios are included in the exploratory ensemble
* which robustness or adaptability criteria are used to compare candidate decisions
* how competing stakeholder objectives are represented rather than resolved
* which uncertainties are intentionally left unresolved

Document the rationale for each consequential choice and generate reviewable intermediate artifacts where appropriate.

---

## Method Selection <!-- optional -->

Depending on the decision context, consider:

* exploratory modeling
* Robust Decision Making (RDM)
* Dynamic Adaptive Policy Pathways (DAPP)
* adaptive management
* scenario discovery
* exploratory ensembles

Describe the candidate approaches, the conditions under which each is appropriate, and the tradeoffs between them. Recommend a default where one exists, justify that recommendation, and identify when another approach would be preferable.

---

## Transparency <!-- [MUST] -->

Clearly distinguish:

* uncertainty that can be characterized
* uncertainty that cannot
* competing stakeholder values
* competing conceptual models
* observed evidence
* expert judgment
* unresolved uncertainty

Do not collapse disagreement into a single "best" model without justification.

Identify which uncertainties are reducible, which are irreducible, and which remain unresolved because of competing assumptions or stakeholder perspectives.

---

## Intermediate Artifacts

Generate or maintain, as appropriate:

* `decision-objectives.md`
* `scenario-register.md`
* `robustness-criteria.md`
* `adaptation-pathways.md`
* `stakeholder-assumptions.md`

Use predictable, semantic filenames under `artifacts/` at the project root. These artifacts should support downstream review, documentation, and reproducibility. If `artifacts/` is created during this work, also create `artifacts/README.md` describing artifacts as living documents created early, revised throughout the project, and gated by explicit status/review triggers.

---

## Common Failure Patterns

Watch for:

* optimizing under unjustified probabilities
* presenting one future as "most likely"
* treating exploratory scenarios as predictions
* collapsing stakeholder disagreement into a single objective
* selecting decision-support approaches without explaining why
* excessive confidence in long-term forecasts
* failing to distinguish reducible uncertainty from deep uncertainty

---

## Routing

Describe how this guidance relates to the rest of the guidance library and specialist skills.

* **Primary entry point** — This guidance and `uncertainty.md` are mutually exclusive entry points. Use this guidance when probabilistic characterization is not credible; use `uncertainty.md` when uncertainty can be meaningfully characterized using evidence and established methods.
* **Specialist execution skills** — `sensitivity-analysis` (when uncertainty becomes characterizable), `participatory` (for stakeholder engagement and collaborative decision processes).
* **Downstream consumer skills** — `document`, `peer-review`, and `fair4rs`, which should explicitly communicate assumptions, robustness rationale, and limitations derived from this guidance.

---

## Primary References

### Foundational Concepts

* Bankes (1993)
* Walker et al. (2013)

### Operational Guidance

* Lempert et al. (2003)
* Haasnoot et al. (2013)
* Kwakkel & Haasnoot (2019)

### Applied Practice

* Marchau et al. (2019)

See `references/REFERENCES.md` for complete citations.
