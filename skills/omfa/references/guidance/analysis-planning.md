# Analysis Planning Guidance

## Purpose

Use this guidance after the conceptual model and implementation plan have been established to plan how the model will be exercised, analyzed, and interpreted.

The objective is to ensure that computational experiments, uncertainty analyses, evaluation, and statistical interpretation are designed to answer the research question while supporting transparent, reproducible, and scientifically defensible conclusions.

---

## Core Principle

Analysis should be driven by the research question rather than by the capabilities of the implementation.

The analysis plan should specify how evidence will be generated, interpreted, and communicated before computational experiments begin.

---

## Decision Context

**Use this guidance when:**

- planning computational experiments
- designing simulation campaigns
- selecting outputs and performance measures
- defining evaluation criteria
- planning statistical, sensitivity, or uncertainty analyses
- coordinating analyses across collaborators

**Do not use this guidance when:**

- developing the conceptual representation of the system (use `conceptual-modeling.md`)
- planning software architecture or implementation (use `implementation-planning.md`)
- selecting uncertainty characterization approaches (use `uncertainty.md`)
- determining model credibility (use `evaluation.md`)

---

## Consequential Analytical Choices <!-- [MUST] -->

### Research Questions

Document and justify:

- primary research questions
- hypotheses, if applicable
- intended model outputs
- decision criteria

Every planned analysis should trace directly to one or more research questions.

### Experimental Design

Document and justify:

- experimental factors
- manipulated variables
- response variables
- control scenarios
- stopping conditions
- replication strategy

Design experiments before examining results.

### Output Selection

Document:

- primary outputs
- secondary outputs
- derived metrics
- aggregation methods
- visualization strategy

Collect only outputs that contribute to answering the research question.

### Statistical Analysis

Document and justify:

- statistical methods
- comparison criteria
- effect measures
- uncertainty summaries
- significance or evidence thresholds, where applicable

Match analytical methods to the structure of the generated data.

### Computational Resources

Document:

- expected computational requirements
- parallelization strategy
- experiment management approach
- storage and archival requirements

Document the rationale for each consequential choice and generate reviewable intermediate artifacts where appropriate.

---

## Method Selection <!-- optional -->

When multiple analytical approaches are appropriate, compare them using criteria such as:

- alignment with the research question
- assumptions
- interpretability
- computational cost
- robustness
- reproducibility

Recommend the simplest analysis capable of supporting the intended scientific conclusions.

---

## Transparency <!-- [MUST] -->

Clearly distinguish:

- planned analyses
- exploratory analyses
- confirmatory analyses
- observed evidence
- inferred conclusions

Document:

- assumptions
- omitted analyses
- analytical limitations
- decision criteria

Avoid modifying the analysis plan in response to observed results without documenting the rationale.

---

## Intermediate Artifacts

Generate or maintain, as appropriate:

- `analysis-plan.md`
- `experiment-design.md`
- `output-specification.md`
- `analysis-workflow.md`
- `statistical-analysis-plan.md`
- `visualization-plan.md`

Use predictable, semantic filenames under `artifacts/` at the project root. These artifacts should support downstream execution, documentation, review, and reproducibility. If `artifacts/` is created during this work, also create `artifacts/README.md` describing artifacts as living documents created early, revised throughout the project, and gated by explicit status/review triggers.

---

## Common Failure Patterns

Watch for:

- collecting outputs without a clear scientific purpose
- designing experiments after observing results
- insufficient replication
- changing evaluation criteria post hoc
- selecting statistical methods without checking assumptions
- conflating exploratory and confirmatory analyses
- reporting only favorable outcomes
- failing to document analytical limitations

---

## Routing

Describe how this guidance relates to the rest of the guidance library and specialist skills.

- **Primary entry point** — Apply this guidance after `implementation-planning.md` and before computational experiments. It complements `uncertainty.md` and `evaluation.md` by defining how evidence will be generated and analyzed.
- **Specialist execution skills** — `uncertainty`, `evaluation`, future `statistical-analysis`, `sensitivity-analysis`, `calibration`, and experiment execution skills.
- **Downstream consumer skills** — `document`, `peer-review`, and `fair4rs`, which consume experiment designs, analytical methods, and supporting evidence.

---

## Primary References

### Foundational Concepts

- Jakeman et al. (2006)
- Jakeman et al. (2024)
- Hamilton et al. (2019)

### Operational Guidance

- Pianosi et al. (2016)
- Saltelli et al. (2008)
- Saltelli et al. (2019)

### Applied Practice

- Grimm et al. (2014) TRACE
- Augusiak et al. (2014)

See `references/REFERENCES.md` for complete citations.
