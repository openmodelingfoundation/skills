# Agent-Based Modeling Guidance

This guidance supports agent-based modeling (ABM) throughout the modeling lifecycle, from selecting an appropriate modeling paradigm through conceptual design, implementation, experimentation, evaluation, documentation, and publication.

It complements the `document`, `peer-review`, `fair4rs`, `uncertainty`, and `deep-uncertainty` skills by helping determine when an ABM is appropriate, what methodological choices require explicit justification, what artifacts should be produced, and how to communicate model assumptions transparently.

Use this guidance only after the research problem has been clearly framed.

---

# Purpose

Help the agent reason about:

* whether agent-based modeling is appropriate
* how to develop a scientifically defensible conceptual model
* how to select mechanisms and abstractions
* what assumptions require documentation
* common methodological pitfalls
* transparency, reproducibility, and evaluation expectations

This guidance is not an ODD template or implementation guide. It focuses on scientific reasoning and modeling decisions.

---

# Model Selection

Before recommending an ABM, determine whether the research question fundamentally depends on one or more of the following:

* heterogeneous individuals
* local interactions
* adaptation or learning
* decentralized decision making
* emergence
* spatial interactions
* network interactions
* path dependence
* non-equilibrium dynamics
* feedback between agents and their environment

If these characteristics are not central to the research question, another modeling framework may provide a simpler or more appropriate representation.

Alternative approaches may include:

* statistical analysis
* differential equation models
* system dynamics
* discrete event simulation
* optimization
* network analysis

Recommend the simplest modeling approach capable of addressing the scientific question.

---

# Modeling Philosophy

Agent-based models explain system behavior by explicitly representing the behaviors and interactions of individual entities rather than prescribing aggregate system dynamics.

Prefer mechanistic explanations over empirical curve fitting.

Introduce complexity only when it contributes to answering the research question.

Continually ask:

* What mechanisms are hypothesized to generate the observed phenomena?
* Which mechanisms are supported by empirical evidence or established theory?
* Which mechanisms can reasonably be omitted?
* What level of abstraction is appropriate?

Avoid introducing complexity solely because it can be implemented.

---

# Conceptual Modeling

Develop a conceptual model before considering implementation details.

Clearly identify:

* system boundaries
* entities and agent types
* environment
* interactions
* spatial representation
* temporal resolution
* scales
* outputs of interest

The conceptual model should remain understandable independently of any programming language or modeling framework.

---

# Mechanism Selection

Include mechanisms because they contribute to explaining observed patterns, not because they are convenient to implement.

Prefer mechanisms that are:

* theoretically justified
* empirically supported
* necessary to answer the research question

Avoid unnecessary behavioral complexity.

Whenever possible, prefer models capable of reproducing multiple independent empirical or qualitative patterns over models tuned to reproduce a single outcome.

---

# Consequential Modeling Decisions

The following decisions should always be documented and justified.

## Why an Agent-Based Model?

Document why an ABM was selected instead of another modeling framework.

The rationale should reference the scientific question rather than software preference.

---

## Abstraction

Document decisions regarding:

* aggregation
* behavioral realism
* spatial resolution
* temporal resolution
* omitted processes

Explain why important processes were excluded.

---

## Agent Definition

Explicitly identify:

* agent types
* state variables
* behaviors
* interactions
* environment
* boundaries

Avoid introducing agents merely because software frameworks encourage them.

---

## State Variables

Clearly distinguish:

* state variables
* parameters
* constants

State variables belong to agents.

Parameters belong to the model.

Constants represent fixed assumptions.

---

## Scheduling

Document:

* synchronous or asynchronous updates
* update ordering
* stochastic scheduling
* event timing

Scheduling assumptions frequently influence model behavior and reproducibility.

---

## Stochasticity

Document:

* random number generators
* stochastic processes
* probability distributions
* seed policy
* replicate strategy

Randomness should never remain implicit.

---

## Evidence

Explicitly distinguish between:

* empirical evidence
* theoretical assumptions
* expert judgement
* convenience assumptions

Do not invent behavioral rules without identifying their justification.

---

## Calibration

Clearly distinguish:

* calibration
* parameter estimation
* parameter tuning
* validation

Avoid presenting calibration as validation.

---

# Experimental Design

Separate the model itself from the experiments performed with the model.

Document:

* manipulated variables
* response variables
* experimental factors
* replication strategy
* stopping conditions
* statistical analyses

Model design and experimental design should be independently reproducible.

---

# Evaluation

Evaluate models using multiple complementary approaches.

Possible forms of evaluation include:

* conceptual validation
* implementation verification
* behavioral validation
* calibration assessment
* sensitivity analysis
* robustness analysis
* uncertainty characterization
* fit for purpose

Prefer evaluation frameworks such as TRACE that explicitly document model development, testing, limitations, and credibility.

Avoid relying on a single performance metric.

---

# Transparency Requirements

Document:

* assumptions
* simplifications
* omitted processes
* intended scope
* known limitations

Explicitly distinguish between:

* implemented behavior
* intended behavior
* empirical evidence
* theoretical assumptions
* modeling assumptions

Describe any differences between the conceptual design and the implemented model.

---

# Intermediate Artifacts

Generate or maintain artifacts such as:

* `conceptual-model.md`
* `model-rationale.md`
* `abstraction-decisions.md`
* `assumptions.md`
* `agent-inventory.md`
* `process-schedule.md`
* `experiment-design.md`
* `evaluation-plan.md`
* `validation-report.md`
* `odd.md`
* `trace.md`

These artifacts improve transparency, reviewability, reproducibility, and publication readiness.

---

# Common Failure Patterns

Watch for:

* recommending ABMs when simpler models suffice
* undocumented abstraction decisions
* parameters documented as state variables
* undocumented stochasticity
* hidden scheduling assumptions
* unsupported behavioral mechanisms
* overfitted calibration
* excessive implementation detail replacing conceptual description
* unsupported claims of validation
* vague research objectives
* confusing implementation complexity with explanatory power

---

# Agent Guidance

Never:

* invent behavioral mechanisms without clearly identifying assumptions
* recommend unnecessary complexity
* introduce additional agent types solely to match a software framework
* confuse calibration with explanation
* claim validation without supporting evidence
* ignore uncertainty or stochasticity
* prioritize implementation details over scientific reasoning

Prefer:

* explicit assumptions
* simple mechanistic explanations
* transparent abstractions
* reproducible experiments
* scientifically defensible modeling decisions

---

# Routing Guidance

If the user wants to:

* determine whether ABM is appropriate, use this guidance
* generate ODD or ODD+2 documentation, use `document` or the `comses/odder` suite
* assess documentation quality, use `document-review` or the `comses/odder` suite
* evaluate publication readiness, use `peer-review`
* prepare research software for publication, use `fair4rs`
* perform sensitivity analysis, calibration, or uncertainty characterization, use `uncertainty`
* perform exploratory modeling or robust decision analysis under deep uncertainty, use `deep-uncertainty`

This guidance complements those skills but does not replace them.

---

# References

## Foundational Agent-Based Modeling

* Railsback & Grimm (2019)
* Gilbert (2019)
* Epstein & Axtell (1996)
* Epstein (1999)

## Model Design

* Grimm et al. (2005) Pattern-Oriented Modelling

## Documentation

* Grimm et al. (2006) ODD
* Grimm et al. (2010) ODD Update
* Grimm et al. (2020) ODD+2
* Müller et al. (2013) ODD+D

## Evaluation

* Grimm et al. (2014) TRACE
* Windrum et al. (2007)

## Complex Systems

* Miller & Page (2007)

See `references/REFERENCES.md` for complete citations.
