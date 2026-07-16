# Implementation Planning Guidance

## Purpose

Use this guidance after a conceptual model has been established to plan its implementation as research software.

The objective is to translate the conceptual model into a maintainable, traceable, and reproducible implementation while preserving the scientific intent of the model.

---

## Core Principle

Implementation should faithfully realize the conceptual model without introducing unnecessary complexity or altering the underlying scientific assumptions.

The implementation plan should maximize traceability between the conceptual model, source code, experiments, and resulting scientific claims.

---

## Decision Context

**Use this guidance when:**

- planning implementation before writing substantial code
- selecting software architecture and implementation strategy
- organizing model components, data, and configuration
- defining verification activities
- coordinating implementation across collaborators

**Do not use this guidance when:**

- defining the conceptual representation of the system (use `conceptual-modeling.md`)
- selecting uncertainty or evaluation methods (use `uncertainty.md` or `evaluation.md`)
- documenting or publishing completed software (use `fair4rs`)
- implementing or reviewing code directly

---

## Consequential Analytical Choices <!-- [MUST] -->

### Representation

Document and justify:

- how conceptual entities map to software abstractions
- how processes map to executable logic
- how state is represented and updated
- how interactions are implemented

Maintain traceability between conceptual model elements and implementation components.

### Architecture

Document and justify:

- module boundaries
- component responsibilities
- interfaces
- separation between model logic, infrastructure, and analysis code

Prefer modular designs that preserve the conceptual structure of the model.

### Framework and Library Selection

Document and justify:

- implementation framework
- programming language(s)
- numerical libraries
- simulation infrastructure

Select technologies based on scientific requirements rather than familiarity or convenience.

### Data and Configuration

Document:

- parameter management
- configuration files
- input datasets
- output organization
- reproducibility requirements

Separate configuration from implementation wherever practical.

### Verification Planning

Document:

- implementation assumptions
- verification strategy
- expected invariants
- unit and integration testing approach

Distinguish verification of implementation from evaluation of scientific validity.

Document the rationale for each consequential choice and generate reviewable intermediate artifacts where appropriate.

---

## Method Selection <!-- optional -->

When multiple implementation strategies are appropriate, compare them using criteria such as:

- traceability to the conceptual model
- simplicity
- extensibility
- computational performance
- reproducibility
- maintainability

Recommend the simplest implementation that faithfully represents the conceptual model.

---

## Transparency <!-- [MUST] -->

Clearly distinguish:

- conceptual model decisions
- implementation decisions
- software constraints
- performance optimizations
- known implementation limitations

Document implementation assumptions separately from scientific assumptions.

Avoid introducing implementation-driven behavior without documenting its scientific implications.

---

## Intermediate Artifacts

Generate or maintain, as appropriate:

- `implementation-plan.md`
- `architecture-overview.md`
- `module-mapping.md`
- `parameter-schema.md`
- `data-flow.md`
- `verification-plan.md`

Use predictable, semantic filenames under `artifacts/` at the project root. These artifacts should support downstream implementation, documentation, review, and reproducibility. If `artifacts/` is created during this work, also create `artifacts/README.md` describing artifacts as living documents created early, revised throughout the project, and gated by explicit status/review triggers.

---

## Common Failure Patterns

Watch for:

- allowing implementation constraints to redefine the conceptual model
- tightly coupling model logic with infrastructure
- embedding parameters directly in source code
- undocumented deviations from the conceptual model
- optimizing performance before establishing correctness
- mixing implementation verification with scientific evaluation
- selecting frameworks based solely on familiarity
- losing traceability between conceptual model and implementation

---

## Routing

Describe how this guidance relates to the rest of the guidance library and specialist skills.

- **Primary entry point** — Apply this guidance after `conceptual-modeling.md` and before substantial software implementation. It complements paradigm-specific guidance (e.g. `abm.md`) by planning how the selected conceptual representation will be realized.
- **Specialist execution skills** — `fair4rs` for research software engineering and publication, future implementation or coding skills, and future verification-oriented skills.
- **Downstream consumer skills** — `document`, `peer-review`, `fair4rs`, and `analysis-planning`, which consume implementation decisions, software architecture, and verification plans.

---

## Primary References

### Foundational Concepts

- Jakeman et al. (2024)
- Jakeman et al. (2006)
- Refsgaard & Henriksen (2004)

### Operational Guidance

- Lemmen et al. (2024)
- Wilson et al. (2014)
- Jiménez et al. (2017)

### Applied Practice

- Sandve et al. (2013)
- Grimm et al. (2014)

See `references/REFERENCES.md` for complete citations.
