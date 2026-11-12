# Contributing Skills to OMF

Thank you for contributing to this skills repository! This guide walks you through the process of creating, testing, and submitting skills for the OMF modeling guidance collection.

Reviewable artifacts are the interfaces between skills. Skills should communicate by creating and consuming well-defined artifacts rather than by duplicating reasoning or directly depending on one another.

Standalone prompts and report templates belong under `prompts/`, separately
from installable skills. See [open science resources](prompts/open-science/README.md)
for ownership and publication, and their [evaluation guidance](prompts/open-science/evals/README.md)
for exact tested-file identity. Skill frontmatter and routing-evaluation
requirements below apply to skills, not these standalone resources.

## Table of Contents

1. [Before You Start](#before-you-start)
2. [When to Create a New Skill](#when-to-create-a-new-skill)
3. [Skill Anatomy](#skill-anatomy)
4. [Skill Creation Workflow](#skill-creation-workflow)
5. [Naming Conventions](#naming-conventions)
6. [Writing Guidelines](#writing-guidelines)
7. [Frontmatter Specification](#frontmatter-specification)
8. [Testing Your Skill](#testing-your-skill)
9. [Submission Checklist](#submission-checklist)

## Before You Start

- Familiarize yourself with the [Agent Skills specification](https://agentskills.io) and its [best practices](https://agentskills.io/skill-creation/best-practices)
- Read [docs/agent-skills-creation-reference.md](docs/agent-skills-creation-reference.md) — the canonical authoring guide for this repository — and [AGENTS.md](AGENTS.md)
- Review existing skills in `skills/` to check for overlap and assess fit / appropriateness
- Use `/create-skill` if your coding agent provides it, or manually copy [docs/SKILL-TEMPLATE.md](docs/SKILL-TEMPLATE.md) into a new skill directory

## When to Create a New Skill

**Prefer extending an existing skill.** Create a new skill only when the new capability introduces a distinct area of expertise with a clear set of responsibilities and reviewable artifacts that no existing skill should author or maintain. Work through this before scaffolding anything — it determines whether you run `/create-skill`, open a PR against an existing skill's guidance, or add a standalone tool.

### Create a new skill only if it is responsible for one or more reviewable artifacts that no existing skill should author or maintain.

In addition, the capability should satisfy most of the following:

- represents an independent body of expert knowledge;
- can evolve independently of existing skills without routinely requiring changes to them;
- requires methodological reasoning that existing skills or foundation models do not reliably provide

Otherwise:

- **Add guidance** when the capability specializes reasoning within an existing skill substantively and without changing artifact responsibility.
- **Create a tool** when the capability performs deterministic inspection, extraction, validation, or transformation. Tools are orthogonal to skills and may be shared across multiple skills.
- **Extend the existing skill** when the capability falls within its existing artifact responsibilities.

### Rule of Thumb

| If you're adding...      | Prefer... |
| ------------------------ | --------- |
| New methodology          | Guidance  |
| New reviewable artifact  | Skill     |
| Deterministic automation | Tool      |

- **Skills** are responsible for reviewable artifacts and the reasoning that produce and maintain them.
- **Guidance** specializes reasoning within a skill.
- **Tools** perform deterministic operations and produce structured outputs consumed by skills.

Each reviewable artifact should have a single responsible skill, and each skill should have one primary responsibility.

### Examples

| Proposal           | Classification  | Reason                                                                                      |
| ------------------ | --------------- | ------------------------------------------------------------------------------------------- |
| `participatory.md` | Guidance (OMFA) | Specializes modeling methodology without changing artifact responsibility.                  |
| `model-extractor`  | Tool            | Deterministically produces a model inventory for multiple skills.                           |
| `Document`         | Skill           | Responsible for detailed narrative documentation artifacts.                                 |
| `FAIR`             | Skill           | Responsible for research software engineering artifacts, provenance, and release readiness. |

## Skill Anatomy

Each skill lives in its own folder with a required `SKILL.md` file:

```
your-skill-name/
├── SKILL.md                     (required: frontmatter + instructions)
├── scripts/                     (optional: Python/shell scripts for automation)
├── references/                  (optional: compressed, detailed docs, checklists, guides)
└── assets/                      (optional: templates, icons, example files)
```

Recommended semantic purpose of each component:

- `SKILL.md` → orchestration and enforcement language (when to trigger, required workflow steps, output constraints)
- `assets/` → reusable output artifacts (templates, starter files, structured output skeletons)
- `references/` → normative guidance / rules / compressed artifacts (checklists, standards mappings, policy summaries)
- `scripts/` → deterministic automation helpers (validation, generation, extraction)

Authoring guidance:

- Keep operational decision logic in `SKILL.md`; do not duplicate it across assets.
- Put reusable content the model can copy/fill into `assets/`.
- Put standards and rule-oriented material in `references/`.

See [AGENTS.md](AGENTS.md) and [docs/VALIDATION.md](docs/VALIDATION.md) for full guidance.

## Skill Creation Workflow

### Plan Your Skill

Answer these questions:

- **What problem does it solve?** (e.g., "Modelers struggle to document ODD+2 protocols manually")
- **When should the coding agent use it?** (e.g., "When user has model code and needs narrative documentation")
- **What does it take as input?** (e.g., Python/R model files, docstrings, parameter descriptions)
- **What reviewable artifacts is it responsible for?** (e.g., conceptual model, fair management plan)
- **What user-facing deliverables are derived from those artifacts?** (e.g., OMF standards-compliant narrative documentation, a reusable building block)
- **Are there dependencies?** What prerequisites must already exist? (technical dependencies, required artifacts, prior methodological decisions, etc.)

Confirm this belongs in a **new skill** rather than as guidance, a tool, or an extension of an existing skill — see [When to Create a New Skill](#when-to-create-a-new-skill).

Keep these principles in mind while planning and drafting:

- **Ground from real expertise**: start from real task runs, corrections, and project artifacts, not generic advice.
- **Scope coherently**: define one composable unit of work and keep the boundary clear.
- **Design for context efficiency**: keep `SKILL.md` concise, move deep detail into `references/`, and add explicit load conditions.
- **Prefer defaults over menus**: choose one default tool or approach and use alternatives only as fallbacks.

### Create Your Skill Folder

Run `/create-skill <name> — <one-sentence description>` in your coding agent if that command is available. It should scaffold `skills/<name>/SKILL.md` from [docs/SKILL-TEMPLATE.md](docs/SKILL-TEMPLATE.md) and create a starter `skills/<name>/evals.json`.

Alternatively, copy manually:

```bash
mkdir -p skills/your-skill-name
cp docs/SKILL-TEMPLATE.md skills/your-skill-name/SKILL.md
cp skills/document/evals.json skills/your-skill-name/evals.json
```

Then immediately rename `skill_name`, replace the copied prompts, and make sure the frontmatter `name:` matches the folder exactly.

### Write SKILL.md

See [Frontmatter Specification](#frontmatter-specification) and [Authoring Guidelines](#authoring-guidelines) below.

### Add Optional Resources

Add references/, assets/, and scripts/ as needed. Prefer keeping SKILL.md concise and moving reusable or detailed content into supporting resources.

### Test Your Skill

See [Testing Your Skill](#testing-your-skill).

Before opening a PR, also run the repository validators:

```bash
make validate
```

### Submit a Pull Request

Make sure your new skill is on an up-to-date feature branch in your fork.

Include:

- Your skill folder with SKILL.md and any bundled resources
- A description of what the skill does and when it triggers
- Results of your test runs (include prompts you tested against)
- Link to any relevant documentation or examples

## Naming Conventions

### Skill Folders & Names

- **Format:** `kebab-case`, lowercase, hyphens only
- **Length:** ≤ 48 characters (allows room for versioning)
- **Requirements:** Folder name MUST match the `name:` field in frontmatter
- **Examples:** ✅ `document`, `ospool`
- **Anti-patterns:** ❌ `ODD_Protocol_Narrative`, `document-v2`, `my_skill`

### Script Names in Bundled Resources

- **Format:** `snake_case.py` filenames for Python, `kebab-case.sh` or `word.sh` for shell scripts, `kebab-case.md` for intermediate reviewable artifacts
- **Examples:** `extract_metadata.py`, `validate-checklist.sh`, `generate_template.py`, `artifact-planning.md`

### Reference & Asset File Names

- **Format:** `UPPERCASE-TOPIC.md` for detailed references, `topic-guide.md` for guides
- **Examples:** `ODD-CHECKLIST.md`, `FAIR4RS-HANDBOOK.md`, `hpc-quickstart.md`

## Authoring Guidelines

### Principles

1. **Imperative tone:** Use concise, direct commands ("Generate the ODD narrative", not "The ODD narrative is generated")
2. **Progressive disclosure:** Start with brief overview; reference bundled docs for deep dives
3. **Progressive repetition:** If a step recurs, briefly repeat instructions rather than forcing the user to scroll back
4. **Concrete examples:** Include at least one realistic input/output (even if brief)
5. **Gotchas section:** Always include ⚠️ Gotchas with common failure modes

### Structure

A typical SKILL.md body includes:

```markdown
# Skill Name

## When to Use This Skill

- You have model code and need...
- When preparing for publication...
- If OSPool execution is required...

## Key Inputs

- Model source code files
- Parameter descriptions or config files
- Optional: docstrings with metadata

## Step-by-Step Instructions

1. Read the model code
2. Extract metadata (scicodes/somef-core, google/langextract)
3. Generate narrative following references/TEMPLATE.md
4. Validate against references/CHECKLIST.md

## ⚠️ Gotchas

- **Stochastic models:** If your model uses randomness, document any fixed random seeds
- **Large codebases:** Summarize into entity/subsystem/component abstractions first
- **Missing documentation:** Skill will ask clarifying questions rather than guess

## Templates & Resources

- See `references/ODD-CHECKLIST.md` for the 23-point validation list
- See `assets/odd-template.md` for narrative structure
- Use `scripts/validate-odd.py` to check for completeness

## Example

**Input:** A Python ABM with classes for Agent, Environment, and Scheduler
**Output:** An ODD narrative section covering entities/state variables for all three
```

### Dos and Don'ts

| Do                                                                  | Don't                                                        |
| ------------------------------------------------------------------- | ------------------------------------------------------------ |
| Include specific CLI examples                                       | Use vague instructions like "use the tool"                   |
| Reference scripts/resources as `scripts/name.py` (one level deep)   | Create nested utility folders that bury important files      |
| Use YAML for config templates                                       | Use INI or custom formats without strong justification       |
| Link to authoritative specs (arXiv, OSG docs, FAIR4RS)              | Reproduce entire external specs verbatim                     |
| Point out when a step might take time (e.g., "Docker build ~5 min") | Leave latency expectations to chance                         |
| Ask clarifying questions before guessing                            | Make unsupported assumptions (e.g., "all models use Python") |

## Frontmatter Specification

### Required Fields

```yaml
---
name: your-skill-name
description: |
  A complete description of what this skill does.

  Use this skill when you have model code and need...
  Triggers: "odd", "documentation", "publication"
  Expected output: [specific deliverables]
license: MIT
---
```

### Required Stewardship Pointer and Optional Compatibility

```yaml
---
name: your-skill-name
description: ...
license: MIT | Apache-2.0 | Proprietary
compatibility: Python 3.10+, git, Docker (optional)
metadata:
  omf-stewardship: stewardship.yaml
---
```

Record maintenance, stability, distribution, review, evaluation, and guidance
provenance in `stewardship.yaml`; do not duplicate mutable summaries in
frontmatter. See `docs/skill-stewardship-contract.md` and validate with
`make validate-stewardship`.

### Guidance for `description`

The description is your **primary triggering mechanism**. Make it:

- **Task-specific:** "ODD+2 narrative for agent-based models" not just "model documentation"
- **Keyword-rich:** Include trigger phrases users would naturally type
- **Outcome-focused:** Mention specific deliverables (e.g., "checklist", "narrative sections", "validation report")
- **Use the repository-preferred trigger phrase:** Start with `Use this skill when ...` so your description aligns with the validator heuristics and the existing skills.
- **Slightly pushy:** Coding agents tend to under-trigger skills. Emphasize when to use: "Use this skill when you mention ODD, ABM documentation, or model publication preparation"

## Testing Your Skill

Testing produces scoped observations, not certification. Skill behavior varies
with the model, runtime, grader, prompt, artifacts, and scientific context, and
evaluation methods remain a dark art that may never be fully vettable. Record
those conditions and limitations. Use pass/fail only for named criteria, and do
not describe a skill as scientifically correct or guaranteed because an
evaluation or review was recent or successful.

Prefer a concrete statement such as “On `<date>`, under
`<model/runtime/suite/inputs>`, criteria `<A–C>` were observed as satisfied.”
Report unevaluated in-scope criteria as `unknown` or `not assessed`, and label
relevant findings outside the rubric as exploratory observations. Strong claims
about the recorded evaluation process are appropriate; do not generalize them
into claims about scientific correctness or untested behavior. Attach claims to
the evaluated `subject-revision`; stewardship-only updates change the
`record-revision`. See the
[stewardship revision rules](docs/skill-stewardship-contract.md#revision-identity).

### Manual Testing

1. **Should-trigger cases** (5–10 prompts that SHOULD activate your skill):

   ```
   - "I need to document my ABM following ODD+2"
   - "Generate an ODD narrative for my model"
   - "Create publication-ready documentation for my code"
   ```

2. **Should-NOT-trigger cases** (3–5 negative prompts):

   ```
   - "Write a timeline for my project"
   - "Document my API endpoints"
   - "Generate a README file"
   ```

3. **Test each case** by mentioning the skill in a real coding agent session (Claude Code, Claude.ai, Cursor, Cline, or other AI coding agents)

### Creating an Evaluation Strategy

For each skill, include concrete test cases in `skills/<name>/evals.json`:

```json
{
  "skill_name": "document",
  "description": "Evaluation cases for ODD+2 narrative documentation skill",
  "evals": [
    {
      "id": 1,
      "type": "core",
      "prompt": "I have a Python ABM with Agent and Environment classes. Generate an ODD narrative.",
      "should_trigger": true,
      "behavior": ["select the ODD framework", "inspect supplied evidence"],
      "output": {
        "description": "ODD sections covering entities, state variables, and processes",
        "must_include": ["entities", "processes"],
        "must_not_include": ["invented model behavior"]
      }
    }
  ]
}
```

Notes:

- Individual skill evals live next to the skill, for example `skills/document/evals.json`.
- The repository schema accepts fields such as `type`, `should_trigger`, `behavior`, `output`, `success_criteria`, `skills_expected`, `failure_modes`, and `notes`.
- Do not add ad hoc fields unless you also update the schema in `evals/schema/schema.json`.
- Evaluation reports must identify their model, runtime, suite, inputs, grader,
  date, observed results, and limitations before supporting stewardship claims.

## Submission Checklist

Before submitting, verify:

- [ ] Confirmed the capability warrants a new skill (vs. guidance, a tool, or an extension) per [When to Create a New Skill](#when-to-create-a-new-skill)
- [ ] Skill folder name matches `name:` field in frontmatter
- [ ] Skill contract defines decision authority, preconditions, effects, invariants, handoffs, completion, failure behavior, and provenance obligations
- [ ] Skill metadata identifies its source, versioning policy, maintainer, review status, reviewer, review date, review evidence, and review cadence
- [ ] Frontmatter includes `name`, `description`, `license`, and required governance `metadata` (plus optional `compatibility`)
- [ ] Description includes triggers (`Use this skill when ...`) and expected outputs
- [ ] All script references use relative paths: `scripts/name.py` (not `./scripts/name.py`)
- [ ] README/CONTRIBUTING sections are consistent with repository guidelines
- [ ] `skills/<name>/evals.json` exists and validates against `evals/schema/schema.json`
- [ ] Tested skill against ≥5 should-trigger and ≥3 should-not-trigger prompts
- [ ] Reported evaluation conditions, observations, limitations, and unresolved uncertainty without implying certification
- [ ] No hardcoded paths or user-specific settings
- [ ] Scripts have clear usage documentation (docstrings, help text, or references/SCRIPT.md)
- [ ] No credentials, API keys, or personal data in examples
- [ ] License field is present in frontmatter

## [update-skill](.github/skills/update-skill)

Maintainer workflow for refreshing compressed artifacts, references, and eval expectations when upstream standards evolve.

Use cases:

- Refreshing rubric/indicator snapshots after upstream changes
- Keeping `SKILL.md`, `references`, `assets`, and `evals.json` synchronized in one PR
- Standardizing refresh PR notes for traceability

## Questions?

Please feel free to open an issue or start a discussion.

---

**Thanks for contributing to these OMF community computational modeling skills!** 🎉
