---
name: document
description: |
  Generate narrative documentation for computational models and research
  software, and select the appropriate documentation framework for a given
  model type.

  Use this skill when a user wants to:
    - document a computational model
    - generate documentation from source code
    - write an ODD or ODD+2 narrative for an agent-based model
    - create model narratives for publication or reuse
    - draft narrative workflow documentation

  The skill classifies the model type, selects a framework, extracts model
  structure from supplied materials, and drafts documentation. It does not
  assess or score existing documentation — use peer-review for
  submission assessment and structured review output. For
  model-card requests or scientific model specifications, route to omfa.

  Inputs may include source code, pseudocode, READMEs, publications,
  architecture descriptions, or model metadata.
license: MIT
compatibility: Any computational modeling framework or programming language
metadata:
  omf-stewardship: stewardship.yaml
---

# Document Skill

Generate narrative documentation for computational models and research software, from source code, pseudocode, publications, or other supplied materials.

The goal is accurate, reusable documentation that describes the model as implemented — not as it was intended or remembered to work.

## Skill Contract

- **Activation:** Narrative model or research-software documentation, including ODD/ODD+2; not documentation assessment, model cards, or scientific specifications.
- **Authority:** Narrative framework selection, structure, and faithful communication of supplied content.
- **Preconditions:** Inspectable source materials and a known or explicitly unknown audience, model type, and intended use.
- **Effects:** Create narratives and `omf-artifacts/document/` intermediates; do not rewrite OMFA scientific commitments.
- **Invariants:** Never invent model facts; distinguish observation, inference, conflict, and unknown information.
- **Outputs:** Framework-appropriate narrative, traceability information, and intermediate documentation artifacts as needed.
- **Handoffs:** Route scientific contradictions to `omfa` and assessment requests to the review specialist, passing sources and unresolved discrepancies.
- **Completion:** Required narrative sections are supported, unknowns and conflicts are visible, outputs are checked, and provenance is persisted or visibly deferred.
- **Failure:** Produce a qualified partial draft or request missing evidence rather than filling gaps with plausible content.
- **Provenance:** Record immutable narrative revisions, consulted sources, framework decisions, actual participants, and review state.
- **Commits:** Before a commit that could affect scientific claims, present its changes, affected claims, evidence, uncertainty, and full message; request approval of that specific commit and wait. Review one commit at a time. Wording approval alone is insufficient; prior approval covers only unchanged reviewed changes and message. Routine meaning-preserving commits still need authorization but no scientific gate. Prefer native approve/revise/defer choices with free-text feedback; otherwise use plain text. Defaults or silence are not approval. List actual contributing OMF skills in `OMF-Skills` and other contributing skills in `Agent-Skills`, using comma-separated names and omitting empty trailers. Preserve legitimate `Co-authored-by` attribution. Keep exact executed revisions and ownership in provenance; do not duplicate Git history. This rule does not itself authorize a commit.

---

# Core Principles

Documentation must faithfully represent supplied materials, distinguish evidence from inference, and remain consistent with implementation. Prioritize clarity over completeness, and reproducibility over polish.

Never invent entities, parameters, algorithms, equations, workflows, datasets, assumptions, or results. If information is unavailable, mark it `Unknown`, identify what's missing, and recommend clarification rather than filling the gap.

When generating documentation:

- document the selected framework and why it was chosen
- identify inferred information separately from information observed directly in the source materials
- preserve traceability: a reader should be able to tell which source artifact supports which claim

---

# When To Use / Do Not Use

Use this skill to **generate or draft** narrative documentation: new narratives, ODD/ODD+2 write-ups, structured model narratives, workflow descriptions, or improvements to existing prose.

This skill is commonly invoked downstream of `omfa`, which owns lifecycle guidance and required structured artifacts; `document` owns substantive narrative generation according to the OMF rubric. When invoked this way, use the model type, lifecycle stage, and target audience `omfa` provides rather than re-deriving them independently (see Workflow step 2 below).

If the request is for `omf-artifacts/model-card.md`, a model card, or any other scientific model specification, route to `omfa` instead of drafting it here.

Do not use this skill for documentation **review or assessment**. Route submission readiness or structured critique to `peer-review`, which can use this skill's `references/ODD-CHECKLIST.md` without rewriting prose. For a narrow checklist-only question, report that it is outside this drafting skill and provide the checklist as a reference.

