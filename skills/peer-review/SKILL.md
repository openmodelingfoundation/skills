---
name: peer-review
description: |
  Evaluate computational model submissions for OMF peer review readiness using
  reproducibility, documentation, code quality, and research software engineering criteria,
  with a separate baseline appraisal of support for important scientific claims.

  Use this skill whenever a user asks to review a computational model, codebase, model release,
  or submission package for publication, reuse, or peer review. Trigger on phrases like:
  "peer review my model", "is this model submission ready", "review codebase quality",
  "check reproducibility", "review ODD documentation", "assess FAIR/research software quality".

  Expected output: structured peer review report with a binary recommendation
  limited to named baseline submission criteria, criterion-by-criterion findings,
  prioritized fixes, a separate assessment of scientific claim support, and an
  evidence-based checklist mapped to key EVERSE research software quality indicators.
license: MIT
compatibility: Works with Python, R, NetLogo, Julia, C/C++, and mixed-language model repositories
metadata:
  omf-stewardship: stewardship.yaml
---

# Computational Model Peer Review Skill

## Skill Contract

- **Activation:** Computational-model submission, release, repository, reproducibility, or research-software readiness review; not novelty adjudication or silent remediation.
- **Authority:** Review criteria, evidence assessment, scoring, finding severity, and readiness recommendation.
- **Preconditions:** An identifiable review target, declared review scope, available evidence, and explicit handling of inaccessible essentials.
- **Effects:** Produce findings and reports under `omf-artifacts/review/` when persisted; do not modify assessed artifacts unless remediation is separately authorized.
- **Invariants:** Preserve observed evidence, distinguish not-assessable from failure, apply the published scoring rule consistently, and never infer AI authorship from prose style.
- **Outputs:** Binary CoMSES-criteria recommendation, separate scientific claim assessment, criterion-level ratings, evidence, prioritized findings, and remediation routes.
- **Handoffs:** Route fixes to the affected artifact owner, passing the criterion, evidence, severity, and expected verification; continue independent review where possible.
- **Completion:** Every in-scope CoMSES criterion and central scientific claim has an evidence-based rating or an explicit not-assessable basis; the binary recommendation follows the three-criterion scoring rule.
- **Failure:** Issue a constrained review when evidence is missing and never infer a pass from absence of evidence.
- **Provenance:** Record persisted review reports and review assertions as immutable activities without rewriting earlier findings or dispositions.
- **Commits:** Before a commit that could affect scientific claims, present its changes, affected claims, evidence, uncertainty, and full message; request approval of that specific commit and wait. Review one commit at a time. Wording approval alone is insufficient; prior approval covers only unchanged reviewed changes and message. Routine meaning-preserving commits still need authorization but no scientific gate. Prefer native approve/revise/defer choices with free-text feedback; otherwise use plain text. Defaults or silence are not approval. List actual contributing OMF skills in `OMF-Skills` and other contributing skills in `Agent-Skills`, using comma-separated names and omitting empty trailers. Preserve legitimate `Co-authored-by` attribution. Keep exact executed revisions and ownership in provenance; do not duplicate Git history. This rule does not itself authorize a commit.

## When to Use This Skill

Use this skill when:

- A model author wants a pre-submission quality review before requesting formal peer review
- A reviewer needs a consistent rubric to assess model execution, documentation, and code quality
- A team wants to identify blockers to frictionless reuse of a model by third parties
- A repository needs a structured research software engineering quality assessment

Assess how well the available evidence supports the model's important scientific claims, including sensitivity to consequential assumptions where appropriate. Do not judge novelty or certify a model as scientifically valid. The binary recommendation covers only the three published CoMSES submission criteria; present scientific support separately.

## Key Inputs

Gather as many of these as available:

- Source code and repository structure
- Run instructions and dependency specifications
- Narrative model documentation (ODD or equivalent)
- Example input data and expected outputs
- Release metadata (license, citation, version, archive links)
- Tests, CI configuration, and issue tracker information
- Stated scientific claims, empirical sources, calibration choices, validation evidence, and sensitivity analyses

