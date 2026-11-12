# Open science behavioral evaluations

Keep evaluation cases, fixtures and results for these standalone prompts here,
separate from `skills/*/evals.json` and `evals/cross-skills.json`. Those files use
the skill-routing schema, including activation expectations that do not describe
an explicitly supplied standalone prompt.

The [initial manual suite](initial/README.md) now defines thirteen cases with
synthetic fixtures and named criteria. These are proposed behavioral checks,
not observed results. Its sandbox cases cover inspection, planning and stopping
only; model execution remains outside the initial suite.

The suite defines baseline comparisons and an independent two-grader pilot.
No behavioral runs or grader-agreement results are claimed.

When adding an evaluation, keep cases and fixtures in a named suite directory
and recorded observations in its `results/` directory. Define the named criteria
before running it. Each result must record:

- The full Skills Git commit containing the tested prompts, and the SHA-256
  digest and repository-relative path of each file actually supplied, including
  companion prompts and templates. For uncommitted inputs, label the source as
  a local modified tree and retain the exact tested files with their hashes;
  do not claim the base commit contains them.
- The suite revision and exact cases, fixtures, user inputs and expected
  criteria, including externally retrieved companion content or unavailable
  dependencies. Preserve the actual supplied instructions and their order.
- Date, evaluator, model identity, runtime/tool configuration, grader and
  procedure; transcripts or evidence references, observed actions and outputs.
- Criterion-specific observations, failures, unknown or unassessed criteria
  with reasons, and limits on generalizing to other contexts. Identify any
  baseline comparison and its conditions; do not imply one was run if absent.

Keep the evaluated prompt identity separate from the commit that records its
results. Updating a report does not change the bytes it describes. Version
labels such as `0.10 draft` and dates alone are insufficient identifiers.

Behavioral runs are separate from `make validate`, which does not execute
suites here. Document the runner and explicit invocation
with each future suite. Do not reuse skill-routing assertions as evidence that
these prompts behave correctly. A sandbox adversarial suite would need its
own bounded execution environment and evidence, beyond the initial manual suite.
