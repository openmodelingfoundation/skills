# Skills Roadmap

This document outlines planned expansions to this computational modeling skills repository.

The repository is evolving from a collection of standalone agent skills into a coherent framework for learning and practicing computational modeling. Its architecture separates lifecycle coordination, methodological guidance, and specialist execution skills so that agent-assisted scientific reasoning remains explicit, reusable, and reviewable.

## Tracking Issues

- [skills issue #1](https://github.com/comses/skills/issues/1)
- [planning issue #357](https://github.com/comses/planning/issues/357)

## Initial Release

**Status:** Active development; starter skills available

This roadmap is a living document and will be updated regularly.

**Last updated:** 2026-06-29

### Current Skills

- **omfa** (beta): guide modelers in applying good modeling practice across the full computational modeling lifecycle
- **document** (alpha): narrative documentation for a computational model
- **fair4rs** (alpha): Publication metadata and archival readiness
- **ospool** (alpha): OSPool batch and parameter sweep scaffolding
- **hpc** (alpha): HPC cluster job submission and arrays
- **peer-review** (alpha): Computational model peer-review readiness assessment using required criteria and supporting quality indicators

### Outcomes

The repository enables researchers to:

- apply established good modeling practices throughout the computational modeling lifecycle
- develop transparent, reviewable, and reproducible computational models
- document models using established reporting protocols (e.g., ODD+2)
- produce publication-ready metadata and research software artifacts aligned with FAIR4RS principles
- assess models against established methodological and peer-review criteria
- execute computational experiments on local, HPC, and distributed computing infrastructure
- reuse community-developed guidance and specialist skills across modeling projects
- contribute new methodological guidance and execution skills to an open ecosystem for computational modeling

---

## Reproducibility & Containerization

**Status:** In planning

### Planned Skills

#### **build-capsule** (alpha)

**Purpose:** Capture the model execution environment (language dependencies, system libraries, and code version) and enable reproducible reruns with verification of output consistency, using either lightweight containerization or trace-based capsules (e.g., ReproZip).

**Audience:** Modelers who need durable, inspectable execution environments for computational experiments; journals and funders requiring verifiable, repeatable results under controlled conditions.

**Value:** Packages code, dependencies, and execution context into portable capsules that enable rerunning models with consistent behavior, detecting divergence due to environment changes, and making sources of stochasticity explicit.

#### Interface

**Inputs:**

```json
{
  "action": "capture | inspect | replay | export | validate",
  "cmd": "string",
  "workdir": "path",
  "inputs": ["paths"],
  "outputs": ["paths"],
  "target": "rpz | docker | apptainer",
  "validate": "boolean",
  "constraints": {
    "offline": true,
    "validate": true
  }
}
```

**Outputs:**

```text
/capsule/
  Dockerfile | *.def
  experiment.rpz (optional)
  manifest.json
```

#### Behavior

- Defaults to **containerization**
- Offers **trace capture (ReproZip)** when available
- Produces a runnable artifact for the input command

#### Decision Rules

- Use **container** when environment is reasonably structured
- Use **trace** when dependencies are unknown or container fails
- Prompt for external software or data dependencies

#### Capabilities

##### Containerize

- Generate lightweight Dockerfile or Apptainer definition
- Copy project files into container
- Set entrypoint to input command
- Attempt dependency installation (best-effort)

##### Trace

- Capture execution with ReproZip
- Bundle environment and files into `.rpz`
- Optionally derive container from trace

##### Validate (optional)

- Run original and packaged versions
- Compare exit codes and outputs

#### Manifest

Possible alignment with micro RO-Crate / PROV / BDBag / etc

```json
{
  "command": "...",
  "workdir": "...",
  "action": "...",
  "backend": "...",
  "target": "...",
  "inputs": [{ "path": "...", "hash": "..." }],
  "outputs": [{ "path": "...", "hash": "..." }],
  "artifacts": ["..."],
  "uncertainty": {
    "level": "medium",
    "sources": [
      {
        "type": "dependency | data | execution | environment | external",
        "detail": "..."
      }
    ]
  }
}
```

#### Constraints

- Container builds may miss implicit dependencies
- Trace requires Linux and may not capture all behavior
- External services and network effects are not reproducible
- Hardware and OS differences may affect replay
- Determinism is not guaranteed

Prefer **containers for portability**, use **tracing to recover hidden dependencies**.

#### Implementation notes

**Reference tooling:**

- [dockta](https://github.com/stencila/dockta)

- auto-detect entrypoint from:
  - shell history (if available)
  - Makefile / scripts
- suggest:
  - isolate run directory
  - minimize external state
- warn on:
  - large data (> threshold)
  - remote services (not captured by ReproZip; common limitation)

(These are inherent to ReproZip’s tracing model; alternatives like containers or Nix differ in guarantees.)

#### Possible extension hooks

- integrate with:
  - Snakemake / Nextflow (workflow-level reproducibility)
  - Nix/Guix (stronger reproducibility, different model; optional path)
- add provenance export (RO-Crate or similar; optional, uncertain standard choice)

Treat ReproZip as a **low-friction onboarding layer**: capture first, then progressively harden into containers or declarative environments for durability.

- Integration with reproducibility artifact archival workflows

## Analysis & Validation

**Status:** In planning

### Planned Skills (Analysis & Validation)

#### **parameter-sweep-analysis** (alpha)

Design parameter sweeps using Dakota toolkit workflows (for example OAT, factorial, and Latin Hypercube studies); compute sensitivity indices; generate interactive dashboards.

**Value:** Automate sensitivity analysis workflow from design to visualization.

**Key features:**

- `scripts/generate_dakota_input.py`: Generate Dakota input files for DOE and sensitivity studies
- `scripts/run_dakota.sh`: Execute Dakota studies and collect run artifacts
- `scripts/parse_dakota_results.py`: Extract and normalize sensitivity outputs for downstream analysis
- `scripts/plot_heatmap.R`: Interactive Plotly HTML dashboards from results
- Standardized JSON output format for downstream analysis

**Audience:** Modelers exploring parameter sensitivity; researchers developing emulators or calibration pipelines

#### **model-validation-harness** (alpha)

Generate unit test templates, regression test scaffolding, and parameter bounds checking for model logic validation.

**Value:** Reduce validation burden by auto-generating test boilerplate; catch regressions early in development.

**Key features:**

- `scripts/generate_tests.py`: Stub test file from model functions/classes
- `scripts/check_bounds.py`: Validate parameter ranges and state variable invariants
- `scripts/regression_suite.py`: Snapshot-based output regression tests
- CI/CD integration (GitHub Actions, GitLab CI templates)

**Audience:** Model developers; teams requiring continuous regression checking

#### **notebooks-to-reproducible-workflow** (alpha)

Convert Jupyter/Quarto notebooks into containerized, version-controlled, reproducible pipelines.

**Value:** Bridge exploratory analysis (notebooks) and reproducible production workflows.

**Key features:**

- `scripts/nb_to_script.py`: Jupytext conversion to .py with markdown cells
- `scripts/exec_script.sh`: Ordered cell execution with error capture and logging
- `scripts/validate_rerun.py`: Determinism check against output snapshots
- Integration with build-capsule for containerization

**Audience:** Researchers transitioning from exploratory analysis to reproducible workflows; computational journalism

---

## Advanced Integration & Domain Extensions

**Status:** Conceptual

### Planned Skills (Advanced Integration)

#### **agentpy-scaffolder** (alpha)

Automated scaffolding for models built with AgentPy framework; template generation, API documentation, ODD extraction from code decorators.

**Value:** Reduce boilerplate for AgentPy users; auto-generate ODD from within-code metadata.

**Audience:** AgentPy modelers

#### **netlogo-to-python** (alpha)

Semi-automated translation from NetLogo to Python using AST analysis and pattern matching.

**Value:** Enable Python modelers to leverage NetLogo benchmark models.

**Audience:** NetLogo users interested in Python; multi-language model comparison research

#### **bayesian-inference-wrapper** (alpha)

Setup Bayesian calibration (PyMC, STAN) for parameter estimation from observed data; generate inference diagnostics and posterior predictive plots.

**Value:** Automate Bayesian workflow for model calibration.

**Audience:** Quantitative modelers; researchers with observational or experimental data

#### **model-ensemble-framework** (alpha)

Orchestrate ensembles of models (different implementations, parameters, or structures) for comparative analysis and voting/stacking.

**Value:** Support multi-model comparison and ensemble decision-making.

**Audience:** Modelers comparing competing paradigms or theories

---

## Guidance Library Roadmap

This document captures architectural decisions and prioritized future work for the computational modeling guidance library.

## Architectural Principles

The repository is organized into four conceptual layers:

```text
OMFA
    ↓
Lifecycle guidance
    ↓
Methodological guidance
    ↓
Specialist execution skills
```

Each layer has a distinct responsibility:

| Layer                       | Responsibility                                                                                                                                                |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| OMFA                        | Classify requests, identify the current lifecycle state, load appropriate guidance, and recommend specialist skills.                                          |
| Lifecycle guidance          | Coordinate the modeling lifecycle, identify lifecycle readiness, manage artifact dependencies, detect regression triggers, and route to specialized guidance. |
| Methodological guidance     | Encode expert reasoning for specific methodological domains.                                                                                                  |
| Specialist execution skills | Execute analyses and produce artifacts using the applicable methodological guidance.                                                                          |

Guidance documents should answer **methodological questions**, not implement workflows or execute analyses.

Specialist skills should implement analyses and generate artifacts while remaining guided by the applicable methodological reasoning.

---

## Guiding Principles

Future additions should preserve the following design principles:

- Prefer explicit, reviewable artifacts over implicit conversational state.
- Encode methodological reasoning rather than implementation procedures.
- Route to the smallest applicable set of guidance documents.
- Produce reusable intermediate artifacts for downstream skills.
- Treat analytical dependencies explicitly and identify regression triggers when consequential decisions change.
- Keep guidance modular, composable, and domain independent whenever practical.

---

## Priority Backlog

## High Priority

### Planning Guidance

Bridge conceptual modeling and implementation planning.

Topics:

- implementation planning
- task decomposition
- implementation milestones
- delegation boundaries
- review checkpoints
- iterative planning

Key question:

> What work should be delegated, and in what order?

---

### Agent Collaboration Guidance

Methodological guidance for effective collaboration with coding agents.

Topics:

- human versus agent responsibilities
- review and oversight
- preserving scientific judgment
- iterative refinement
- maintaining project context
- avoiding deskilling

Focus on collaboration methodology rather than prompt engineering.

---

## Medium Priority

### Experimentation Guidance

Methodological guidance for experimental design.

Topics:

- experimental objectives
- factors and responses
- replication
- stochastic experiments
- computational budgets
- analysis planning

---

### Calibration Guidance

Topics:

- parameter estimation
- identifiability
- equifinality
- optimization objectives
- reporting standards

---

### Validation Guidance

Clarify methodological distinctions among:

- verification
- calibration
- validation
- evaluation

---

### Visualization Guidance

Topics:

- behavioral diagnostics
- uncertainty visualization
- emergent behavior
- communication for decision support
- visualization failure modes

---

### Documentation Guidance

Extend reproducibility guidance with documentation methodology.

Topics:

- model documentation
- assumptions
- provenance
- model cards
- publication artifacts

---

## Future Architectural Directions

### Context Engineering Guidance

Potential future guidance describing how modeling artifacts become reusable context throughout the computational modeling lifecycle.

Possible topics:

- persistent project context
- reusable artifacts
- selective context loading
- summary versus source artifacts
- dependency-aware updates
- maintaining consistency

This guidance should treat context engineering as an extension of computational modeling practice rather than prompt engineering.

---

### Scaffolding Library

Consider introducing a repository-level distinction between methodological guidance and agent scaffolding.

```text
guidance/
```

Methodological reasoning.

```text
scaffolding/
```

Agent workflow organization.

Potential scaffolding topics:

- project organization
- context management
- conversation management
- repository conventions

Scaffolding should organize agent behavior without duplicating methodological reasoning already captured by the guidance library.

---

## Design Heuristics

When adding new guidance documents:

- Start from a consequential methodological question.
- Define clear routing boundaries with existing guidance.
- Require reviewable intermediate artifacts where appropriate.
- Identify consequential analytical choices rather than procedural steps.
- Document common methodological failure patterns.
- Route execution to specialist skills instead of embedding implementation details.

When adding new specialist skills:

- Consume existing guidance rather than replacing it.
- Reuse lifecycle artifacts whenever possible.
- Keep implementation concerns separate from methodological reasoning.
- Produce artifacts that remain useful to downstream skills.

---

## Sustainability & Governance

### Community Contributions

All skills are open to community contributions. See [CONTRIBUTING.md](../CONTRIBUTING.md) and [SKILL-TEMPLATE.md](./SKILL-TEMPLATE.md) for guidelines.

### Review & Acceptance

- Skills undergo community review before merge (GitHub PR workflow)
- Feedback and issues are tracked on the repository

### Version & Support

- Skills follow semantic versioning (v1.0.0, v1.1.0, v2.0.0)
- Critical bugfixes are backported to stable versions
- Deprecated skills remain available but marked as such

---

## Feedback & Roadmap Updates

We welcome feedback on the roadmap! Please:

1. Open an issue to discuss a planned skill or propose a new skill
2. Share use cases or pain points your research encounters
3. Contribute implementations (see CONTRIBUTING.md)
