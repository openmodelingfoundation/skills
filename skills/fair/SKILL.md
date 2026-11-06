---
name: fair
description: |
  Use this skill when planning or reviewing FAIR stewardship of digital
  research objects, including research software, datasets, computational
  models, and workflows. Use it for FAIR metadata, reproducibility assessment,
  object/workflow provenance, persistent identifiers, citation, repository
  organization, dependency and environment management, packaging, portability,
  archival preparation, preservation, stewardship artifacts, and management
  planning. FAIR owns stewardship metadata, reproducibility assessment,
  object/workflow provenance, packaging, and pointers to scientific artifacts;
  it does not author or canonicalize model-card content.

  Triggers include making research objects FAIR, reproducible, citable,
  reusable, publication- or archive-ready; creating FAIR metadata (e.g.
  codemeta.json, CITATION.cff, RO-Crate); packaging or archiving
  a repository, dataset, or model; and developing FAIR, data, software, or
  maintenance plans.

  Expected output: a FAIR Management Plan as the sole canonical stewardship
  document, with appropriate metadata, provenance, reproducibility, packaging,
  and archival artifacts, plus a DMP, SMP, or maintenance plan when required as
  a derived extract.
license: MIT
compatibility: Works with any project managing research software, datasets, computational models, or workflows
metadata:
  omf-stewardship: stewardship.yaml
---

# FAIR Research Objects Skill

This skill applies the FAIR principles across research software, computational models, datasets, workflows, metadata, and other digital research objects to improve discoverability, accessibility, interoperability, reproducibility, provenance, preservation, and long-term reuse.

The FAIR Management Plan is the project's sole canonical stewardship document and source of truth. DMP and SMP outputs are dissemination extracts derived from it, not independent stewardship authorities. If a requirement first appears in a DMP or SMP, record it in the FAIR Management Plan first, then re-derive the downstream extract.

## Skill Contract

- **Activation:** Stewardship, FAIR assessment, metadata, provenance, reproducibility, packaging, citation, preservation, or management planning; not scientific model authorship.
- **Authority:** Stewardship decisions, metadata coherence, provenance schema, reproducibility assessment, preservation, packaging, and citation.
- **Preconditions:** Identifiable research objects and available project evidence; publishing or depositing additionally requires explicit user authority and external access.
- **Effects:** Create or revise `omf-artifacts/fair/`, scoped metadata/provenance links elsewhere, and authorized packaging or deposit outputs.
- **Invariants:** Preserve scientific claims, distinguish research objects, retain lineage, and avoid secrets, raw prompts, hidden reasoning, and unnecessary personal data.
- **Outputs:** FAIR Management Plan and task-appropriate metadata, assessments, provenance, packaging, citation, or preservation artifacts.
- **Handoffs:** Route scientific changes to `omfa`, implementation changes to `omfb`, and narrative changes to `document`, passing conflicts and evidence.
- **Completion:** Required stewardship outputs are coherent, validated, linked to their objects, and qualified where identifiers or evidence remain unavailable.
- **Failure:** Use `unknown`, record blocked external actions, and never imply publication, archival, or verification that did not occur.
- **Provenance:** Maintain the canonical manifest and validate immutable entities, activities, authorization, reviews, privacy, and stale dependencies.
- **Commits:** Before a commit that could affect scientific claims, present its changes, affected claims, evidence, uncertainty, and full message; request approval of that specific commit and wait. Review one commit at a time. Wording approval alone is insufficient; prior approval covers only unchanged reviewed changes and message. Routine meaning-preserving commits still need authorization but no scientific gate. Prefer native approve/revise/defer choices with free-text feedback; otherwise use plain text. Defaults or silence are not approval. List actual contributing OMF skills in `OMF-Skills` and other contributing skills in `Agent-Skills`, using comma-separated names and omitting empty trailers. Preserve legitimate `Co-authored-by` attribution. Keep exact executed revisions and ownership in provenance; do not duplicate Git history. This rule does not itself authorize a commit.

## Responsibility

