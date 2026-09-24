# OMF Skill Interface Contracts

A skill interface contract defines the observable behavior that lets independently developed skills compose safely. It governs decisions and effects, while `docs/artifact-contracts.md` governs shared persisted outputs.

## Contract vocabulary

| Element       | Required meaning                                                                               |
| ------------- | ---------------------------------------------------------------------------------------------- |
| Identity      | Skill name, repository source, release versioning policy, maintainer, and review status.       |
| Activation    | User intent that activates the skill and adjacent intent that does not.                        |
| Authority     | Decisions the skill may make, revise, or resolve.                                              |
| Preconditions | Required inputs, prior decisions, permissions, or environmental capabilities.                  |
| Effects       | Files, external state, execution, publication, or recommendations the skill may produce.       |
| Invariants    | Scientific, methodological, governance, or implementation commitments the skill must preserve. |
| Outputs       | Concrete deliverables and their artifact contracts.                                            |
| Handoff       | Target skill, reason, evidence passed, and whether the current skill stops or continues.       |
| Completion    | Conditions required before the skill may report success.                                       |
| Failure       | Behavior for missing, contradictory, stale, or unverifiable information.                       |
| Provenance    | Material activities and outputs that require lineage records.                                  |

## Identity and governance

OMF skills inherit the repository release version. An exact skill identity consists of:

1. skill name;
2. repository source;
3. repository release tag, when installed from a release;
4. exact Git revision when available, otherwise a content hash when practical;
5. maintainer, review status, reviewer, review date, review evidence, and cadence recorded in skill metadata.

Do not substitute a model or agent-runtime version for the skill revision. Record both when available because the skill supplies procedural knowledge while the model executes it.

Use **owns** only for decision or artifact-contract authority: the owner defines the contract and resolves conflicts. Use **is responsible for** for workflow duties that do not confer authority over another skill's decisions or artifacts. Use **contributes** for a scoped, permitted modification. Provenance represents ownership as `contract_authority` and lists only agents that actually participated in an activity.

## Authority and composition registry

| Skill         | Decision authority                                                                                                       | Primary effects                                                                                      | Required preservation and handoff                                                                                                                          |
| ------------- | ------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `omfa`        | Scientific framing, conceptual structure, assumptions, uncertainty, evaluation framing, ethics, and lifecycle readiness. | Creates and revises scientific artifacts directly under `omf-artifacts/`.                            | Preserve specialist-owned implementation, stewardship, and narrative artifacts; hand those changes to `omfb`, `fair`, or `document`.                       |
| `omfb`        | Implementation architecture, module mapping, parameters, verification planning, and implementation-introduced decisions. | Creates and revises `omf-artifacts/implementation/`.                                                 | Preserve OMFA scientific intent; return scientific contradictions and required conceptual changes to `omfa`.                                               |
| `fair`        | Stewardship, metadata coherence, provenance, reproducibility assessment, preservation, packaging, and citation.          | Creates and revises `omf-artifacts/fair/` and scoped metadata or provenance contributions elsewhere. | Preserve scientific claims and narrative meaning; hand substantive scientific or narrative changes to their owners.                                        |
| `document`    | Narrative framework, structure, and faithful communication of supplied scientific content.                               | Creates narrative outputs and `omf-artifacts/document/` intermediates.                               | Preserve authoritative scientific claims; expose source conflicts and hand scientific revision to `omfa`.                                                  |
| `peer-review` | Evidence-based assessment against review criteria.                                                                       | Produces findings, scores, and recommendations under `omf-artifacts/review/` when persisted.         | Do not silently remediate assessed artifacts; route fixes to the affected artifact's contract authority unless the user separately authorizes remediation. |
| `hpc`         | Slurm execution design and HPC resource planning.                                                                        | Produces Slurm scripts, resource plans, and submission guidance.                                     | Preserve experimental intent and parameter semantics; hand model-method or stewardship changes to `omfa` or `fair`.                                        |
| `ospool`      | HTCondor and OSPool execution design for distributed workloads.                                                          | Produces submit files, DAGs, transfer plans, and execution guidance.                                 | Preserve experimental intent, input identity, and result lineage; hand model-method or stewardship changes to `omfa` or `fair`.                            |

## Handoff protocol

A handoff must identify:

- the target skill and the authority it is expected to exercise;
- the triggering question, conflict, or missing prerequisite;
- relevant artifacts, evidence, assumptions, and unresolved decisions;
- whether the originating skill must stop, may continue independent work, or resumes after the target responds;
- the expected return artifact or decision.

Do not use a handoff to discard uncertainty or transfer an underspecified task. A receiving skill should reject or clarify a handoff that lacks a required prerequisite.

## Completion and failure

A skill may report completion only when its promised outputs exist, required validation has run, material changes have provenance, and required handoffs are resolved or explicitly left as user-visible follow-up. Missing or stale evidence should produce a qualified result, not a confident completion claim.

## Evaluation

Evaluate contracts through observable traces and filesystem effects. Measure correct activation, authority violations, permitted-effect success, prerequisite handling, invariant preservation, handoff completeness, false deferrals, provenance completeness, and premature completion claims. Repository JSON eval cases are executable specifications until a real-agent harness runs them; schema validation and the deterministic cross-skill router prove structure and routing expectations only, not behavioral conformance.
