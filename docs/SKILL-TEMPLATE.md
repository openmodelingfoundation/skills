<!--
  OMF SKILL TEMPLATE
  ─────────────────────
  Copy this file to skills/<your-skill-name>/SKILL.md and fill in every
  placeholder marked with < >. Delete these HTML comments before submitting.

  Authoring rules (see AGENTS.md for full details):
  • description drives triggering — include concrete trigger phrases
  • SKILL.md body ≤ 500 lines / 5 000 tokens; move deep detail to references/
  • Tell the agent WHEN to load each references/ file, not just that they exist
  • One default approach; alternatives as fallbacks only
  • Gotchas must be in SKILL.md, not buried in references/
  • Every skill needs evals.json (≥3 should-trigger + ≥3 should-not-trigger)
-->

---

name: <kebab-case-name> # must match the folder name exactly
description: |
<One sentence summary of the concrete task this skill performs.>

Use this skill when <specific scenario — e.g., "you have model code and need
publication-ready ODD+2 documentation" — not just "you need documentation">.
Triggers: "<phrase 1>", "<phrase 2>", "<phrase 3>".

Expected output: <specific deliverables — e.g., "Markdown ODD sections,
23-point checklist report, and completion percentage">.
license: MIT

# compatibility: <e.g., "Python 3.10+, Git repository required">

metadata:
domain: <computational-modeling | publication | execution | analysis>
maturity: <alpha | beta | stable>
audience: <modelers | researchers | data-scientists | operators>
category: <documentation | quality-assurance | execution | publication>

---

# <Skill Display Name>

## When to Use This Skill

Use this skill when:

- <Concrete scenario 1 — who has what and needs what>
- <Concrete scenario 2>
- <Concrete scenario 3>

Do **not** use this skill when: <brief anti-use note if the boundary is non-obvious>.

## Key Inputs

Gather these before starting:

- **<Input 1>** — <type, format, where to find it>
- **<Input 2>** — <type, format>
- **Optional:** <input that improves output quality but is not required>

## Step-by-Step Instructions

<!--
  Be prescriptive for fragile or irreversible steps.
  Explain *why* for flexible steps so the agent makes good context-dependent calls.
  Use a validation loop after any step that produces output the next step depends on.
-->

### 1. <First major step>

<Imperative instructions. Pick one default tool/approach; mention alternatives only as fallbacks.>

### 2. <Second major step>

<Instructions.>

If validation fails at this step:

1. Review the error output.
2. Fix the issue.
3. Re-run before proceeding.

### 3. <Third major step — repeat as needed>

<Instructions.>

<!-- For batch or destructive steps, use plan → validate → execute: -->
<!-- 1. Generate a plan file listing all actions. -->
<!-- 2. Validate the plan against the source of truth. -->
<!-- 3. Only execute after validation passes. -->

## ⚠️ Gotchas

<!--
  List concrete, non-obvious corrections — things the agent WILL get wrong without
  being told. Generic advice ("handle errors") is not a gotcha.
  Add an entry every time you have to correct the agent mid-task.
-->

- **<Specific trap>:** <Correction — what to do instead and why.>
- **<Another trap>:** <Correction.>

## Templates & Resources

<!--
  Reference bundled files with explicit load conditions.
  "Read X when Y" beats "see references/ for details."
-->

- Read `references/<CHECKLIST>.md` when validating output against the standard.
- Use `assets/<TEMPLATE>.md` as the skeleton for the primary output artifact.
- Run `scripts/<validate>.py` after step 2 to check completeness before proceeding.

## Example

**Input:** <one-line description of a realistic minimal input>

**Output:** <one-line description of what the skill produces>

```text
<Short concrete snippet — a few lines of input code, config, or output
that makes the expected behavior concrete. Replace or extend this example
with something real when refining the skill.>
```

---

<!--
  CHECKLIST — delete this section before submitting a PR
  ──────────────────────────────────────────────────────
  □ Folder name matches name: field exactly
  □ description has ≥2 trigger phrases and lists expected output
  □ SKILL.md body ≤ 500 lines
  □ references/ files have explicit load conditions (not just "see references/")
  □ Gotchas section has ≥1 entry from real execution
  □ assets/ and scripts/ referenced are actually present in the skill folder
  □ evals.json has ≥3 should-trigger + ≥3 should-not-trigger cases
  □ No hardcoded paths, API keys, or personal settings
  □ Tested against ≥5 should-trigger prompts in a real coding agent session
  See CONTRIBUTING.md and docs/VALIDATION.md for full submission requirements.
-->
