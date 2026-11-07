# Peer Review Checklist for Computational Models

This checklist supports consistent, evidence-based peer review for computational model submissions.

Use compressed rubric snapshots for quick alignment checks:

- `../assets/COMSES-REVIEWS-COMPRESSED.md`
- `../assets/EVERSE-INDICATORS-COMPRESSED.md`
- `README.md`

For coordinated maintenance updates, use:

- `../../../.github/skills/update-skill/SKILL.md`

Use this output template for report consistency:

- `../assets/PEER-REVIEW-REPORT-TEMPLATE.md`

Use it with the required-criteria rule in `../SKILL.md`:

- Criterion 1: Ease of Execution (required)
- Criterion 2: Documentation Thoroughness (required)
- Criterion 3: Code Quality (required)

The skill proposes a recommendation; the human reviewer owns the final outcome:

- Pass: all three required criteria pass
- Fail: any required criterion is partial or fail
- Withhold recommendation — insufficient evidence: no required criterion is partial or fail, but at least one is not assessable. Identify the missing evidence and next check.

## Rating Scale

For each checklist item, assign one status:

- Pass
- Partial
- Fail
- Not assessable

Always provide evidence for every non-pass rating.

## Criterion 1: Ease of Execution (Required)

- [ ] Dependencies are explicitly listed and installable
- [ ] Environment setup instructions are complete and reproducible
- [ ] Input data dependencies are documented and accessible
- [ ] Commands to run the model are complete and unambiguous
- [ ] Expected outputs are described and reproducible
- [ ] Platform assumptions are declared (OS, compiler, hardware, container)

Suggested evidence:

- README installation and run sections
- Environment files (requirements.txt, environment.yml, Dockerfile, renv.lock, etc.)
- Example command transcripts or CI execution logs

## Criterion 2: Documentation Thoroughness (Required)

- [ ] Standalone narrative documentation exists (beyond inline comments)
- [ ] Documentation framework is ODD or equivalent
- [ ] Purpose and scope are clearly stated
- [ ] Entities/components and state are clearly defined
- [ ] Processes, scheduling, and assumptions are explained
- [ ] Parameters, initialization, inputs/outputs, and stochasticity are covered where relevant
- [ ] Documentation is sufficient for independent replication without reading all source code

ODD-specific note:

- If ODD documentation is in scope, use the `document` skill and `../../document/references/ODD-CHECKLIST.md` to assess completeness.
- If another framework is used, evaluate for equivalent coverage rather than format conformity alone.

## Criterion 3: Code Quality (Required)

- [ ] Naming is semantically meaningful and consistent
- [ ] Code organization is modular and understandable
- [ ] Comments and docstrings explain non-obvious logic
- [ ] Obvious technical debt is limited (dead code, duplication, hidden globals)
- [ ] Control flow complexity is manageable for maintenance and review
- [ ] No obvious hardcoded secrets or unsafe defaults

Suggested evidence:

- Representative code paths and modules
- Static analysis/lint findings if available
- Security scans or manual checks for secret leakage

## Research Software Quality Indicators (Supporting, Non-Gating)

Use these indicators to strengthen evidence and recommendations. They do not override required-criteria outcomes.

Core indicators:

- [ ] Software has documentation
- [ ] Software has license
- [ ] Software has citation metadata
- [ ] Software uses version control
- [ ] Software has releases or tags
- [ ] Software specifies requirements/dependencies
- [ ] Software has tests
- [ ] Software has CI workflows
- [ ] Software provides issue tracking
- [ ] Metadata is sufficiently descriptive and up to date

Policy constraints:

- Missing tests and missing CI are Major findings but nonblocking by default.
- Escalate only if absence of tests/CI materially undermines a required criterion (for example, execution claims cannot be reproduced).

Optional advanced indicators:

- [ ] No critical vulnerabilities known
- [ ] No leaked credentials
- [ ] Lint/static-analysis hygiene
- [ ] Functional correctness measures where applicable

## Scientific Claim Support (Separate from CoMSES Score)

Apply `../SKILL.md` section 5a to central claims. Record the purpose, evidence behind each claim, the role of assumptions and calibration, and whether the inference follows from the results. Assess sensitivity of the main conclusion to consequential uncertain inputs and structural choices when relevant; state why it is unnecessary otherwise. Rate claim support separately from the three CoMSES criteria and identify missing evidence or domain expertise.

## Final Recommendation Template

Use this final section in review reports:

- Skill proposal: Pass, Fail, or Withhold recommendation — insufficient evidence
- Human reviewer's final outcome and rationale: record only when supplied, separately from the proposal
- Required criteria status summary: X/3 criteria passed
- Rationale: concise evidence-based summary
- Minimum checklist to reach pass: highest-impact actions first

## Scope Boundary Reminder

The skill's proposed Pass/Fail recommendation follows the three published CoMSES criteria and is withheld when the scoring rule requires more evidence. The human reviewer owns the final outcome. Scientific claim support is an additional, separately reported assessment; neither a CoMSES pass nor a claim-support rating certifies scientific validity.