## Review Workflow

### Required Scoring Rule

Apply these rules before synthesizing any final decision:

- The three baseline review criteria are equally weighted and each is required:
  - Ease of Execution
  - Documentation Thoroughness
  - Code Quality
- Final decision is binary:
  - **Pass:** all three baseline review criteria are rated Pass
  - **Fail:** any one of the three baseline review criteria is rated Partial or Fail
- Research software quality indicators support evidence and prioritization, but do not override required-criteria failures.
- Scientific claim support is a separate assessment and does not change the three-criterion CoMSES score.

### 1. Scope and Submission Triage

1. Identify target artifact:
   - Repository only
   - Repository plus release package
   - Repository plus manuscript supplement
2. Confirm review scope:
   - Baseline OMF peer review readiness
   - Expanded RSE quality assessment
3. Record missing essentials up front (for example missing run instructions, missing docs, private dependencies).

Decision point:

- If core inputs are missing, continue with a constrained review and label all affected checks as not assessable.

Use `references/PEER-REVIEW-CHECKLIST.md` as the default rubric and evidence tracker throughout the review.

### 2. Evaluate Ease of Execution

Assess whether a third party can run the model with reasonable effort:

- Dependencies are identified and installable
- Environment setup is documented
- Input data dependencies are explicit
- Run commands are clear and complete
- Output artifacts can be generated without undocumented steps

Rate:

- Pass: runnable with minor effort
- Partial: runnable but requires interpretation or manual fixes
- Fail: cannot run from provided materials

### 3. Evaluate Documentation Thoroughness

Assess narrative documentation quality:

- Includes a standalone narrative document (not only inline comments)
- Uses ODD protocol or an equivalent model documentation framework
- Explains model purpose, entities, processes, assumptions, and parameters
- Includes enough detail for independent replication
- Uses figures, equations, or diagrams when needed for clarity

If ODD documentation is provided or expected, assess ODD structure and completeness against `../document/references/ODD-CHECKLIST.md`; route narrative revisions to `document`. If a non-ODD framework is used, evaluate it for equivalent coverage (purpose, entities/components, processes, assumptions, parameters, initialization, inputs/outputs, and stochasticity where relevant).

Decision point:

- If no narrative document exists, mark criterion as fail and provide a minimum documentation recovery plan.

### 4. Evaluate Code Quality

Assess maintainability and readability:

- Semantically meaningful names
- Logical structure and modularity
- Comments explain non-obvious logic, not trivial statements
- Low obvious technical debt (dead code, duplication, hidden globals, tangled control flow)
- No obvious hardcoded secrets or unsafe defaults

Report concrete evidence with file-level examples when possible.

### 5. Evaluate Research Software Quality Indicators

Use a focused indicator subset inspired by EVERSE guidance. Prefer evidence over assumptions.

Core indicators:

- Software has documentation
- Software has license
- Software has citation metadata
- Software uses version control
- Software has releases or tagged versions
- Software specifies requirements/dependencies
- Software has tests
- Software has CI workflows
- Software provides issue tracking
- Metadata is sufficiently descriptive and up to date

Optional advanced indicators:

- No critical vulnerabilities known
- No leaked credentials
- Lint/static-analysis hygiene
- Functional correctness measures where appropriate

For each indicator, mark:

- Pass
- Partial
- Fail
- Not assessable

Policy note:

- Tests and CI findings are **Major** quality signals but **nonblocking** for the binary pass/fail decision, unless they directly cause one of the three baseline review criteria to fail (for example, inability to execute reproducibly).

### 5a. Assess support for scientific claims

