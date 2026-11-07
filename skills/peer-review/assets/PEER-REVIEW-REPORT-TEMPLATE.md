# Peer Review Report Template

Use this template to produce standardized peer-review outputs for computational model readiness.

The skill's proposed recommendation follows required-criteria logic; the human reviewer owns the final outcome:

- Pass only if all three baseline review criteria pass.
- Fail if any required criterion is Partial or Fail.
- Withhold recommendation for insufficient evidence if no criterion is Partial or Fail and at least one is Not assessable.

---

# Peer Review Readiness Report

## Scope

- Submission type:
- Materials reviewed:
- Constraints and missing artifacts:
- Review status: Automated draft | Partially reviewed | Human-reviewed
- Review contributions: What automation examined and what the human reviewer examined:

Ratings below are proposals unless explicitly adopted in the reviewer judgments section.

## Criterion 1: Ease of Execution

- Rating: Pass | Partial | Fail | Not assessable
- Evidence:
- Required fixes:

## Criterion 2: Documentation Thoroughness

- Rating: Pass | Partial | Fail | Not assessable
- Evidence:
- Required fixes:

## Criterion 3: Code Quality

- Rating: Pass | Partial | Fail | Not assessable
- Evidence:
- Required fixes:

## Research Software Quality Indicators

| Indicator                                    | Status (Pass/Partial/Fail/Not assessable) | Evidence | Priority (Blocker/Major/Minor/Advisory) |
| -------------------------------------------- | ----------------------------------------- | -------- | --------------------------------------- |
| Software has documentation                   |                                           |          |                                         |
| Software has license                         |                                           |          |                                         |
| Software has citation metadata               |                                           |          |                                         |
| Software uses version control                |                                           |          |                                         |
| Software has releases or tags                |                                           |          |                                         |
| Software specifies requirements/dependencies |                                           |          |                                         |
| Software has tests                           |                                           |          |                                         |
| Software has CI workflows                    |                                           |          |                                         |
| Software provides issue tracking             |                                           |          |                                         |
| Metadata is descriptive and up to date       |                                           |          |                                         |

Notes:

- Missing tests and CI are Major but nonblocking unless they materially undermine a required criterion.

## Prioritized Findings

- Blockers:
- Major issues:
- Minor issues:
- Advisory improvements:

## Scientific Claim Support

State the model's purpose. For each central claim, give its source, a support rating (**Supported within tested scope | Qualified | Not supported by available evidence | Not assessable**), the evidence behind that rating, and its limits. Distinguish empirical inputs, assumptions, calibration targets, model results, and independent checks.

- Sensitivity analysis: Which uncertain inputs or model choices were varied, over what ranges, and did the main conclusion change? If none was needed, explain why. If needed but missing or too narrow, name the claim affected.
- Material concerns and next checks: State the possible effect on the conclusion, what remains uncertain, and what evidence would help resolve it.

Keep this assessment separate from the CoMSES readiness score. Say when evidence was unavailable, and distinguish questions from demonstrated flaws.

## Proposed CoMSES Readiness Recommendation

- Skill proposal: Pass | Fail | Withhold recommendation — insufficient evidence
- Rationale:
- Required criteria status summary (3/3 required):
- Minimum checklist to reach pass:
- Missing evidence and next check, if withheld:

## Reviewer Judgments

- Human reviewer's final outcome: Not yet supplied
- Reviewer's stated rationale and any difference from the skill proposal:

| Finding or judgment | Reviewer disposition (adopted/revised/deferred) | Reviewer's stated rationale and evidence examined | Unresolved disagreement or next check |
| --- | --- | --- | --- |
| | | | |

Leave dispositions unrecorded until the reviewer supplies them. Identify the scope of any adoption; a blanket approval does not demonstrate independent examination of each finding.

## Scope Boundary Reminder

The binary recommendation evaluates the three published CoMSES criteria. The scientific claim assessment reports support within the evidence reviewed; it is not a certification of scientific validity.
