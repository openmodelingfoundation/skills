# Agent-Based Modeling Guidance

## Purpose

Use this guidance when determining whether agent-based modeling (ABM) is an appropriate modeling paradigm for the given conceptual model and when making consequential methodological decisions about conceptual model design, abstraction, mechanisms, and representation.

This guidance supports scientific reasoning throughout model development. It is not an implementation guide, documentation template, or evaluation protocol.

---

## Core Principle

Agent-based models explain system behavior through explicitly represented entities, interactions, and mechanisms.

Use the simplest mechanistic representation capable of answering the research question. Introduce complexity only when it improves explanatory or decision-support value.

---

## Decision Context

**Use this guidance when:**

* the research question depends on heterogeneous individuals or entities
* interactions between entities influence system behavior
* emergence from micro-level processes is of interest
* adaptation, learning, or decentralized decision-making is important
* spatial, network, or path-dependent processes matter

**Do not use this guidance when:**

* aggregate behavior can be represented without explicit agents
* empirical or statistical models adequately address the research question
* system dynamics, differential equations, optimization, or discrete event simulation provide simpler representations

ABM is one modeling paradigm among several. Document why it is the most appropriate choice for the scientific question.

---

## Consequential Analytical Choices <!-- [MUST] -->

### Why Agent-Based Modeling?

Document why an ABM was selected instead of:

* statistical analysis
* system dynamics
* differential equation models
* discrete event simulation
* optimization
* network analysis

The rationale should reference the research question rather than implementation convenience.

### Abstraction

Document and justify:

* system boundaries
* abstraction level
* spatial representation
* temporal resolution
* omitted processes

Explain why important processes were excluded.

### Mechanism Choice

Include mechanisms because they contribute to explaining observed patterns, not because they are convenient to implement.

Prefer mechanisms that are:

* theoretically justified
* empirically supported
* necessary to answer the research question

Avoid unnecessary behavioral complexity.

### Agent Representation

Document:

* agent types
* environment
* interactions
* behaviors
* state variables
* boundaries

Avoid introducing agents solely because the software framework supports them.

### Scheduling

Document:

* synchronous or asynchronous updates
* update ordering
* event timing
* stochastic scheduling

Scheduling assumptions frequently influence model behavior and reproducibility.

### Stochasticity

Document:

* random number generators
* stochastic processes
* probability distributions
* seed policy
* replication strategy

Randomness should never remain implicit.

### Evidence

Clearly distinguish:

* empirical evidence
* theoretical assumptions
* expert judgment
* convenience assumptions

Do not invent behavioral mechanisms without identifying their justification.

### Calibration

Clearly distinguish:

* parameter estimation
* calibration
* parameter tuning
* validation

Avoid presenting calibration as validation.

Document the rationale for each consequential choice and generate reviewable intermediate artifacts where appropriate.

---

## Transparency <!-- [MUST] -->

Clearly distinguish:

* implemented behavior
* intended behavior
* empirical evidence
* theoretical assumptions
* modeling assumptions
* expert judgment

Document:

* assumptions
* simplifications
* omitted processes
* intended scope
* known limitations

Describe important differences between the conceptual model and the implemented model.

---

## Intermediate Artifacts

Generate or maintain, as appropriate:

* `conceptual-model.md`
* `model-rationale.md`
* `abstraction-decisions.md`
* `assumptions.md`
* `agent-inventory.md`
* `process-schedule.md`

Use predictable, semantic filenames under `artifacts/` at the project root. These artifacts should support downstream documentation, review, and reproducibility. If `artifacts/` is created during this work, also create `artifacts/README.md` describing artifacts as living documents created early, revised throughout the project, and gated by explicit status/review triggers.

---

## Common Failure Patterns

Watch for:

* recommending ABMs when simpler models suffice
* undocumented abstraction decisions
* unsupported behavioral mechanisms
* parameters documented as state variables
* undocumented stochasticity
* hidden scheduling assumptions
* overfitted calibration
* implementation complexity replacing conceptual clarity
* unsupported claims of validation
* vague research objectives

---

## Routing

Describe how this guidance relates to the rest of the guidance library and specialist skills.

* **Primary entry point** — This guidance is complementary to `uncertainty.md` and `deep-uncertainty.md`. Use this guidance to determine whether and how an ABM should represent the system. Apply uncertainty guidance after the conceptual model has been established.
* **Specialist execution skills** — `document` (ODD/ODD+2 generation), `document-review`, future `abm-design`, and future analysis skills for calibration, sensitivity analysis, and experimentation.
* **Downstream consumer skills** — `peer-review`, `fair4rs`, and `document`, which should communicate the modeling rationale, assumptions, abstractions, and limitations established here.

---

## Primary References

### Foundational Concepts

* Railsback & Grimm (2019)
* Gilbert (2019)
* Epstein & Axtell (1996)
* Epstein (1999)
* Miller & Page (2007)

### Operational Guidance

* Grimm et al. (2005) Pattern-Oriented Modeling
* Grimm et al. (2006) ODD
* Grimm et al. (2010) ODD Update
* Grimm et al. (2020) ODD+2
* Müller et al. (2013) ODD+D

### Applied Practice

* Grimm et al. (2014) TRACE
* Windrum et al. (2007)

See `references/REFERENCES.md` for complete citations.