FAIR owns stewardship metadata, reproducibility assessment, object/workflow provenance, and packaging. It does not own scientific specifications (`omfa`), narrative communication (`document`), or human assessment (`peer-review`). Keep these authorities separate when extending any skill.

Data or authority governance questions about populations whose data or knowledge a model draws on, including collective benefit, authority to control, accountability for use, or affected-population consent and legitimacy, are modeling ethics concerns. Route those to `omfa`'s `references/guidance/ethics.md`; do not treat them as resolved by FAIR packaging, metadata, or archival stewardship alone.

Use this skill for:

- stewardship of research software
- FAIR metadata
- persistent identifiers
- provenance capture
- reproducibility
- repository organization
- dependency and environment management
- data packaging
- model packaging
- workflow capture
- archival preparation
- citation
- preservation
- release and publication readiness where applicable

Do not use this skill for:

- scientific reasoning, conceptual modeling, or methodological choices; use `omfa`
- narrative model documentation; use `document`
- methodological peer-review assessment; use `peer-review`
- HPC job design or performance tuning; use `hpc`
- distributed execution workflow design; use `ospool`

## Inputs

This skill works best with:

- an existing FAIR Management Plan, when this is an update rather than a first draft
- datasets and repositories
- computational models
- workflow descriptions
- notebooks
- simulation outputs
- metadata records
- persistent identifiers (DOIs, ORCID, ROR)
- repository URL or local repository path
- software title, version, and license
- primary language and packaging format
- dependency list, runtime, and environment details
- authors, ORCIDs, affiliations, and contributor roles
- release target, archive target, or citation target
- data and model dependencies with identifiers when available
- known provenance sources, build steps, and execution assumptions

If OMFA has already classified the model or provided methodological context in `omf-artifacts/`, reuse that information instead of re-deriving it.

## Workflow

**Classify the stewardship task.** Classify the request as one or more of:

- planning a release, archival package, or other stewardship milestone
- refreshing metadata or citation files
- improving reproducibility or provenance
- organizing the repository for reuse
- checking packaging, portability, or environment capture
- capturing object/workflow provenance
- disseminating a DMP or SMP from the FAIR Management Plan
- drafting or refreshing a maintenance plan for sustained maintenance, support, versioning, update triggers, or operational governance

For narrow, self-contained requests (for example a targeted citation, metadata update, packaging task, or a single dataset metadata record), do not start a full new FAIR Management Plan unless the work introduces or changes cross-object stewardship decisions. If an existing FAIR Management Plan is present and the change is consequential, update it; otherwise return the requested artifact plus explicit unknowns/follow-ups. This exception does not apply to maintenance planning.

If the request is really about scientific reasoning, model structure, or method choice, route to `omfa` instead.

**Inventory available FAIR research assets.** Inventory:

- software
- models
- datasets
- workflows
- documentation
- metadata
- provenance
- identifiers
- licenses

Separate observed facts from inferred assumptions. Mark missing information as `Unknown` rather than guessing. Write this inventory directly into the Research Object Inventory table in `omf-artifacts/fair/fair-management-plan.md`; the table is the persisted form of this step, not a duplicate of it.

Assess reproducibility and provenance for each inventory entry and record the current status in the FAIR Management Plan and backing FAIR assessment artifacts.

The Research Object Inventory is the canonical inventory of all managed research objects in the project. Every other FAIR artifact (`omf-artifacts/fair/fair-assessment-report.md`, `omf-artifacts/fair/provenance-manifest.json`, `omf-artifacts/fair/license-inventory.md`, and any metadata records) should reference inventory entries by name or identifier rather than re-listing or re-describing them. If an artifact needs to say something about a research object that isn't in the inventory, add it to the inventory first.

Every managed research object MUST appear exactly once in the Research Object Inventory. Other FAIR artifacts reference inventory entries rather than redefining them. The Research Object Inventory contains research objects being stewarded, not the supporting FAIR artifacts used to describe or assess them.

**Choose the canonical metadata representation.** Choose canonical metadata appropriate for each artifact:

