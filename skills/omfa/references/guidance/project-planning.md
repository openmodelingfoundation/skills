# Project Planning Guidance

## Purpose

Project planning helps researchers choose an appropriate level of planning and organize work into modular, reviewable increments that remain traceable to the conceptual model and research questions. This preserves flexibility as evidence, insights, and requirements evolve without losing scientific accountability for what changed and why.

Use this guidance after a reviewable conceptual model has been developed and before substantial implementation or experimentation begins. It coordinates project planning by translating conceptual models into implementation and analysis plans while preserving traceability between scientific objectives, implementation decisions, and evaluation activities.

This guidance helps answer the methodological question:

> How should a computational modeling project be organized so that implementation, evaluation, and project artifacts remain aligned with the conceptual model throughout the modeling lifecycle?

---

## Core Principle

Planning coordinates scientific work by making consequential decisions explicit before implementation and analysis embed them in software, experiments, and documentation.

---

## Decision Context

**Use this guidance when:**

- transitioning from conceptual modeling to implementation
- initiating a new computational modeling project
- revising project plans after significant conceptual changes
- coordinating work among multiple researchers, coding agents, or software components
- establishing project milestones and review checkpoints

**Do not use this guidance when:**

- developing or revising the conceptual model (`conceptual-modeling.md`)
- decomposing implementation work into software tasks (`implementation-planning.md`)
- designing experiments, evaluation, or statistical analyses (`analysis-planning.md`)

This guidance coordinates project-level planning and delegates detailed planning activities to specialized planning guidance.

---

## Consequential Analytical Choices <!-- [MUST] -->

### Project Scope

Define the minimum scientifically useful model needed to address the research questions. [MUST]

Document scope boundaries and justify exclusions. [MUST]

Clearly distinguish core project objectives from optional future extensions. [SHOULD]

Planning effort should be proportional to project scope, expected lifetime, collaboration needs, and anticipated reuse. [SHOULD]

### Planning Strategy

Separate implementation planning from scientific analysis planning. [MUST]

Identify dependencies between implementation milestones and planned analyses. [MUST]

Determine which activities can proceed independently and which require completion of earlier work. [MUST]

### Delegation Strategy

Identify activities appropriate for:

- human judgment
- coding agents
- deterministic software tools
- collaborative review

Document review checkpoints before consequential scientific decisions are accepted. [MUST]

Explicitly identify activities requiring human review before downstream work proceeds. [MUST]

### Traceability

Maintain explicit links among:

- research questions
- conceptual model
- implementation plan
- analysis plan
- evaluation artifacts

Ensure planning decisions remain traceable to the conceptual model rather than implementation convenience. [MUST]

---

## Planning Artifacts

Project planning should produce two complementary planning artifacts.

### Implementation Planning

Implementation planning addresses:

- implementation order
- task decomposition
- software dependencies
- implementation milestones
- delegation opportunities
- review checkpoints

Use `implementation-planning.md` to develop and maintain this plan.

### Analysis Planning

Analysis planning addresses:

- verification
- calibration
- validation
- sensitivity analysis
- uncertainty analysis
- experimental design
- statistical analyses
- visualization strategy
- success criteria

Use `analysis-planning.md` to develop and maintain this plan.

Both plans should evolve together as the conceptual model changes.

---

## Transparency <!-- [MUST] -->

Clearly distinguish:

- scientific objectives
- implementation constraints
- project management decisions
- expert judgment
- unresolved planning decisions
- anticipated project risks

Document planning assumptions, implementation priorities, and rationale for project sequencing. [MUST]

Record when planning decisions are driven by software engineering constraints rather than scientific objectives. [MUST]

---

## Intermediate Artifacts

Expected intermediate artifacts include:

- `project_plan.md`
- `implementation_plan.md`
- `analysis_plan.md`

Optional supporting artifacts:

- `decision_log.md`
- `risk_register.md`
- `milestones.md`

These artifacts should remain synchronized with the conceptual model and evolve throughout the modeling lifecycle.

Place planning artifacts under `artifacts/` at the project root. If `artifacts/` is created as part of planning, create `artifacts/README.md` stating these are living documents created early, revised throughout the project, and gated by explicit status/review triggers.

---

## Common Failure Patterns

- Beginning implementation without an explicit project plan.
- Planning around software architecture instead of conceptual structure.
- Treating implementation planning as a substitute for scientific planning.
- Deferring evaluation planning until implementation is complete.
- Allowing implementation convenience to redefine scientific objectives.
- Losing traceability between conceptual assumptions and implementation tasks.
- Creating implementation tasks that are too large to review effectively.
- Failing to update project plans after significant conceptual revisions.

---

## Routing

**Primary entry point**

Load this guidance after `lifecycle.md` when a project is ready to transition from conceptual design to coordinated implementation and scientific evaluation.

This guidance complements `conceptual-modeling.md` by organizing work after the conceptual model has been established.

**Specialist execution skills**

Project planning delegates to:

- `implementation-planning.md`
- `analysis-planning.md`

Additional guidance may be loaded as needed:

- `reproducibility.md` for project infrastructure and provenance
- `participatory.md` when stakeholder engagement influences project planning
- `ethics.md` when governance or societal impacts influence project priorities

**Downstream consumer skills**

Planning artifacts are consumed by implementation assistants, evaluation workflows, reproducibility tools, peer-review support, and documentation skills throughout the computational modeling lifecycle.

---

## Primary References

### Research Software Planning

- Barker et al. (2022) — FAIR Principles for Research Software (FAIR4RS)
- EVERSE RSMP Guidance - https://everse.software/RSQKit/software_management_planning

### Computational Modeling

- Jakeman et al. (2006)
- Jakeman et al. (2024)
- Grimm et al. (2020)

### Scientific Project Planning

- Wilson (2006)
- Wilson et al. (2017)

See `references/REFERENCES.md` for complete citations.
