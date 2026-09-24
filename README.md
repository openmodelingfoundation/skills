# OMF Skills Repository

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21938270.svg)](https://doi.org/10.5281/zenodo.21938270)

Computational modeling requires scientific and methodological judgment that extends beyond software engineering, but general-purpose AI coding agents do not consistently apply established modeling practices. OMF Skills encode community-developed modeling methodology, research software practices, and scientific workflows, helping computational modelers at any career stage build models that are transparent, reviewable, reproducible, and FAIR-aligned.

**Status**: `Alpha` — We are actively seeking community feedback to refine these workflows.

## Who this is for

This repository is designed for researchers, research software engineers, students, and practitioners at any career stage developing computational models.

## Repository Philosophy

Agent Skills capture specialized methodological knowledge that foundation models do not consistently possess. This repository follows a "shrink-to-fit" philosophy: as foundation models improve, skills are simplified or removed, preserving only frontier community knowledge, standards, workflows, and practices beyond models' reliable capabilities.

The ultimate goal of these Agent Skills is to provide community-informed guidance that sharpens expertise, automates rote and boilerplate work, and fosters critical thinking and deeper engagement with the modeling process through structured workflows that encode best practices.

## Quick Start

### Prerequisites

- A [coding-capable AI agent](https://agentskills.io/clients) (e.g., Cursor, Claude Code, Warp, OpenCode, etc.)
- Node.js LTS if using the Skills CLI (see [docs/install.md](docs/install.md))

### Install

#### Via Skills CLI (Recommended)

```bash
npx skills add openmodelingfoundation/skills
# or spell out the entire github repo
npx skills add https://github.com/openmodelingfoundation/skills
```

The `v2026.09` tag will be available after publication. For a pinned checkout,
see [manual installation](docs/install.md#install-a-specific-release-with-git). For projects using
older artifact paths, follow the [migration guide](docs/artifact-migration.md).

#### Via Coding Agent

Ask your agent: _"Install all skills from https://github.com/openmodelingfoundation/skills"_

### Verify Installation

Confirm your agent has loaded the skills:

```text
List all installed skills and summarize when each should be used.
```

## Example Workflow

> An animated walkthrough will be added here in a future release.

**Example:** `/omfa help me build a spatially explicit ABM of wildfire evacuation`

The `/omfa` skill guides you through a structured modeling lifecycle and produces:

1. **Conceptual model**: entities, processes, and system boundaries.
2. **Assumptions list**: explicit, reviewable modeling choices.
3. **Handoff readiness**: scientific prerequisites and unresolved decisions for OMFB.
4. **Recommendations**: when to use specialist skills for implementation, documentation, FAIR metadata, HPC orchestration, or peer-review readiness.

## Example omfa prompt

```markdown
/omfa Review this project and create or update its modeling artifacts.

Evidence: documentation, existing artifacts, source code, review comments.

Determine the project's lifecycle state and apply relevant OMFA
guidance. Create or update only the artifacts the evidence justifies. Where
evidence is missing, conflicting, or uncertain, say so explicitly rather than
inventing scientific commitments.

Store artifacts under `omf-artifacts/` using OMFA canonical filenames.

Report: what was created, updated, reviewed, or flagged; unresolved
deficiencies; recommended next steps.
```

## example omfb prompt

```markdown
/omfb Review this project and create or update its implementation artifacts.

Evidence: OMFA artifacts, existing implementation artifacts, source code,
tests, review comments.

Develop the implementation plan from the scientific artifacts and apply the
relevant OMFB guidance. Create or update only the artifacts the evidence
justifies. Where evidence is missing, conflicting, or uncertain, say so
explicitly rather than inventing implementation or scientific commitments.

Preserve traceability from scientific artifacts through implementation
decisions, source code, and verification.

Report: what was created, updated, reviewed, or flagged; unresolved
deficiencies; recommended next steps.
```

Once an implementation plan has been **carefully reviewed**, try:

`/omfb implement the reviewed implementation plan using the latest stable version of Python Mesa in src/python/`

or

`/omfb implement the reviewed implementation plan using NetLogo 7.0.4 in src/netlogo/`

or

`/omfb implement the reviewed implementation plan using Agents.jl v7.0.3 in src/julia/`

> [!NOTE]
> Coding-agent proficiency varies by language and framework, with widely used
> ecosystems such as Python often better represented than more specialized
> alternatives. Ask your coding agent to assess its proficiency with both your
> chosen language and framework. Lower confidence generally means more
> documentation checks, testing, review, and hands-on intervention during model
> development.

## Trusting genAI-generated code

Failure modes differ by language and ecosystem: some errors are caught early, while others compile or run and produce plausible but incorrect results. Review effort should scale with those failure modes and their observability.

Repository validation, review, and skill evaluations provide scoped evidence,
not guarantees of scientific correctness or future behavior. Skill evaluation
is still a dark art: outcomes depend on the model, runtime, grader, prompts,
artifacts, and scientific context, and may never be fully vettable. OMF aims for
the strongest practical rigor and transparency by recording those conditions,
observations, limitations, and unresolved uncertainties.

See [genAI code review guidance](docs/genai-code-review.md) for some programming language and framework specific risks and review guidance.

## Useful prompts

After completing an implementation session with a coding agent, it is often useful to run a cleanup pass. Here's a prebuilt prompt to do so, within the _same context window you did your work in_ so that the agent still has all of the work it did in its working memory:

```markdown
Run a final consistency and cleanup pass across code, tests, config, and docs.
Sync docs to the implemented state, remove stale/dead references, simplify duplication
introduced or exposed by this work, and fix low-risk inconsistencies. Flag larger
refactors separately. Run the full relevant validation.
```

For a second sanity check, open a fresh chat and context window for an adversarial pass:

```markdown
Review the current repository state as an independent maintainer. Identify correctness issues,
unnecessary complexity, stale documentation, inconsistent abstractions, and high-value simplifications.
Do not assume existing design choices are correct. Separate low-risk cleanup from larger architectural
recommendations.
```

For maximum safety, run these prompts using the `/plan` skill so the agent generates a detailed plan for you to verify before proceeding with any file level changes.

## Repository Structure

```text
.
├── skills/            # Published agent skills (e.g., omfa, omfb, document, fair)
├── docs/              # Contributor documentation
├── evals/             # Evaluation framework
├── scripts/           # Repository tooling
└── AGENTS.md          # Repository operating contract
```

## Contributing

We welcome new skills, improvements to existing workflows, and evaluation cases.
See the [documentation index](docs/README.md) to find current contracts and guides.

- **Contribution Workflow**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Authoring Reference**: [docs/agent-skills-creation-reference.md](docs/agent-skills-creation-reference.md)
- **New Skill Template**: [docs/SKILL-TEMPLATE.md](docs/SKILL-TEMPLATE.md)

## Roadmap

| Available                                      | Planned                             |
| :--------------------------------------------- | :---------------------------------- |
| OMF Assistant (Modeling Methodology) (`/omfa`) | Statistical Analysis                |
| OMF Builder (Model Implementation) (`/omfb`)   | Calibration and Validation          |
| Narrative Documentation (`/document`)          | Reproducibility Automation          |
| FAIR Metadata (`/fair`)                        | Domain-specific Modeling Templates  |
| HPC/HTC Orchestration (`/hpc`, `/ospool`)      | Visualization Standards             |
| Peer Review Readiness (`/peer-review`)         | Workflow Automation and Integration |

## Links & References

- **Open Modeling Foundation**: [openmodelingfoundation.org](https://www.openmodelingfoundation.org)
- **Agent Skills Specification**: [agentskills.io](https://agentskills.io)
- **Skills CLI**: [github.com/vercel-labs/skills](https://github.com/vercel-labs/skills)

## Citing

If you use these skills in research, cite the specific archived release and exact
revision used. [`CITATION.cff`](CITATION.cff) carries the all-versions Zenodo
concept DOI; the badge above points to an earlier archived version until the
September release receives its own DOI. The `v2026.09` publication date is pending.

## License

All skills in this repository are licensed under the [MIT License](LICENSE).