Identify the model's purpose and central scientific claims. For each, follow observed data through assumptions, calibration, code, outputs, and inference. Distinguish results built into rules from results that arise from the model. Check whether claimed validation uses evidence independent of calibration, whether unmeasured model variables are treated as observed traits, and whether conclusions stay within the model's stated scope. For conceptual models, assess support for their stated purpose without demanding empirical fit they do not claim.

Assess whether sensitivity analysis is adequate for the claims: does it vary the uncertain inputs or structural assumptions that could change the main conclusion, over justified ranges, with stochastic variation and interactions considered where relevant? A fixed-seed rerun, numerical convergence check, or sweep of a peripheral parameter cannot by itself establish robustness. If sensitivity analysis is unnecessary, explain why; if needed but missing or too narrow, state which claim remains weakly supported and what test would help. Match the depth of review to the model's purpose and the consequences of error.

For each central claim, rate support as **Supported within tested scope** (the evidence addresses the claim as stated), **Qualified** (support depends on important unresolved assumptions or narrow tests), **Not supported by available evidence** (the cited evidence does not establish the claim), or **Not assessable** (essential material is unavailable). Give the basis and limits of each rating. State material concerns, their possible effect on the inference, and what would resolve them. A concrete documentation defect may also affect the documentation rating. Keep claim ratings outside the CoMSES score and seek domain review when specialized expertise is needed. Apply the same scrutiny regardless of authorship; writing style alone establishes neither AI involvement nor error.

### 6. Synthesize Recommendation

Produce:

- CoMSES readiness recommendation: binary **Pass** or **Fail**
- Severity-ranked findings:
  - Blocker
  - Major
  - Minor
  - Advisory
- Actionable remediation plan with smallest viable next steps
- Separate scientific claim assessment from the CoMSES readiness decision

Decision logic:

- Return **Pass** only when all three baseline review criteria pass.
- Return **Fail** if any baseline review criterion is partial or fail.
- Keep tests and CI as Major nonblocking findings unless they materially affect a required criterion.

## Required Output Format

Always generate review outputs using:

- `assets/PEER-REVIEW-REPORT-TEMPLATE.md`

When a user asks for an author revision plan or response checklist, convert findings using:

- `assets/AUTHOR-RESPONSE-CHECKLIST-TEMPLATE.md`

## ⚠️ Gotchas

- Executable does not mean reproducible: passing run instructions can still fail reproducibility if versions and data provenance are unclear.
- Inline comments are not a substitute for narrative model documentation.
- Reviewers often over-focus style and under-focus runnability; keep execution and replication central.
- Missing tests should not automatically fail a model if execution and documentation are excellent, but should be flagged as risk.
- A CoMSES pass does not establish scientific support; assess the central claims separately and report limits of the evidence.

## Templates & Resources

- Primary rubric: `references/PEER-REVIEW-CHECKLIST.md`
- References companion guide: `references/README.md`
- Standard review report template: `assets/PEER-REVIEW-REPORT-TEMPLATE.md`
- Author response checklist template: `assets/AUTHOR-RESPONSE-CHECKLIST-TEMPLATE.md`
- Compressed review rubric snapshot: `assets/COMSES-REVIEWS-COMPRESSED.md`
- Compressed EVERSE indicator snapshot: `assets/EVERSE-INDICATORS-COMPRESSED.md`
- Repository-local refresh workflow: `.github/skills/update-skill/SKILL.md`
- ODD completeness checks: `../document/references/ODD-CHECKLIST.md` via the `document` skill when ODD is in scope
- Review criteria reference: https://www.comses.net/reviews/
- Scientific review context: https://www.jasss.org/23/2/7.html
- Sensitivity review context: https://www.epa.gov/sites/default/files/2015-04/documents/cred_guidance_0309.pdf
- EVERSE indicators reference: https://everse.software/indicators/website/indicators.html

## Example

Input:

- Public repository with Python model code, README, and sample data

Output:

- Structured report with criterion ratings
- Indicator table (pass/partial/fail/not assessable)
- Binary recommendation (Pass or Fail) with prioritized fixes
