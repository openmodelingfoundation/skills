# Install OMF Skills

OMF Skills give your coding agent guidance for computational modeling. Choose the installation method that fits how you work:

- **Skills CLI:** The quickest way to install skills into a project or your user account. Requires Node.js.
- **Your coding agent:** Ask an agent that supports [Agent Skills](https://agentskills.io/clients) to install them for you.
- **Git:** Use a specific release when you need to know exactly which version you used. This method does not require Node.js.

The skills available for installation are in the repository's `skills/` directory.

## Use the Skills CLI

From your project directory, run:

```bash
npx skills add openmodelingfoundation/skills
```

Follow the prompts to choose the skills and the agent that should use them. To install them for your user account instead, add `-g`:

```bash
npx skills add openmodelingfoundation/skills -g
```

Check which skills were installed and where. The [Skills CLI documentation](https://www.skills.sh/docs/cli) covers its options. These commands do not pin a particular OMF Skills release; use the Git method below if you need a fixed version.

## Ask your coding agent

You can give an agent that supports Agent Skills this request:

> Install the skills from `https://github.com/openmodelingfoundation/skills` for this project. Then list the skills you installed and where you put them.

Follow your agent's installation instructions if it needs a different request or location. Reload the agent if it does not find the new skills right away.

## Install a specific release with Git

Use this method when you need a fixed version or cannot use Node.js. The example below checks out `v2026.09` and links each published skill into `~/.agents/skills`. First check that `~/.agents/skills` is a location your agent reads before running these commands. If skills with the same names are already installed there, decide how to handle them first; the commands will not replace them.

```bash
git clone https://github.com/openmodelingfoundation/skills.git ~/.cache/omf-skills
git -C ~/.cache/omf-skills fetch --tags
git -C ~/.cache/omf-skills checkout --detach v2026.09
mkdir -p ~/.agents/skills
for d in ~/.cache/omf-skills/skills/*/; do
  [ -f "$d/SKILL.md" ] && ln -s "${d%/}" "$HOME/.agents/skills/$(basename "$d")"
done
```

Ask your agent to list its installed skills afterward. If it does not find them, reload it and check its documented skill location.

To use a later release, fetch tags and check out the new tag in `~/.cache/omf-skills`. Tag checkouts are detached, so `git pull` will not update it. Remove any links you created before deleting the clone.

## Record what you used in research

Cite the specific release and record the exact Git commit used. [`CITATION.cff`](../CITATION.cff) contains the Zenodo DOI for all versions; prefer a release specific DOI once if available. If the skills create or materially change files under `omf-artifacts/`, record the producing skill revision, inputs, decisions, review status, and observable agent or model version in `omf-artifacts/fair/provenance-manifest.json`. Most of the time this should happen automatically, but you may need to ask your agent to double check.

Here's an example audit prompt (liable to change as foundation models and coding agents evolve):

```markdown
Audit this repository for conformance with applicable Open Modeling Foundation (OMF) skills guidance.

Read the repository’s AGENTS.md and discover available OMF skills. Report which skills and versions or revisions you can verify. If the guidance is unavailable, report that limitation rather than inventing requirements.

Select skills based on the repository’s purpose, contents, and lifecycle stage. Read their instructions and relevant supporting references. Explain applicability briefly; do not treat every skill, optional practice, or template as mandatory.

Perform a read-only, evidence-based audit:

- Assess implementation and artifacts, not just whether files exist.
- Distinguish explicit requirements from recommendations and optional practices.
- Respect documented project decisions and identify conflicts with guidance explicitly.
- Check consistency across code, tests, documentation, citation metadata, and release practices where applicable.
- Separate confirmed gaps from items that need maintainer judgment or cannot be verified.
- Prefer proportionate improvements that reduce scientific or maintenance risk. Avoid unnecessary process, dependencies, and boilerplate.

Run existing, relevant, non-destructive validation commands when feasible. Record commands, exit statuses, and limitations. Do not modify files, install dependencies, access credentials, or publish anything.

Return:

1. A concise assessment with scope and applicability.
2. Prioritized findings, each including repository evidence, the exact guidance source, practical consequence, and smallest useful remediation.
3. Relevant checks that passed and remaining verification gaps.
4. A short proposed action list, separating necessary fixes from optional improvements.

Do not claim formal certification or full conformance beyond the evidence examined. If no material gaps are found, say so.
```
