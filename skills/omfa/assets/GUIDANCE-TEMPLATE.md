# <Topic> Guidance
<!--
Template for files in references/guidance/.
Copy this file, replace <Topic> and all bracketed prompts, then delete this
comment block and any optional sections that don't apply.

Heading depth is canonical: top-level title is `#`, all named sections below
are `##`. If a section needs internal structure, use `###` — do not promote
a subsection to `##` just because it has a lot of content (see
Consequential Analytical Choices below for an example of using `###` instead
of flattening into separate `##` sections, which is what caused
abm.md's structure to drift from this template).

Conformance language: this guidance inherits MUST / SHOULD from the parent
omfa SKILL.md. Use MUST when absence should be flagged as a deficiency
requiring justification, SHOULD when omission can be reasoned and accepted.
Tag each requirement inline (e.g. "Document the seed policy. [MUST]") rather
than leaving conformance level implicit — this was an open gap identified
in the uncertainty.md / deep-uncertainty.md review and should not recur in
new guidance files.

Guidance documents encode expert methodological reasoning, helping agents recognize when a methodology applies, make consequential analytical choices, select appropriate methods, and avoid common failure modes. They support decision-making rather than implementing workflows or duplicating specialist execution skills.

-->

## Purpose

State in one or two sentences when an agent should load this guidance and
what methodological question it helps answer. This doubles as the
trigger condition referenced by the routing table in the parent SKILL.md —
keep it specific enough to disambiguate from sibling guidance files.

---

## Core Principle

State the single central methodological principle this guidance enforces.
One paragraph. Everything else in the file should be traceable back to this
principle — if a later section doesn't serve it, it probably belongs in a
different guidance file.

---

## Decision Context

Define both directions explicitly, not just the positive case:

- **Use this guidance when:** [conditions under which it applies]
- **Do not use this guidance when:** [conditions under which a sibling
  guidance file applies instead]

If another guidance file addresses a closely related methodological question,
explicitly distinguish the boundary between them. When the relationship is
mutually exclusive (e.g. `uncertainty.md` / `deep-uncertainty.md`), state the relationship clearly; "This guidance and `<sibling>.md` are mutually exclusive entry points — use this one when [X], use `<sibling>.md` when [not X]." Do not just list the sibling under Routing and leave the disambiguation implicit.

---

## Consequential Analytical Choices <!-- [MUST] -->

List the methodological choices that substantially influence scientific
conclusions and therefore require documentation and justification, not
silent default selection. If the choices fall into natural groups, use
`###` subheadings rather than splitting into additional `##` sections. 

Document the rationale for each consequential choice and generate
reviewable intermediate artifacts where appropriate.

---

## Deliberate Gate Triggers <!-- optional -->

Identify only methodology-specific decisions that meet the parent `SKILL.md`
Deliberate Gates contract. Omit this section if it adds no specific guidance.
Do not repeat the procedure or turn `[MUST]` requirements into automatic gates.

---

## Method Selection <!-- optional -->
<!--
Include only when this guidance helps choose between competing analytical,
evaluation, or decision-support methods.

Example: deep-uncertainty.md's "Decision Support Approaches" chooses between
RDM, DAPP, adaptive management, and exploratory modeling.

uncertainty.md currently omits this section because its "Evaluation" section
describes complementary methods to combine rather than alternative methods
to choose among.

Do not use this section for modeling or representation decisions (e.g.,
which mechanisms, entities, or abstractions belong in an ABM). Those belong
under Consequential Analytical Choices or another guidance-specific heading.
-->

Describe the candidate methods or approaches, the conditions under which each is appropriate, and the tradeoffs between them. Recommend a default where one exists, justify that recommendation, and identify when another method would be preferable.

---

## Transparency <!-- [MUST] -->

What assumptions, limitations, and analytical decisions must be surfaced for review rather than left implicit?

Clearly distinguish:

- observed evidence
- inferred conclusions
- expert judgment
- unresolved uncertainty
- user-supplied assumptions

Document any consequential assumptions or defaults and generate intermediate artifacts as needed.

---

## Intermediate Artifacts

List reviewable artifacts this guidance expects to be produced or maintained. Use backtick-quoted filenames (e.g. `assumptions.md`) so they read as concrete deliverables, not abstract categories.

Intermediate artifacts should use predictable, semantic kebab-case filenames and be reusable by downstream skills where practical. Do not create snake_case variants of OMFA artifacts.

---

## Common Failure Patterns

List recurring methodological mistakes and anti-patterns specific to this
guidance's domain. Avoid generic process advice here — these should be
mistakes an agent would actually make without this file.

---

## Routing

Describe how this guidance relates to the rest of the guidance library and
specialist skills.

State:
- **Primary entry point** — when this guidance should be loaded instead of, or alongside, closely related guidance. Explicitly distinguish boundaries:
  if the relationship is mutually exclusive (e.g. `uncertainty.md` /
  `deep-uncertainty.md`), state both entry conditions; if it's complementary
  (e.g. `abm.md` alongside `uncertainty.md`), explain how the guidance should
  be combined.
- **Specialist execution skills** — skills that implement analyses or produce artifacts using this guidance.
- **Downstream consumer skills** — skills that consume the reasoning or artifacts produced by this guidance.

---

## Primary References

### <Foundational Concepts>

- Author (Year)

### <Operational Guidance>

- Author (Year)

### <Applied Practice>

- Author (Year)

See `references/REFERENCES.md` for complete citations.