Also out of scope: model calibration, sensitivity analysis, statistical analysis, software testing, code generation, peer review, FAIR assessment, and metadata validation.

Do not draft omfa's required lifecycle artifacts — `omf-artifacts/model-card.md`, `omf-artifacts/abm-spec.md`, or any other file directly under the `omf-artifacts/` root. These template-driven files belong to omfa even when the request emphasizes prose quality or overlaps with ODD+2. If a user asks for one of these artifacts by name, or asks for a scientific model specification, defer to omfa rather than drafting it directly.

This skill owns `omf-artifacts/document/` for its intermediate artifacts (see Workflow step 3 and Intermediate Artifacts below); omfa owns files directly under `omf-artifacts/`. Never write document's intermediate artifacts to that root.

Document owns narrative structure, framework selection, and conflict resolution for its intermediate artifacts and document-authored narratives. OMFA artifacts provide authoritative scientific content, and reviewer corrections may be incorporated when their source remains traceable. If sources contradict an OMFA artifact, flag the discrepancy in the narrative workflow and route the scientific revision to OMFA rather than silently reconciling or overwriting it.

For every material creation or revision under `omf-artifacts/document/` or to a document-authored narrative, append an immutable activity to `omf-artifacts/fair/provenance-manifest.json`. Give each revision a new entity ID, retain its stable logical ID, and link revisions with `wasRevisionOf`. Record document as contract authority, actual participants, source code and OMFA artifacts consulted, the selected framework and methodological references, corrections, and unresolved conflicts. Treat the manifest append as part of the recorded transaction and deduplicate only exact retries. Do not preserve raw prompts or hidden reasoning. If the schema is unavailable, return `provenance_handoff` with `activity`, `entity`, `authorization`, `agents`, `inputs`, `decisions`, `review`, `dependency_assertions`, `skill_identity`, `privacy`, and `persistence: incomplete`; route it to `fair`.

---

# Gotchas

These are concrete failure modes seen in ODD-style documentation, not general advice. They apply most directly to agent-based models but several generalize to any framework.

