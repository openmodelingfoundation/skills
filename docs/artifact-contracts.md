# OMF Artifact Contracts

This registry defines authority and collaboration boundaries for shared files under `omf-artifacts/`. Ownership identifies the skill that controls an artifact's contract and resolves conflicts; it does not prohibit declared contributors from making scoped changes.

`docs/artifact-contracts.json` is the machine-readable authority projection used by validation. Keep it synchronized with the normative registry below.

## Shared rules

- Preserve the artifact's structure, provenance, and existing scientific commitments unless the contract permits changing them.
- Record the evidence and reason for a cross-skill contribution.
- Flag contradictions and stale dependencies rather than silently reconciling them.
- Route structural changes, conflicting evidence, and edits outside a declared contribution scope to the owner.
- Follow explicit user direction when it overrides a contract, and report the exception.
- Record every material create, revise, derive, transform, execute, validate, review, migrate, package, publish, or archive activity in `omf-artifacts/fair/provenance-manifest.json`; formatting-only changes do not require a new activity. Appending the record is part of the recorded transaction and is not a second provenance activity, so manifest maintenance does not recurse.

## Contract registry

| Artifact or namespace                                      | Owner         | Permitted contributions                                                                                                                                             | Protected decisions and route conditions                                                                                                                                                                   |
| ---------------------------------------------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `omf-artifacts/README.md`                                  | `omfa`        | Namespace owners may maintain entries and status for their own subtree.                                                                                             | Route changes to namespace conventions, lifecycle status semantics, or cross-namespace dependencies to `omfa`.                                                                                             |
| Scientific artifacts directly under `omf-artifacts/`       | `omfa`        | Method specialists may add traceable evidence to the relevant report or register. `fair` may update persistent identifiers and provenance links in `model-card.md`. | Do not reinterpret purpose, scope, conceptual structure, assumptions, research questions, or scientific conclusions. Route contradictions, schema changes, and substantive scientific revisions to `omfa`. |
| `omf-artifacts/implementation/`                            | `omfb`        | Verification, platform, and execution work may update evidence, status, and measured constraints in the applicable implementation artifact.                         | Do not change scientific intent inherited from OMFA artifacts. Route implementation architecture or contract changes to `omfb`; route required scientific changes to `omfa`.                               |
| `omf-artifacts/fair/`                                      | `fair`        | Other skills may add factual inventory entries, identifiers, repository locations, and provenance evidence.                                                         | Do not change FAIR assessments, stewardship commitments, preservation decisions, or management-plan structure. Route those changes and conflicting metadata to `fair`.                                     |
| `omf-artifacts/document/` and document-authored narratives | `document`    | OMFA artifacts provide authoritative scientific content; reviewers may provide traceable corrections and comments.                                                  | Do not silently change scientific claims to reconcile source conflicts. Route scientific changes to `omfa` and narrative structure or framework changes to `document`.                                     |
| `omf-artifacts/review/`                                    | `peer-review` | Artifact owners may add responses and remediation links without rewriting the original finding.                                                                     | Preserve review evidence, criterion, severity, and disposition history. Route remediation to the affected artifact owner and review-method changes to `peer-review`.                                       |

Scientific artifacts directly under `omf-artifacts/` include the model card, problem statement, research questions, conceptual model, assumptions, decision log, uncertainty register, analysis and evaluation reports, stakeholder and ethics records, limitations, ABM specification, and other OMFA lifecycle artifacts.

## Applying a contract

Before modifying an existing artifact:

1. Identify its owner and the active skill's role as owner, contributor, or consumer.
2. Compare the proposed edit with the permitted contribution scope.
3. If permitted, make the smallest traceable change and append its immutable activity, participating agents, evidence, decisions, authorization, and review assertion to the provenance manifest.
4. Otherwise, preserve the file, describe the proposed change and evidence, and route it to the owner. Record a review or rejected-decision activity only when one actually occurred.

Each material artifact revision is a new immutable entity whose identifier includes a revision, version, or content-hash component. Keep a stable `logical_id` across revisions and link the new entity to its predecessor with `wasRevisionOf`; never rewrite an earlier entity or activity. Before appending, deduplicate an exact retry by activity identifier. If the facts differ, append a new activity rather than changing history.

If the FAIR schema is unavailable, do not invent a partial manifest. Return a `provenance_handoff` containing the activity type and timestamp, generated artifact path and immutable revision identifier, stable logical identifier, contract authority and authorization mode, actual contributors and executor, inspected inputs, consequential decisions and evidence, review state, stale dependencies, skill source/release/revision, and privacy classification. Mark persistence incomplete and hand the record to `fair` for validation and append.
