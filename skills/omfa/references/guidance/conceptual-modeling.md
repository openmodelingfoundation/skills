# Conceptual Modeling Guidance

## Purpose

Use this guidance when translating a research problem into a computational model.

The objective is to construct a scientifically defensible conceptual representation of the system before selecting a modeling paradigm or implementation strategy.

---

## Core Principle

A conceptual model is an explicit representation of the essential components, processes, interactions, assumptions, and boundaries needed to answer a specific research question.

Represent only the complexity necessary to address the intended purpose.

---

## Decision Context

**Use this guidance when:**

* framing a new modeling project
* refining or revising a conceptual model
* determining what should and should not be represented
* selecting an appropriate modeling paradigm

**Do not use this guidance when:**

* designing implementation details
* selecting analytical methods
* evaluating model credibility

Use guidance such as `abm.md`, `uncertainty.md`, or `evaluation.md` after the conceptual model has been established.

---

## Consequential Analytical Choices <!-- [MUST] -->

### Research Question

Document:

* the scientific or policy question
* intended use of the model
* intended users
* decisions the model is expected to inform

### System Boundary

Document and justify:

* what is inside the model
* what is outside the model
* temporal boundaries
* spatial boundaries
* organizational or institutional boundaries

### Processes

Document:

* key system processes
* causal relationships
* feedback mechanisms
* interactions

Include only processes necessary to answer the research question.

### Entities

Identify and justify:

* actors
* organizations
* physical components
* environmental components

Do not introduce entities without explanatory purpose.

### Abstraction

Document and justify:

* simplifications
* aggregation
* omitted processes
* assumptions

Prefer the simplest defensible representation.

### Evidence

Clearly distinguish:

* empirical evidence
* theoretical foundations
* expert judgment
* working assumptions

Document the rationale for each consequential choice and generate reviewable intermediate artifacts where appropriate.

---

## Transparency <!-- [MUST] -->

Clearly distinguish:

* observed system behavior
* hypothesized mechanisms
* modeling assumptions
* implementation constraints

Explicitly document known limitations and unresolved questions.

Avoid embedding implementation details in the conceptual model.

---

## Intermediate Artifacts

Generate or maintain, as appropriate:

* `problem-statement.md`
* `research-questions.md`
* `conceptual-model.md`
* `system-boundary.md`
* `assumptions.md`
* `abstraction-decisions.md`

Use predictable, semantic filenames under `artifacts/` at the project root. These artifacts should support downstream model design, documentation, review, and reproducibility. If `artifacts/` is created during this work, also create `artifacts/README.md` describing artifacts as living documents created early, revised throughout the project, and gated by explicit status/review triggers.

---

## Common Failure Patterns

Watch for:

* beginning implementation before developing a conceptual model
* representing software architecture instead of the real system
* introducing unnecessary complexity
* unclear system boundaries
* undocumented abstraction decisions
* mixing empirical evidence with assumptions
* selecting a modeling paradigm before defining the conceptual model
* allowing available data to dictate the conceptual model

---

## Routing

Describe how this guidance relates to the rest of the guidance library and specialist skills.

* **Primary entry point** — This is the primary entry point for new computational modeling projects. Apply this guidance before selecting a modeling paradigm or analytical methods.
* **Specialist execution skills** — None directly. This guidance informs subsequent methodological choices rather than implementing analyses.
* **Downstream consumer skills** — `abm.md` and future paradigm-specific guidance, `document`, `peer-review`, `fair4rs`, and future modeling execution skills.

---

## Primary References

### Foundational Concepts

- Jakeman et al. (2006)
- Refsgaard & Henriksen (2004)
- Jakeman et al. (2024)

### Operational Guidance

- Robinson (2008)
- Hamilton et al. (2019)

### Applied Practice

- Grimm et al. (2020) ODD+2
- Grimm et al. (2014) TRACE

See `references/REFERENCES.md` for complete citations.