- **Parameters get mixed up with state variables.** A parameter is fixed for a run; a state variable differs across entities or changes over time. If a value can change during the simulation or differs entity-to-entity, it's a state variable, even if the source code stores it in a "parameters" struct or config file.
- **Stochasticity in code goes undocumented in prose.** If the source has a random draw, a seeded RNG, or a probabilistic branch, it must appear explicitly in the documentation — including the seed/replication policy — even if the modeler's narrative description never mentions randomness.
- **The narrative describes intended mechanisms, not implemented ones.** When a README, paper, or comment describes what a process is "supposed to do" but the code does something else (different order, different threshold, an early return that skips a branch), document what the code does. Flag the discrepancy rather than silently picking one version.
- **Design concepts get left implicit instead of being addressed.** Don't skip a design concept (adaptation, learning, sensing, etc.) just because the model doesn't obviously use it — state explicitly that it doesn't apply and why. An absent section reads as an oversight; an explicit "not applicable" reads as a reviewed judgment.
- **Process overview detail leaks into the schedule, and the schedule stays vague as a result.** If "process overview" prose starts describing per-agent algorithmic detail, that detail belongs in submodels. The overview's job is to leave the reader able to state, in one sentence, who acts, in what order, and whether updating is synchronous or asynchronous — if that sentence can't be written from the overview alone, the overview hasn't done its job.
- **Purpose statements collapse into a single vague verb.** "The model is used to explore X" doesn't tell a reader what would count as the model succeeding or failing at that exploration. State the purpose as a concrete question, hypothesis, or comparison, and pair it with the pattern(s) used to judge fit-for-purpose.
- **Reference and skill files drift out of sync.** If model-type classification or ODD guidance changes, the relevant `references/` file and this `SKILL.md` need to move together — a guidance update applied to one and not the other produces documentation that cites a standard the skill no longer actually follows. (This skill currently only has ODD+2 reference material on file — `references/ODD-METHODOLOGY.md` and `references/ODD-CHECKLIST.md`. The non-ODD framework rows in the table below are not yet backed by their own reference file; treat them as the SKILL.md's own working guidance until project-specific material for those model types is supplied.)

---

# Documentation Framework Selection

Classify the model, then pick a framework. Defaults below; deviate when the model genuinely doesn't fit, and say why.

| Model type | Default framework | Notes |
|---|---|---|
| Agent-based | ODD+2 | Autonomous agents, agent state changes over time, interactions drive behavior. Read `references/ODD-METHODOLOGY.md` before drafting. |
| Cellular automata | ODD+2 | Use ODD+2 by default — cells are entities with state variables and an update rule, which ODD+2 already covers well. Fall back to a structured narrative only if the model has no discrete agent-like entities at all (e.g., a single global field update with no per-cell heterogeneity). |
| System dynamics | Stock-and-flow narrative | Document stocks, flows, feedback loops, delays; route formal equations/specification work to omfa. |
| Differential equations | Narrative equation documentation | Document equations, parameters, initial/boundary conditions, numerical method at a narrative level; route formal scientific specifications to omfa. |
| Statistical simulation | Structured methods documentation | Document assumptions, distributions, sampling procedure, estimators, outputs. |
| Optimization | Narrative optimization documentation | Document objectives, constraints, search procedure, stopping conditions; route formal specification work to omfa. |
| Machine learning | Narrative model documentation | Document training data, architecture, evaluation procedure, limitations; route model-card requests to omfa. |
| Hybrid | Combine the relevant frameworks above | Don't just note that it's hybrid — write one section per constituent framework (e.g., ODD+2 for the agent layer, equations for a coupled differential-equation layer), and add a short note on how the two interact (what state crosses the boundary, in which direction, at what point in the schedule). |
| Other / uncertain | Structured narrative | State the uncertainty explicitly rather than forcing a framework that doesn't fit. |

---

# Inputs

Works from any combination of: source code, pseudocode, notebooks, scripts; READMEs, manuals, publications, technical reports, architecture diagrams; parameter/experiment descriptions and repository metadata.

When operating downstream of the `omfa` skill, also check for an `omf-artifacts/` directory at the project root and treat completed files there (`conceptual-model.md`, `assumptions.md`, `uncertainty-register.md`, etc.) as authoritative source material — draw model purpose, assumptions, and uncertainty framing from these rather than re-extracting or re-inferring them from source code alone.

---

# Workflow

1. **Identify the goal.** New documentation, or improvement of an existing draft. (For assessment instead of generation, route submission assessment to `peer-review`.)
2. **Classify the model type** using the table above. If a model type has already been supplied by an upstream skill (e.g. `omfa`), use it directly rather than reclassifying, unless the source materials clearly contradict it — in which case flag the discrepancy rather than silently overriding it. Otherwise, if uncertain, explain alternatives, why one was selected, and identify any assumptions made rather than forcing a fit.
3. **Select the framework** and record the rationale as an intermediate artifact in `omf-artifacts/document/` before drafting.
4. **Inventory the implemented structure before writing prose.** Extract entity types, state variables (per entity type), parameters/constants, spatial and temporal scales, main processes and update order, outputs, input data, and stochastic elements — directly from the source materials, not from the modeler's narrative description of them. This step exists specifically to catch the "narrative describes intended mechanisms, not implemented ones" gotcha above.
5. **Draft in this order for ODD+2:** purpose and patterns → entities/state variables/scales → process overview and scheduling → design concepts (all eleven, explicitly, including "not applicable" where true) → initialization → input data → submodels. This mirrors the order in `references/ODD-METHODOLOGY.md` and lets a reader understand the model at a glance before hitting submodel detail. For non-ODD frameworks, draft overview-level content before algorithmic detail using the same overview-before-details principle.
6. **Add rationale where a design choice is non-obvious** — why this scale, why this update order, why this parameterization, why an omitted process was excluded. Keep it brief; if it grows into design history, that belongs in supplementary material, not the core narrative.
7. **Link to code** where it reduces ambiguity: same names in prose and code, a file/function/procedure pointer under each submodel, software and library versions if they affect interpretation.
8. **If a full ODD already exists and a summary is needed for publication**, draft the summary only after the full version, preserving its keywords so a reader can map back, and move long tables out of the summary prose.
9. **Before finalizing an ODD+2 draft**, check it against `references/ODD-CHECKLIST.md`'s 23-point checklist. Treat any `Partial` as a revision target, not a pass.

---

# Intermediate Artifacts

Generate these before drafting documentation:

- model classification
- framework selection rationale
- extracted entities, parameters, and processes
- identified documentation gaps
- inferred vs observed information summary

These artifacts support transparency, review, and reuse and may be consumed by downstream skills like `peer-review` or `fair`. Prefer predictable, semantic names that describe the artifact's role in the workflow.

# Worked Example: Extraction Before Prose

This shows step 4 above applied to a small agent-based model, to make "inventory before prose" concrete.

Suppose the source code contains:

```python
class Forager:
    def __init__(self, energy=10.0, home_cell=None):
        self.energy = energy          # changes every step
        self.home_cell = home_cell    # fixed at creation
        self.strategy = "random_walk" # could change if learning is added later

    def step(self, rng):
        if self.energy <= 0:
            return  # dead, skip
        self.energy -= METABOLISM_COST          # METABOLISM_COST = 0.2, module constant
        if rng.random() < FORAGE_SUCCESS_PROB:   # FORAGE_SUCCESS_PROB = 0.3
            self.energy += FORAGE_GAIN           # FORAGE_GAIN = 2.0
```

Extraction, before any prose is written:

- **Entity type:** `Forager`.
- **State variables** (vary per agent / over time): `energy` (changes every step), `home_cell` (fixed at creation — actually a parameter-like value set once, but tied to the individual agent, so document it as an initialization detail rather than a global parameter), `strategy` (currently constant in this version, but flagged because the field name and comment suggest it's designed to vary later — document it as a state variable with a note that no learning process currently modifies it).
- **Parameters** (fixed, shared, not per-agent): `METABOLISM_COST = 0.2`, `FORAGE_SUCCESS_PROB = 0.3`, `FORAGE_GAIN = 2.0`.
- **Stochasticity:** one random draw per step, `rng.random() < FORAGE_SUCCESS_PROB`, governing foraging success. The seeding/replication policy isn't visible in this snippet, flag as `Unknown`, request clarification, rather than guessing it's seeded or unseeded.
- **Process note:** an agent with `energy <= 0` returns early and is skipped — this is a termination/death condition that belongs in the schedule and in submodel logic, not just in passing prose. It also means the order of the energy-depletion check relative to other agents' updates affects whether a dying agent forages on its last step; if the code update order matters here, the schedule must say so explicitly.

Only after this extraction would the ODD draft state, for example, under *Entities, state variables, and scales*: "`Forager` agents have state variables `energy` (float, depletes by a fixed metabolism cost each step and increases stochastically via foraging) and `strategy` (currently fixed to `"random_walk"`; no learning process modifies it in this version)." That sentence is traceable line-by-line back to the extraction above — nothing in it was inferred beyond what the code shows.

---

# Outputs

Depending on the user's goal, generate one or more of: a documentation draft, an ODD+2 narrative, a structured model narrative, a workflow description, or an architecture overview.

Every output should include: the selected framework and its rationale, the documentation itself, any information that was inferred (separately flagged from what was directly observed), and a list of anything left `Unknown`. When the source materials support more than one plausible interpretation, surface the competing interpretations rather than silently picking one, and ask for clarification if the choice is consequential.

---

# References

- `references/ODD-METHODOLOGY.md` — full ODD+2 protocol detail (element-by-element guidance, design-concept definitions, rationale-subsection convention, summary/nested/delta-ODD cases). Read before drafting any ODD+2 section; this is the authoritative source for ODD+2 content in this skill, not the table above.
- `references/ODD-CHECKLIST.md` — 23-point completeness/replication checklist with common failure modes. Check a finished ODD+2 draft against this before calling it done.
- `assets/ODD-TEMPLATE.md` — drafting scaffold with the full section/table structure for an ODD+2 narrative. Use as the starting structure for any new ODD+2 draft rather than building section headers from memory.

The non-ODD framework rows in the Documentation Framework Selection table above (system dynamics, differential equations, statistical simulation, optimization, machine learning) are not yet backed by their own `references/` files in this skill. If project-specific source material for those model types becomes available, it should be added the same way the ODD material was: as its own reference file, cited by name, with gotchas and a worked example drawn from it rather than written generically.

ODD+2 source: Grimm, V. et al. (2020). *The ODD Protocol for Describing Agent-Based and Other Simulation Models: A Second Update to Improve Clarity, Replication, and Structural Realism.* JASSS 23(2):7.

---

# Success Criteria

A successful outcome accurately reflects the supplied materials, clearly communicates model structure and behavior, separates inferred from observed information, identifies what's missing rather than filling it in, supports review, reuse, and comparison, and gives a reader enough information to reimplement or critically evaluate the model without asking the author clarifying questions.
