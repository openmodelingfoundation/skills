# OMF Skill Stewardship Contract

Document status: implemented draft 0.4. Serialized contract version: `0.1`.

The document status tracks editorial review of this specification. The
serialized version is the value used by `stewardship.yaml` records and their
schema. Editorial revisions do not change that value unless serialization or
meaning changes incompatibly.

## Purpose

Treat each scientific skill as a maintained, reviewable knowledge artifact.
The contract makes stewardship claims inspectable without duplicating Git
history, releases, licenses, citations, review evidence, or evaluation output.

The contract follows calibrated transparency: it records what was reviewed or
evaluated, by whom, when, under which conditions, and with which limitations.
It does not certify scientific correctness or guarantee that a skill will work
in future or unobserved contexts. Skill evaluation remains a dark art and may
never be fully vettable across models, runtimes, graders, inputs, and scientific
uses.

This contract addresses [issue #16](https://github.com/openmodelingfoundation/skills/issues/16)
and extends the portable [Agent Skills specification](https://agentskills.io/specification).

Version 0.1 is deliberately maintainable by hand. It does not require identity
services, identifier registries, or specialized provenance tooling.

## Design rules

- Scope claims to reproducible behavior-affecting skill content.
- Keep the revision containing a claim distinct from the content it evaluates.
- Separate maintenance, development stability, distribution, review, and
  behavioral evaluation.
- Distinguish an activity, the record or result it produces, and any
  stewardship claim that maintainers accept from that evidence.
- Preserve historical claims by Git revision rather than mutable summaries.
- Trace consequential guidance by stable module identifier.
- Record evidence by reference and use `unknown` rather than inference.
- Keep activation context small.

## Value conventions

- Omit an optional field when it has no value.
- Use `unknown` only when a required value exists but cannot be determined.
- Use `[]` for a collection known to have no members.
- Do not use `null`, empty strings, or prose such as `none declared` as absence
  values.
- Exact-environment fields cannot be `unknown`; omit the environment or claim
  until the required exact value is available.

## Record location and discovery

The canonical record lives at `skills/<name>/stewardship.yaml`. Keeping it at
the skill root makes it available when a skill is distributed independently.
The Agent Skills specification permits arbitrary additional skill files.

`SKILL.md` contains only a string-valued pointer:

```yaml
metadata:
  omf-stewardship: stewardship.yaml
```

No review, evaluation, maintenance, or stability summary is duplicated in
frontmatter. This repository has no demonstrated client that needs those
mutable values during discovery. The Agent Skills specification defines
`license`, but it does not define repository, version, or citation fields.
Nonstandard identity and governance values belong in namespaced string
metadata or `stewardship.yaml`.

The minimal record shape is:

```yaml
schema-version: "0.1"
skill:
  name: example-skill
  repository: https://github.com/openmodelingfoundation/skills
subject-revision:
  algorithm: sha256-manifest-v1
  digest: "sha256:0000000000000000000000000000000000000000000000000000000000000000"
  manifest:
    - path: SKILL.md
      digest: "sha256:0000000000000000000000000000000000000000000000000000000000000000"
  include-overrides: []
  exclusions: []
maintenance:
  status: maintained
  stewards:
    - name: Open Modeling Foundation
      identifier: https://openmodelingfoundation.org/
      role: maintainer
development:
  stability: evolving
distribution:
  status: current
guidance-provenance: []
reviews:
  structural:
    claims: []
  domain:
    claims: []
evaluation:
  supported-environments: []
  claims: []
```

The arrays are deliberately empty until the corresponding review concludes or
an evaluation result is accepted. Ordinary skill activation does not modify
this record.

## Revision identity

### Subject revision

`subject-revision` identifies the behavior-affecting content evaluated by a
claim. It consists of a manifest of paths and file digests plus a digest of the
manifest. It does not identify the commit containing `stewardship.yaml`.

Determine the subject manifest using these rules:

1. Start with every regular file under the skill root. Paths are relative to
   the skill root and use `/` separators.
2. Include `SKILL.md` and, by default, all files under `references/`,
   `scripts/`, and `assets/`. Include any other file available to normal skill
   execution.
3. Implicitly exclude the root-relative paths `stewardship.yaml` and
   `evals.json`, plus every file below the root-relative directories `evals/`,
   `reviews/`, and `evaluation-results/`. These standard exclusions do not
   appear in the serialized `exclusions` array.
4. If a normally excluded file is used during normal skill execution, list it
   in `include-overrides`; it then affects the subject revision.
5. List every additional governance-only exclusion in `exclusions` with its
   path and reason. Unlisted nonstandard files are included by default.
6. Sort manifest paths by their UTF-8 byte sequence. Hash each file's raw
   bytes with SHA-256. Hash the concatenated sequence of each path, a NUL byte,
   its lowercase `sha256:<hex>` digest, and a newline to produce the manifest
   digest.
7. Never follow symbolic links. A link beneath an implicit or explicit
   exclusion is permitted because it is outside the subject. Reject any link
   that would otherwise be included, and reject an `include-overrides` entry
   that names a link. Version 0.1 does not hash link text because it can make
   standalone distributions resolve different content.
8. Normalize every `include-overrides` and `exclusions` path relative to the
   skill root. Reject absolute paths, `.` or `..` segments, and directory paths
   without a trailing `/`. `include-overrides` may reverse only an implicit
   exclusion; `exclusions` may remove only content included by default. Reject
   any direct, ancestor, or descendant overlap between the two arrays rather
   than applying precedence. `SKILL.md` cannot be excluded.

### Record revision

`record-revision` identifies the exact stewardship record without appearing
inside that record. In a Git checkout it is the Git revision whose tree
contains the applicable `stewardship.yaml`. Without Git history, a consumer
computes the SHA-256 digest of the exact `stewardship.yaml` bytes and uses that
as the record revision; release metadata may additionally state the source Git
revision. If neither value is available, `record-revision` is `unknown` and the
record cannot support a stable claim.

Updating only the stewardship record changes `record-revision` while leaving
`subject-revision` unchanged. This prevents content-digest recursion and Git
commit self-reference.

Existing skill or collection releases may use CalVer when it communicates
human-facing release time. Exact Git revisions or content digests remain
authoritative for review and evaluation subjects. Claims, activities, agents,
and individual stewardship records do not receive separate CalVer versions.

## State dimensions

Do not use a single lifecycle field for unrelated states.

### Maintenance status

| Status         | Meaning                                                                                    |
| -------------- | ------------------------------------------------------------------------------------------ |
| `maintained`   | An identified maintainer currently accepts stewardship responsibility.                     |
| `unmaintained` | No maintainer currently accepts that responsibility; historical records remain resolvable. |

### Development stability

| Status         | Meaning                                                                                                          |
| -------------- | ---------------------------------------------------------------------------------------------------------------- |
| `experimental` | Interfaces or guidance may change without migration support.                                                     |
| `evolving`     | Suitable for stated uses, but consequential changes remain expected.                                             |
| `stable`       | Development interfaces carry compatibility and migration expectations; this is not a scientific-validity status. |

### Distribution status

| Status       | Meaning                                                                             |
| ------------ | ----------------------------------------------------------------------------------- |
| `current`    | Available and recommended within stated limitations.                                |
| `deprecated` | Resolvable but not recommended for new use; migration information is provided.      |
| `retired`    | Deliberately removed from normal distribution; preserved for historical resolution. |

`unmaintained` describes an absence of stewardship. `retired` describes a
deliberate distribution decision. They are not interchangeable. The former
`maturity` field is removed because development stability now has defined,
operational semantics.

## Guidance provenance

A guidance module is the default provenance unit. Use a finer unit only when
it can be reviewed and revised independently. Each entry has an opaque, stable
`guidance-id`, a scope, whether it is consequential, its bases, and
applicability limitations.

The scope has `files`, an order-insensitive array of repository-relative
paths, and `sections`, an order-insensitive array of mappings containing a
`file` path and exact Markdown fragment `anchor`. Each basis has `type`, an evidence
reference, and a concise `rationale`. When no basis is available, use
`bases: []` and add a nonempty `provenance-gap` explanation.

Basis types are `standard`, `literature`, `community-practice`,
`expert-judgment`, and `incident-evidence`. An `expert-judgment` basis records
the attributable rationale for guidance. It does not constitute independent
domain-review evidence.

```yaml
guidance-provenance:
  - guidance-id: g-7f3a2c1d
    scope:
      files:
        - references/guidance/conceptual-modeling.md
      sections:
        - file: references/guidance/conceptual-modeling.md
          anchor: conceptual-modeling-workflow
    consequential: true
    bases:
      - type: standard
        evidence:
          location: https://example.org/method-standard
          revision: "2026-01-01"
        rationale: Defines the required methodological procedure.
    limitations: []
```

A domain-review claim identifies every covered module in
`scope.guidance-ids`. A stable skill requires all consequential
`guidance-provenance` entries to be covered by current accepted domain-review
claims.

## Shared structures

### Evidence reference

An evidence reference has:

- `location`: a repository-relative path or durable URI;
- optional `revision`: an exact source revision, version, or immutable
  snapshot; and
- optional `digest`: a content digest.

At least one of `revision` or `digest` is required unless `location` is itself
an immutable identifier. Stable-gate evidence must be both resolvable and
immutable. A relative `location` resolves from the skill root.

### Environment component reference

The required model and runtime entries and every tool or dependency entry have
`name` and an exact `version`. `source` is optional and identifies a package
registry, repository, or provider. Mutable aliases and version ranges are
invalid. `tools` and `dependencies` are required arrays; use `[]` when the
environment has none.

### Review scope

A review scope has three order-insensitive arrays:

- `guidance-ids` for guidance modules;
- `files` for repository-relative files; and
- `concerns` for named structural or methodological review concerns.

At least one array must be nonempty. Domain-review claims must have a nonempty
`guidance-ids` array. Structural-review claims must have a nonempty `files` or
`concerns` array.

### Acceptance criterion

Each acceptance criterion contains a stable `name` within its evaluation suite
and a human-readable or machine-evaluable `rule`. Criterion names do not serve
as global identifiers.

### Prior claim reference

A claim that changes an earlier claim includes `related-claims`. Each entry
contains a relation, the earlier claim's composite identity, and a reason:

```yaml
related-claims:
  - relation: supersedes
    repository: https://github.com/openmodelingfoundation/skills
    record-revision:
      method: git
      value: "4f3c2a1b0e9d8c7b6a5f43210fedcba987654321"
    record-path: skills/omfa/stewardship.yaml
    claim-type: domain-review
    evidence:
      location: reviews/domain-review-2026-06-01.md
      revision: "8888888888888888888888888888888888888888"
    reason: A later review covers the same modules and subject revision.
```

`record-revision.method` is `git` for an exact Git object name or `sha256` for
the digest of a standalone stewardship record. `claim-type` is
`structural-review`, `domain-review`, or `evaluation`.

Relations have distinct meanings:

- `corrects`: replaces a claim containing an error;
- `invalidates`: ends applicability without supplying replacement evidence;
- `supersedes`: replaces a claim with a newer applicable claim.

The earlier record remains unchanged. A claim is current only if no applicable
later claim corrects, invalidates, or supersedes it. Cross-repository claims use
the same structure; no standalone claim identifier is required.

A correcting or superseding entry is otherwise a complete claim of its normal
type. An invalidating entry has `outcome: invalidated`, `subject-revision`,
`recorded-at`, minimal `recorded-by` attribution, its own evidence reference,
and the prior reference in `related-claims`; it supplies no replacement review
or evaluation evidence and cannot satisfy a release gate.

## When stewardship claims are created

Normal skill activation does not create a stewardship review or evaluation
claim and does not create a stewardship activity. These records arise only
from deliberate stewardship work:

| Event                                  | Stewardship consequence                                                                                      |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| Structural or domain review begins     | No claim yet. Work remains review evidence in progress.                                                      |
| Review concludes                       | Record its review result and a scoped review claim.                                                          |
| Evaluation runs                        | Produce an evaluation result outside `stewardship.yaml`.                                                     |
| Maintainers accept a qualifying result | Record a scoped evaluation claim that references the result.                                                 |
| A user reports a failure               | Preserve it as potential incident evidence; do not automatically create a claim or change stewardship state. |

A review or evaluation activity is the work performed. Its review record or
evaluation result is evidence produced by that work. A stewardship claim is a
maintainer-accepted assertion, scoped to a subject revision, that cites the
evidence. Do not collapse these three concepts.

Version 0.1 does not assign standalone identifiers to claims or activities. A
claim is identified by repository, exact `record-revision`, record path, claim
type, and evidence reference. Globally unique identifiers may be added later
if cross-repository aggregation demonstrates a concrete need.

## Attribution

Represent maintainers, reviewers, and graders with only:

- `name`;
- one optional `identifier`; and
- `role` in the recorded work.

When present, the identifier is an ORCID, ROR, ATProto DID, GitHub profile,
institutional profile, or another stable public URI. Use `unknown` only where
an explicit identifier value is required but unavailable; otherwise omit the
optional field. It supports attribution, not authentication or identity
verification. Do not record credentials, unnecessary personal information,
provider-specific identity objects, or multiple identifiers for one
attribution entry.

```yaml
reviewers:
  - name: Example Researcher
    identifier: https://orcid.org/0000-0000-0000-0000
    role: domain reviewer
```

## Review claims

Structural and domain review claims are recorded separately. `reviewed` means
a concluded review record was accepted as evidence for its stated scope; it
does not mean the guidance was proven correct. `changes-requested` is a
distinct concluded outcome, not a reviewed claim. `not-reviewed` means no
applicable concluded review exists. `stale` means an earlier accepted review
no longer applies. An old review date is a reason for renewed scrutiny even
when no specific invalidating event is known.

An accepted claim becomes stale after `review-due`, when its subject changes
materially within scope, or when maintainers record another applicability
failure. Reviewer relationship and potential conflicts belong to the review
record. A role such as `self reviewer`, `internal peer reviewer`, `external
peer reviewer`, or `community reviewer` expresses the relationship. Identity,
role, affiliation, or expertise alone is not evidence of independence.
`conflicts` is a required array of concise conflict disclosures; use `[]` when
the review record affirmatively declares none.

```yaml
reviews:
  structural:
    claims: []
  domain:
    claims:
      - subject-revision: "sha256:0000000000000000000000000000000000000000000000000000000000000000"
        reviewed-at: "2026-09-02"
        review-due: "2027-09-02"
        reviewers:
          - name: Example Reviewer
            identifier: https://github.com/example-reviewer
            role: external peer reviewer
        conflicts: []
        scope:
          guidance-ids:
            - g-7f3a2c1d
          files: []
          concerns:
            - methodological correctness
        outcome: reviewed
        evidence:
          location: https://example.org/reviews/domain-review-2026-09-02
          digest: "sha256:5555555555555555555555555555555555555555555555555555555555555555"
        limitations: []
        related-claims: []
```

When a claim is corrected, invalidated, or superseded, add a new claim in a
later record revision and populate `related-claims` with the earlier composite
claim reference. Do not rewrite a published historical record.

## Evaluation results and claims

An evaluation result records what happened in a run. A qualifying evaluation
claim records that maintainers accept a particular result as evidence for a
subject revision and declared evaluation target. There is no singular latest
result, and evidence for one target does not supersede evidence for another.

`supported-environments` is the serialized version 0.1 field name for declared
evaluation targets. It does not mean the skill is guaranteed to behave
correctly in those environments. Likewise, `result.outcome: passed` means only
that the named acceptance criteria were observed as satisfied in the recorded
runs. It is not a certification of the skill or its scientific guidance.

Version 0.1 requires exact model, runtime, tool, and material dependency
versions or immutable snapshots in both evaluation evidence and declared
evaluation targets. Version ranges and mutable aliases such as `latest` are not
permitted. A future non-evidentiary compatibility declaration could express
broader maintainer intent, but version 0.1 does not define one.

```yaml
evaluation:
  supported-environments:
    - model:
        name: example-model
        version: "2026-08-15"
      runtime:
        name: example-runtime
        version: "1.4.2"
      tools: []
      dependencies: []
      required-suite-revision: "sha256:3333333333333333333333333333333333333333333333333333333333333333"
      acceptance-criteria:
        - name: required-assertions
          rule: all required assertions pass
        - name: baseline-improvement
          rule: pass rate exceeds the no-skill baseline
  claims:
    - subject-revision: "sha256:0000000000000000000000000000000000000000000000000000000000000000"
      suite-revision: "sha256:3333333333333333333333333333333333333333333333333333333333333333"
      environment:
        model:
          name: example-model
          version: "2026-08-15"
        runtime:
          name: example-runtime
          version: "1.4.2"
        tools: []
        dependencies: []
      acceptance-criteria:
        - name: required-assertions
          rule: all required assertions pass
        - name: baseline-improvement
          rule: pass rate exceeds the no-skill baseline
      repetitions: 5
      result:
        evaluated-at: "2026-09-02"
        outcome: passed
        evidence:
          location: https://example.org/evaluations/result-2026-09-02
          digest: "sha256:6666666666666666666666666666666666666666666666666666666666666666"
      accepted-at: "2026-09-03"
      accepted-by:
        - name: Example Maintainer
          identifier: https://github.com/example-maintainer
          role: maintainer
      limitations: []
      related-claims: []
```

A claim is current only while its subject, exact environment, suite, and
acceptance criteria match the corresponding declared evaluation target and
optional `valid-until` has not passed. Failed or inconclusive results remain
evaluation evidence but do not become qualifying claims unless the claim
explicitly limits what they support.

Environment matching uses these normalization rules:

- YAML mapping order is insignificant.
- Model and runtime names and versions must be exactly equal.
- `tools` and `dependencies` are sets. Sort each by `name`, `version`, then
  `source` with an omitted source sorting as the empty string; reject duplicate
  normalized entries.
- `acceptance-criteria` is a set. Sort by `name`, then `rule`; reject duplicate
  normalized entries.
- Empty arrays match only other empty arrays. Omission of a required array is
  invalid rather than equivalent to `[]`.

Two environments match only when their normalized model, runtime, tools, and
dependencies are equal. A claim matches a declared evaluation target only when
its normalized acceptance criteria and suite revision are also equal.

## Compatibility and migration

`compatibility.statement` defines what interfaces or behavior a stable skill
intends to preserve. Optional compatibility evidence uses an evidence
reference. `distribution.migration.statement` defines how consequential
changes are communicated and handled; its optional `guide` is an evidence
reference. These fields are optional for experimental and evolving skills and
required for stable skills.

```yaml
compatibility:
  statement: Preserve documented artifact paths within a stable release line.
distribution:
  status: current
  migration:
    statement: Document consequential changes and provide replacement paths.
```

Every record begins with `schema-version: "0.1"`. Version 0.1 uses compact
repository-local YAML validated by `schemas/skill-stewardship.schema.json`.
External vocabulary mappings remain documentation, not serialization
requirements.

## PROV conceptual alignment

The distinction among entities, activities, and agents follows W3C PROV at a
conceptual level. Skill revisions, review evidence, evaluation results, and
stewardship claims correspond to entities; reviews and evaluation runs to
activities; and maintainers, reviewers, and graders to agents. Version 0.1
does not require an explicit identifier for every conceptual PROV object or
require PROV serialization, RDF, JSON-LD, OWL, or PROV validation. The compact
YAML may be mapped to PROV later if an interoperability use case emerges.

## Triggers and transitions

| Event                                                         | Required action                                                                                                |
| ------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Behavior-affecting content changes                            | Produce a new subject revision; prior claims remain historical and become stale where their scope is affected. |
| Governance record or evidence changes only                    | Produce a new record revision; preserve the subject revision.                                                  |
| Consequential guidance changes                                | Reassess affected domain-review and evaluation coverage.                                                       |
| Normative source changes materially                           | Reassess affected modules and record stale claims when applicability changed.                                  |
| Evaluation-target model, runtime, tool, or dependency changes | Require a new exact environment-scoped evaluation result and accepted claim.                                   |
| User reports a failure                                        | Preserve potential incident evidence; do not automatically alter claims or status.                             |
| Maintainers confirm a critical or major incident              | Invalidate affected current claims immediately and open review or evaluation.                                  |
| Maintainers confirm a minor incident                          | Preserve incident evidence and escalate according to the review policy.                                        |
| Review due date passes                                        | Treat the affected review claim as stale.                                                                      |
| Skill is superseded                                           | Set distribution to `deprecated` and provide a successor or state explicitly that none exists.                 |
| Stewardship ceases                                            | Set maintenance to `unmaintained`; separately decide whether distribution becomes `deprecated` or `retired`.   |
| Skill is deliberately withdrawn                               | Set distribution to `retired`, record the rationale, and preserve historical resolution.                       |

Formatting changes to `SKILL.md` change its byte-level subject revision even
when maintainers judge them non-behavioral. Carrying a prior claim forward to
the new digest requires an explicit new claim; never silently reuse the old
subject revision.

## Stable development and compatibility gates

A skill may declare `development.stability: stable` only when the following
development, compatibility, and evidence-recording conditions hold at its
assessment date:

- maintenance is `maintained` and distribution is `current`;
- the subject manifest and digest reproduce;
- a current accepted structural-review claim covers the subject revision;
- every consequential guidance module is covered by a current accepted
  domain-review claim for the subject revision;
- every declared evaluation target has a current accepted evaluation claim
  for the exact subject, environment, suite, and acceptance criteria;
- required evidence resolves and no maintainer-confirmed critical or major
  incident invalidates an applicable claim; and
- compatibility and migration expectations are documented.

An empty `supported-environments` list cannot satisfy the stable gate. The field
contains evaluation targets, as defined above. These gates govern development
and compatibility status. They do not establish scientific validity, guarantee
skill behavior, or convert review and evaluation evidence into epistemic
certainty.

## Historical integrity

Git history or an immutable release preserves each claim in its original
record revision. A correction, invalidation, or superseding claim is added in a
later record revision and references the earlier evidence. Never rewrite or
delete evidence supporting a published claim; if evidence must be withdrawn,
record the withdrawal and retain enough metadata to resolve the historical
event.

## Validation boundary

The repository-local JSON Schema and semantic validator check local record
consistency, including:

- record structure, controlled values, and valid YAML;
- deterministic subject manifests, implicit and explicit exclusions, digests,
  and rejection of symbolic links from subject content;
- skill name and stewardship pointer consistency;
- structured evidence and composite prior-claim references;
- review scope, guidance coverage, outcomes, due dates, attribution, and
  conflicts;
- normalized exact-environment matching and acceptance criteria;
- stable compatibility and migration statements;
- provenance coverage for consequential guidance modules;
- mechanically assessable stable development and compatibility gates.

Validation establishes record consistency and evidence coverage, not
scientific correctness, authenticated identity, reviewer independence, or
performance beyond declared exact environments. The validator does not
dereference remote evidence or reconstruct claim history across Git revisions;
maintainers review those properties when accepting evidence or a stable
release.

The validator prints structural validity separately from an informational
stewardship-evidence summary. Empty review, evaluation, or
guidance-provenance evidence can therefore remain structurally valid without
being presented as a scientific-validity claim.

## Sources of truth

| Information                                | Canonical source                                       |
| ------------------------------------------ | ------------------------------------------------------ |
| Skill instructions and execution resources | Subject manifest files                                 |
| License                                    | Standard `license` frontmatter or bundled license file |
| Repository authorship and citation         | Repository `CITATION.cff`                              |
| Change history and record revision         | Git and releases                                       |
| Stewardship claims and subject revision    | `stewardship.yaml`                                     |
| Review and evaluation evidence             | Referenced immutable evidence records                  |