- Software: codemeta.json
- Citation: CITATION.cff
- Datasets: DataCite metadata
- Models: OMF metadata
- Workflows: RO-Crate, WorkflowHub metadata, CWL metadata
- Repositories: README, LICENSE

Prefer community-adopted metadata standards whenever they exist. Only introduce project-specific metadata when existing standards are insufficient, and document the gap it fills and the standard it extends.

When metadata overlap across representations, identify the canonical metadata record for each artifact type and synchronize derived metadata from it. Call out inconsistencies and request human review. Do not maintain two independently edited metadata records describing the same research object.

**Produce FAIR stewardship artifacts.** Produce the minimum set of FAIR stewardship artifacts appropriate for the research objects present, whether or not the project has a release event.

- Software: codemeta.json, CITATION.cff, and optional Software Management Plan guidance when a project needs living process documentation
- Datasets: DataCite metadata, README, and inventory-backed provenance notes
- Models: OMF metadata; pointers to OMFA-owned scientific artifacts (including `omf-artifacts/model-card.md`); and pointers to ODD/TRACE narratives owned by `document`, without replacing any of those artifacts
- Workflows: RO-Crate and workflow provenance records

Shape the recommendations to the primary research objects and intended reuse:

- Exploratory research: prioritize reproducibility and environment capture
- Reusable software or datasets: prioritize packaging, documentation, and API/format stability
- Computational models: prioritize parameterization, calibration/validation data, and provenance of derived results, alongside OMF metadata and references to the OMFA-owned scientific artifacts and `document`-owned narratives that support the model
- Reference workflows: prioritize portability and machine-readable execution steps
- Long-lived infrastructure: prioritize robustness, governance, and maintenance

**Make portability and preservation explicit.** Document:

- installation
- execution
- workflows
- data dependencies
- model dependencies
- provenance, expressed using a documented provenance model where practical (e.g. W3C PROV-O, the RO-Crate provenance profile, or another domain-standard scheme) rather than free text
- reproducibility assessment, documented per object and per workflow
- identifiers
- archival locations
- preservation strategy
- interoperability limitations

**Check coherence before finalizing.** Verify that:

- names, versions, and licenses match across outputs
- author order and credit are consistent, and match the Roles and Responsibilities section of the FAIR Management Plan
- published or archived artifacts link back to the repository and version tag
- dependencies and environments are stated clearly enough for others to reproduce the work
- provenance is preserved for generated or derived artifacts
- reproducibility is assessed for each managed object and workflow
- unknowns are explicit and not silently filled in
- every research object has persistent identifiers where appropriate
- metadata are internally consistent
- provenance links all derived artifacts
- licenses are explicitly declared, use SPDX where possible, potential compatibility concerns are flagged, unresolved licensing questions are documented
- citation metadata are complete
- software, data, and models reference one another
- repositories expose machine-readable metadata
- any DMP or SMP in circulation still matches the FAIR Management Plan it was derived from

**Route adjacent work.**

- Scientific reasoning, conceptual modeling, or methodological decisions → `omfa`
- Narrative documentation, methods sections, OMF, or ODD narratives → `document`
- Publication-quality assessment or compliance review → `peer-review`
- Performance optimization or parallel execution → `hpc`

## When to Load References

Load the reference map first, then pull specific sources as needed:

- `references/README.md` for the reference map and file roles

Core FAIR literature (via the reference map):

- FAIR Principles: Wilkinson et al. (2016)
- FAIR Research Software: Barker et al. (2022), Chue Hong et al. (2022)
- Research Software Engineering: Wilson et al. (2014), Lemmen et al. (2024), Jiménez et al. (2017)
- Data stewardship: DataCite, RO-Crate
- Computational models: OMF, ODD, TRACE

Load additional material only when needed:

