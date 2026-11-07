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

### Displaying revision identifiers

Use 12 hexadecimal characters for revision labels in human-facing summaries. For Git commits, use `git rev-parse --short=12 <revision>` so Git can extend the abbreviation when needed to distinguish objects currently in that repository. For skill content digests, show the algorithm and first 12 hexadecimal characters followed by an ellipsis, such as `sha256:8260f3a068e2…`. A digest prefix is a display label, not a uniqueness guarantee; lengthen it if displayed labels collide.

Keep full Git object IDs and complete digests in machine-readable provenance, stewardship, and evaluation records. Link a shortened label to its full identity when practical; never use it as the canonical identifier. This display convention does not change the compact skill-name commit trailers.

## Commit provenance and message review

Gate every consequential agent-created commit capable of affecting scientific claims. Judge the proposed diff and its dependencies, not its filename, commit label, or whether it directly edits a conclusion. Changes to assumptions, model logic, data handling, parameterization, experimental design, evidence, uncertainty, evaluation criteria, or interpretation can qualify. If the scientific consequence is unclear, surface that uncertainty for review rather than assuming the commit is harmless.

Finish the proposed changes and available checks, then present the changes, affected claims and dependent artifacts, relevant evidence and unresolved uncertainty, and complete commit message including trailers. Explicitly ask the user to approve that specific commit and wait. Review and commit one changeset at a time. Approval of message wording alone, blanket permission to commit, or acceptance of an upstream scientific decision does not approve an unreviewed consequential commit. Prior approval of the exact reviewed changes and message satisfies the gate; renewed approval is required if the commit's scope changes. Incorporate requested revisions and resolve remaining feedback before committing. Approval does not supply missing scientific evidence.

Routine commits preserving scientific meaning, such as editorial maintenance or a demonstrated behavior-preserving refactor, need no scientific commit gate. They still require authorization to commit. A mixed commit containing consequential changes is gated as a whole. The rule does not require commits for read-only runs or uncommitted drafts, and does not reopen scientific decisions already settled within their scope.

For the approval question, prefer the host agent's native structured input interface when it supports choices and free-text feedback. Offer **approve**, **revise**, and **defer** without requiring literal commands. Otherwise present those choices in plain text and accept a natural-language answer. Do not require a Codex-specific tool or mode: use only capabilities available in the current runtime. The interface must leave room for corrections and conditions; a preselected option, timeout, silence, or dismissed question is not approval. Continue independent work while awaiting a response, but do not create the pending consequential commit.

Keep the message concise. List actual contributing skills by source: skills from the OMF collection in `OMF-Skills`, other skills in `Agent-Skills`. Use stable, comma-separated names, omit empty trailers, and list each skill only once. Editing an OMF skill does not make the editing skill an OMF skill. For example:

```text
Revise watershed assumptions

OMF-Skills: omfa, fair
Agent-Skills: skill-creator, openai-docs
```

Put legitimate contributor names and emails in `Co-authored-by: Name <email>`; do not repeat emails or full revision hashes in skill trailers. Listing a skill as owner or routing to it does not establish participation. Subsequent runs consult artifact `contract_authority` and permitted contribution scope before editing; the trailer does not transfer ownership.

Keep exact executed skill revisions in the artifact provenance manifest, or the evaluation record for skill-evaluation work, using the existing identity conventions and `unknown` for unavailable values. Do not infer content identity from a timestamp: installed copies can lag releases or contain local edits. Record the revision actually executed, not a later edited copy. Stable names and compatibility commitments support continuity; performance claims remain scoped to observed model, runtime, suite, and inputs under the stewardship contract.

Use Git for commit authorship, commit time, file changes, and commit history; do not create a parallel commit log in `omf-artifacts/`. The artifact manifest retains ownership, activity-to-input/output relationships, consequential decisions, evidence, review state, and scientific dependencies that Git cannot supply. Preserve fields required by the current provenance schema: activity time and revision identity describe scientific work and are not necessarily the time or identity of the commit. Do not invent the pending commit's hash or attempt to embed it in its own manifest. No schema change is needed for the trailer convention.

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
