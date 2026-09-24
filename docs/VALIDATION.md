# Skill Validation & Testing Guidelines

This document provides guidance for validating skills before submission and understanding the evaluation framework.

## Table of Contents

1. [Validation Layers](#validation-layers)
2. [Frontmatter Validation](#frontmatter-validation)
3. [Trigger Quality Checks](#trigger-quality-checks)
4. [Output Contract Verification](#output-contract-verification)
5. [Evaluation Strategy Template](#evaluation-strategy-template)
6. [Manual Testing](#manual-testing)

## Validation Layers

Skills undergo validation at multiple layers to check explicit criteria and
gather scoped evidence. These layers reduce uncertainty but cannot ensure
scientific quality or reliability.

| Layer               | Who                    | When             | Output                                        |
| ------------------- | ---------------------- | ---------------- | --------------------------------------------- |
| **Structural**      | Contributor            | Before PR        | Valid YAML, folder structure, required fields |
| **Trigger Quality** | Contributor + Reviewer | During PR review | Should-trigger/should-not-trigger assessment  |
| **Output Contract** | Contributor            | PR review        | Expected deliverables checklist               |
| **Evaluation**      | Contributor            | Before/during PR | Test case results and grading rubric          |
| **Integration**     | Maintainers            | Post-merge       | skills.sh listing, discoverability            |

## Best-Practice Alignment Checks

Align each skill with guidance from [Agent Skills Best Practices](https://agentskills.io/skill-creation/best-practices).

- [ ] Skill is grounded in real project expertise (task traces, runbooks, issues, fixes), not generic advice
- [ ] Skill scope is one coherent unit of work that composes with other skills
- [ ] `SKILL.md` is concise, with progressive disclosure into `references/` and clear load conditions
- [ ] Default approach/tool is explicit; alternatives are fallback-only
- [ ] Procedures are reusable methods, not one-off answers
- [ ] Gotchas section captures concrete, repeated failure patterns
- [ ] Output templates/checklists are included when format or sequencing is critical
- [ ] Validation loops are present for multi-step workflows
- [ ] Real execution traces were reviewed for wasted steps or ambiguity

---

## Frontmatter Validation

Every SKILL.md **must** include valid YAML frontmatter with required and optional fields.

### Required Fields

```yaml
---
name: kebab-case-skill-name # (required) lowercase, hyphens, no spaces
description: | # (required) complete trigger & outcome description
  Use this skill when...
license: MIT # (required)
---
```

### Validation Checklist

- [ ] Frontmatter enclosed in `---` markers (opening and closing)
- [ ] `name` field matches folder name exactly (e.g., `document`)
- [ ] `description` is present and ≥100 characters
- [ ] `description` includes at least 2 trigger phrases (e.g., "when you need...", "use when...")
- [ ] `description` specifies expected output types (e.g., "generates checklist", "produces script")
- [ ] Valid YAML syntax (no unescaped colons in values, proper indentation)
- [ ] `metadata.omf-stewardship` points to `stewardship.yaml`
- [ ] `stewardship.yaml` validates against the repository schema and its subject digest reproduces
- [ ] If including `compatibility`, it lists actual tool/version requirements
- [ ] Description avoids vague generic claims and includes domain-specific trigger context

### Canonical Check

Run `make validate`. Use `make validate-stewardship` only when iterating on a
stewardship record or the stewardship contract implementation.

Stewardship validation reports two different results:

- **Structural validity** means records conform to the schema, their subject
  manifests reproduce, and repository-local consistency checks pass.
- **Stewardship evidence coverage** summarizes the review, evaluation,
  maintenance, and epistemic-provenance evidence declared for the current skill
  subjects.

Stewardship evidence coverage is informational. A structurally valid record may
truthfully report no recorded review or evaluation evidence, and validation
does not establish scientific correctness, reviewer independence, or behavior
outside tested conditions.

### Calibrated Interpretation

Skill evaluation remains a dark art: results depend on the model, runtime,
grader, prompts, artifacts, and scientific context, and may never be fully
vettable. Report evaluation as observations under recorded conditions. A
passing result means only that named criteria were satisfied in those runs; it
does not certify the skill, guarantee future behavior, or establish scientific
correctness. Old review or evaluation dates are useful signals for renewed
scrutiny, but age alone does not prove that guidance is obsolete.

---

## Trigger Quality Checks

The `description` field is the primary mechanism for the coding agent to decide whether to use a skill. Weak description language leads to **under-triggering** (skill never used) or **over-triggering** (skill used inappropriately).

### Good Trigger Language ✅

```yaml
description: |
  Generates ODD+2 narrative documentation for agent-based models.

  Use this skill when you have model code and need to create publication-ready ODD+2 documentation,
  validate against the 23-point ODD+2 checklist, or improve existing ODD narrative.
  Triggers: "document my ABM", "generate ODD", "write model narrative", "publish my model", 
  "create ODD for my code".

  Expected output: Markdown ODD+2 sections, validation checklist with pass/fail items, 
  completion percentage report.
```

**Why it works:**

- Specific scenario ("agent-based models", not just "models")
- Concrete trigger phrases (users would actually say these)
- Clear output types (user knows what they'll get)

### Poor Trigger Language ❌

```yaml
description: |
  Help with model documentation.
```

**Why it fails:**

- Too generic ("documentation" applies to many unrelated tasks)
- No trigger phrases (the coding agent doesn't know when to use it)
- No output expectations (user unsure what to expect)

### Assessment Template

For each skill, verify:

| Criterion           | Check                                                                                            |
| ------------------- | ------------------------------------------------------------------------------------------------ |
| **Specificity**     | Is the domain narrower than "documentation" or "modeling"? Does it target a concrete pain point? |
| **Triggers**        | Would a researcher actually type these phrases? (Test: would you Google these search terms?)     |
| **False positives** | Could this skill be mistakenly activated for tangentially related tasks?                         |
| **Coverage**        | Are both narrow and broad interpretations of the task handled correctly?                         |

### Should-Trigger Examples

Create 5-10 prompts that **should** activate your skill:

```yaml
# For document
should_trigger:
  - "I have a Python ABM and need to document it following ODD+2 protocol"
  - "Generate an ODD narrative section for my agent-based model"
  - "Help me create publication-ready documentation for my computational model"
  - "Validate my existing ODD against the ODD+2 checklist"
  - "I'm publishing a paper on an ABM; need ODD narrative"
```

### Should-NOT-Trigger Examples

Create 3-5 prompts that **should NOT** activate your skill:

```yaml
# For document (anti-examples)
should_not_trigger:
  - "Create a timeline for my project milestones"
  - "Write API documentation for my Python library"
  - "Document the company org structure"
  - "Generate a README for my GitHub repository"
```

---

## Output Contract Verification

Before submission, verify that your skill produces the outputs it promises.

### Output Contract Template

For each skill, complete:

```markdown
## Output Contract

When activated, this skill produces:

### Primary Deliverables

- [ ] **Artifact 1:** Description, format (Markdown/JSON/script), typical size
- [ ] **Artifact 2:** Description, format, typical size
- [ ] **Artifact 3:** ...

### Secondary Artifacts

- [ ] Validation report or checklist (if applicable)
- [ ] Example output (if applicable)
- [ ] Estimated time to completion

### Success Criteria

- [ ] Criterion 1 (e.g., "Output includes all 23 ODD+2 checklist items")
- [ ] Criterion 2 (e.g., "Markdown is valid and renders without errors")
- [ ] Criterion 3 (e.g., "Script runs without environment errors")

### Failure Modes

- [ ] How does the skill handle missing inputs? (Error message? Graceful degradation?)
- [ ] What if the model code has no docstrings? (Does it ask? Infer?)
- [ ] What if parameters are incomplete? (Partial output? Request clarification?)
```

### Verification Checklist

- [ ] Run your skill 3-5 times with realistic test inputs
- [ ] Verify the output format matches what's promised
- [ ] Check that output is usable downstream (can a user take it directly to publication?)
- [ ] Verify error handling is clear (if something goes wrong, can user fix it?)
- [ ] Verify the skill provides a clear default tool/path (not an equal-choice menu)
- [ ] Verify deep detail is moved to `references/` or `assets/` with explicit load/use conditions
- [ ] Verify material artifact changes record the producing skill, inputs, activity, decisions, and review status without preserving raw prompts
- [ ] Verify handoffs name their target, reason, evidence, stop/continue behavior, and expected return

---

## Evaluation Strategy Template

Before submitting, define how your skill will be evaluated. Create a file `skills/<name>/evals.json`:

```json
{
  "skill_name": "document",
  "description": "Evaluation cases for ODD+2 narrative documentation skill",
  "evals": [
    {
      "id": 1,
      "type": "core",
      "prompt": "I have a Python ABM with Agent and Environment classes. Generate an ODD+2 narrative.",
      "should_trigger": true,
      "behavior": ["select the ODD+2 framework", "inspect supplied evidence"],
      "output": {
        "description": "ODD sections covering entities, state variables, processes, and parameters",
        "must_include": ["entities", "state variables", "processes"],
        "must_not_include": ["invented model behavior"]
      },
      "success_criteria": [
        "Output includes all three entities (Agent, Environment, Scheduler)",
        "State variables are listed with types and ranges",
        "ODD+2 checklist completion >= 80%"
      ]
    },
    {
      "id": 2,
      "type": "core",
      "prompt": "Create a timeline of project milestones",
      "should_trigger": false,
      "behavior": ["no skill activation"],
      "output": {
        "description": "Skill does not activate",
        "must_include": [],
        "must_not_include": []
      }
    },
    {
      "id": 3,
      "type": "adversarial",
      "prompt": "I have a complex Netlogo ABM with 50 agents and nested entity hierarchies. Generate ODD.",
      "should_trigger": true,
      "behavior": [
        "inspect entity hierarchy",
        "ask when abstractions are ambiguous"
      ],
      "output": {
        "description": "ODD with entity hierarchy explained",
        "must_include": ["entity hierarchy"],
        "must_not_include": ["invented subsystem abstractions"]
      },
      "failure_modes": ["hallucination", "under_trigger"],
      "success_criteria": [
        "Output structures entity hierarchy (e.g., Colony > Hive > Bee)",
        "Output explains state variable interactions",
        "Skill asks clarifying questions if abstractions are ambiguous, rather than guessing"
      ]
    }
  ]
}
```

### Evaluation Template Fields

- **id:** Unique test case number
- **type:** Optional classification: `core`, `adversarial`, `cross`, or `cross-adversarial`
- **prompt:** User query (should be realistic)
- **should_trigger:** Boolean indicating whether the skill should activate (required for `core` and `adversarial`)
- **behavior:** Observable process-level assertions
- **output:** Response-level `description`, `must_include`, and `must_not_include` assertions
- **success_criteria:** Named conditions to assess in a run; observed
  satisfaction is scoped to that run and environment
- **skills_expected:** Required for `cross` and `cross-adversarial`
- **failure_modes:** Required for `adversarial` and `cross-adversarial`
- **notes:** Optional reviewer notes

Note: Evals must validate against `evals/schema/schema.json`. Do not add custom fields unless the schema is updated.

### Running Evals

The current automated suite validates eval structure and runs a deterministic cross-skill routing smoke test. It does not execute skills or establish behavioral contract conformance. To gather behavioral evidence, run the skill with and without its instructions against fixture repositories and grade the resulting trace, filesystem diff, authority boundaries, provenance, privacy, failure behavior, and implied-surety risks.

Keep the evaluated object explicit. A skill eval grades the agent's behavior and
the task outputs it produces. Evidence about the skill belongs in evaluation
results and stewardship records; it must not be used as evidence about the
computational model or another generated artifact. Evidence about those task
artifacts likewise does not establish the skill's reliability.

After you've defined evals, run your skill manually against each test case and
record the model, runtime, inputs, grader, date, and relevant limitations:

1. **Setup:** Keep eval prompts in `skills/<name>/evals.json`; if you need fixtures for manual runs, store them under your skill folder (for example, `skills/<name>/assets/` or `skills/<name>/references/`).
2. **Execute:** Invoke your skill in your coding agent (Claude Code, Claude.ai, Cursor, Cline, or other AI coding environments) with the prompt
3. **Capture output:** Save the output (file, markdown, JSON, etc.)
4. **Grade:** Check against success criteria
   - ✅ Observed met: Criterion was satisfied in this run
   - ❌ Observed unmet: Criterion was not satisfied in this run (document why)
5. **Iterate:** If failures occur, improve the skill and re-run

Document results in a file `eval-results.md` at the root of your skill folder.

---

## Manual Testing

### Test Environment Setup

```bash
# Create a test workspace
mkdir -p /tmp/skill-test
cd /tmp/skill-test
git clone <your-skill-repo>
cd skills/your-skill-name
```

### Interactive Testing

In Claude Code or Claude.ai:

1. Mention your skill by name in the prompt
2. Provide a test input (model code, parameter spec, etc.)
3. Observe the output
4. Compare against expected behavior

**Example test interaction:**

```text
User: "Use the document skill to generate ODD for this simple ABM..."
[Paste model code]

Claude: "I'll generate ODD+2 documentation for your ABM..."
[Generates output]

User: "Check against the 23-point ODD+2 checklist. What's missing?"

Claude: "Here's the checklist feedback..."
```

### Latency & Context Concerns

Log performance metrics:

- **Time to first completion:** How long before output starts flowing?
- **Total execution time:** End-to-end for skill to complete
- **Context window usage:** Estimated tokens before/after skill invocation
- **Parallelizable steps:** Which parts could be async?

Document in `eval-results.md`:

```markdown
## Performance Metrics

- Time to first output: ~5 seconds (reading model code)
- Total execution time: ~30 seconds (generation + validation)
- Context window: ~4,000 tokens (within comfortable budget for most models)
- Bottleneck: ODD validation (looping through 23-point checklist)
```

---

## Submission Checklist

Before opening a PR, verify:

- [ ] Frontmatter is valid YAML with required fields
- [ ] Skill name matches folder name
- [ ] Description includes trigger phrases and expected outputs
- [ ] Tested against ≥5 should-trigger and ≥3 should-not-trigger prompts
- [ ] Output contract is clear and verifiable
- [ ] Evals are documented in `skills/<name>/evals.json` with success criteria
- [ ] Manual testing records whether named criteria were observed under stated conditions
- [ ] Evaluation reporting states limitations and avoids guarantees, certification, or universal correctness claims
- [ ] Execution traces were reviewed for false positives, missed triggers, and wasted steps
- [ ] No hardcoded paths, API keys, or user-specific settings
- [ ] License field is present and reasonable (MIT or declared alternative)
- [ ] README/docs sections align with repository conventions

---

## Questions?

See [CONTRIBUTING.md](../CONTRIBUTING.md) or open an issue on the repository.