- `references/FAIR-RSE-CROSSWALK.md` when aligning FAIR4RS metadata, citation, packaging, and release sections
- `references/FAIR-RELEASE-REFRESH-POLICY.md` when checking refresh cadence and maintenance expectations
- `assets/FAIR-MP-TEMPLATE.md` when drafting or refreshing the living FAIR Management Plan
- `assets/DMP-TEMPLATE.md` when disseminating a funder-facing DMP from the FAIR Management Plan
- `assets/SMP-TEMPLATE.md` when disseminating a funder-facing SMP from the FAIR Management Plan
- `assets/maintenance-plan-template.md` when drafting or refreshing an operational maintenance plan from the FAIR Management Plan
- `assets/provenance-manifest-template.json` when capturing object or workflow provenance
- `assets/provenance-manifest-schema.json` when creating or validating an artifact provenance manifest

## Practical Outputs

All FAIR stewardship review artifacts generated by this skill MUST be stored under `omf-artifacts/fair/`. Research-object metadata and other files that conventionally live with the research object SHOULD remain in their appropriate project location and be referenced from the FAIR Management Plan.

### Artifact contract

FAIR owns the structure, stewardship decisions, assessments, and conflict resolution for `omf-artifacts/fair/`. Other skills may add traceable factual inventory entries, identifiers, repository locations, and provenance evidence. They must not change FAIR assessments, stewardship commitments, preservation decisions, or management-plan structure.

FAIR may update persistent identifiers and provenance links in OMFA's `omf-artifacts/model-card.md`, but must not revise its scientific claims. Route conflicting metadata or changes outside these contribution scopes to the artifact's owner.

When required for project-level stewardship, the FAIR Management Plan is the project's living stewardship document and MUST be maintained at `omf-artifacts/fair/fair-management-plan.md`. Update an existing plan when research objects, metadata, repositories, identifiers, preservation strategies, or stewardship responsibilities change consequentially.

A DMP or SMP, when required by a funder, is a secondary dissemination artifact derived from the FAIR Management Plan, never drafted independently. Store it separately and note the exact FAIR-MP version and date it was derived from, so drift is detectable.

A maintenance plan request is a management-planning exception: first create or update `omf-artifacts/fair/fair-management-plan.md` with the relevant stewardship decisions, then derive `omf-artifacts/fair/maintenance-plan.md` from it. The maintenance plan is a secondary operational artifact and must not introduce conflicting stewardship decisions.

The provenance manifest is the FAIR-owned canonical lineage record for material artifact and research-object activities under `omf-artifacts/`; keep entity `inventory_entry` values aligned with the Research Object Inventory when it exists. Use `assets/provenance-manifest-template.json` and validate its structure and semantics against `assets/provenance-manifest-schema.json`. Manifest maintenance is part of the transaction it records and is exempt from a second activity record, preventing recursive self-provenance.

A material change alters an artifact's claims, decisions, evidence, status, dependencies, contributor roles, or relationships. Formatting-only edits do not require a new activity. For each material change:

- create an immutable entity for each material revision, retain a stable `logical_id`, and link revisions with `wasRevisionOf`;
- append an immutable create, revise, derive, transform, execute, validate, review, migrate, package, publish, or archive activity; deduplicate only exact retries with the same activity ID;
- record contract authority in the entity and authorization record, and record only actual contributors, executors, reviewers, and authorizers as activity participants;
- identify the skill source, repository release when available, and exact Git revision or skill content hash when observable;
- record inputs, templates, methodological sources, and consequential decisions;
- relate revisions and derived artifacts to their predecessors; represent current, potentially stale, invalidated, and resolved dependencies with explicit dependency assertions;
- use `unknown` for unavailable values rather than inventing them;
- keep `raw_prompt_recorded` false, declare sensitivity and redaction review, and exclude hidden reasoning, secrets, and unnecessary personal data.

Other skills may append conforming provenance evidence for artifacts they create or revise. FAIR resolves schema conflicts and performs project-level coherence review; it does not claim authorship of another skill's activity. Accept a deferred `provenance_handoff` containing `activity`, `entity`, `authorization`, `agents`, `inputs`, `decisions`, `review`, `dependency_assertions`, `skill_identity`, `privacy`, and `persistence`; validate it, assign collision-resistant IDs, and append without rewriting prior history.

Depending on the task, generate or update one or more of the following under `omf-artifacts/fair/`:

- `fair-management-plan.md`: **REQUIRED** for project-level stewardship, FAIR assessments, management-planning, releases/archival milestones, or any work that changes cross-object stewardship decisions. For narrow self-contained tasks, update an existing plan if one exists and the change is consequential; otherwise omit a full new plan.
- FAIR metadata records appropriate to the research objects (e.g. `codemeta.json`, `CITATION.cff`, DataCite metadata, RO-Crate metadata)
- `fair-assessment-report.md`: generate for project-level FAIR assessments or stewardship reviews; not required for narrow metadata, citation, or packaging tasks. Assess FAIR status per research object and workflow, not per project; a single project routinely has FAIR software alongside non-FAIR datasets and draft workflows, and each needs its own status. Reflect the current status of each object in a status column on the Research Object Inventory table, and use this file for the backing detail (what's missing, what's planned) behind each status. Update both together.
- `omf-artifacts/fair/provenance-manifest.json`: generate or update from the v2 template for material artifact, object, or workflow activities; link entities to Research Object Inventory entries when that inventory exists
- `omf-artifacts/fair/license-inventory.md`
- `omf-artifacts/fair/maintenance-plan.md`: generate for sustained maintenance, versioning, support, update triggers, or operational governance; first create or update `omf-artifacts/fair/fair-management-plan.md`, then derive this plan from it using `assets/maintenance-plan-template.md`
- `stewardship-checklist.md` — a general readiness checklist for whatever milestone applies (release, archival deposit, or ongoing curation); rename to `release-checklist.md` only for projects where a software release is specifically the milestone in question
- `dmp.md` or `smp.md` — only when a funder requires it, derived from `assets/DMP-TEMPLATE.md` or `assets/SMP-TEMPLATE.md` as appropriate

## Citation

### Research Object Citation
- Cite each research object (e.g., software, data, models, workflows, publications) as a distinct scholarly output.
- List only contributors to the cited object as its authors/creators.
- Cite related research objects separately.
- Explicitly describe relationships (e.g., "implements", "derived from", "extends", "replicates", "uses", or "documents").
- Include an appropriate persistent identifier (DOI, SWHID, trusted repository identifier), version, title, publisher/repository, and license where applicable.
- Document provenance, including transformations, assumptions, and modifications.
- Prefer community citation metadata standards (e.g., CITATION.cff, CodeMeta, DataCite).
- Follow the applicable FORCE11 citation principles.

### Software Citation
- List only software contributors as software authors; direct metadata should be specific to the software itself.
- Use `references` for prior work that the research object implements, derives from, extends, or depends on. Use `preferred-citation` only to redirect citation to an equivalent scholarly description of the same research object (for example, a software paper or data descriptor authored by the creators of that object).
- Include version, repository, and commit hash, release, or SWHID.
- Cite publications describing implemented methods, algorithms or models separately.
- Explicitly state the relationship (e.g., "independent implementation of", "replication of", or "based on").
- Include version, persistent identifier (DOI preferred), repository URL, and commit hash where applicable.
- Follow the FORCE11 Software Citation Principles.

### Data Citation
- List only data contributors as dataset creators.
- Include dataset version or snapshot and repository.
- Cite publications describing or analyzing the dataset separately.
- Record processing and derivation history.

### Model Citation

- If citing a computational model specification, credit the model authors.
- If citing an implementation, credit the software authors separately.
- State whether the implementation reproduces, extends, or deviates from the original model.

## Gotchas

- treating FAIR as only metadata instead of stewardship, interoperability, preservation, and reuse
- mixing scientific reasoning into software engineering guidance
- letting `CITATION.cff` drift away from `codemeta.json`
- omitting dependency pins, environment details, or external service assumptions
- describing intended behavior instead of the implemented packaging or dissemination path
- leaving provenance implicit for generated files, data products, or archived artifacts
- drafting a DMP or SMP directly instead of deriving it from the FAIR Management Plan, letting the two diverge
