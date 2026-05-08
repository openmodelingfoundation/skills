# COMSES Skills Repository

Agent Skills for computational modelers: documentation, reproducibility, publication, and execution.

This repository hosts a curated collection of [Agent Skills](https://agentskills.io) designed to help researchers and developers develop and share computational models in the social and ecological sciences. Skills are reusable procedural workflows that enhance AI agents to accomplish specialized tasks.

## Quick Start

## Accessing a Coding Agent

These skills are designed for coding-capable AI agents that can:

- read skill instructions from `SKILL.md`
- execute shell commands
- inspect and modify repositories
- run local tools such as Python, Git, and Docker

Compatible environments include:

- [Visual Studio Code](https://code.visualstudio.com/)
- [vscodium](https://vscodium.com/) requires additional effort to get a coding agent set up like [GitHub Copilot](https://github.com/VSCodium/vscodium/discussions/1487)  
- [ChatGPT with coding tools enabled](https://chatgpt.com/codex/)
- [Claude Code](https://code.claude.com/docs/en/overview)
- [Cursor Agent](https://cursor.com/)
- (contributions welcome, this is a rapidly evolving space)

At minimum, your agent should support:
- filesystem access
- terminal execution
- multi-file editing

### Install Node.js LTS with nvm (WSL, macOS, Linux)

After you have access to a coding agent you'll want to set up Node.js on your system to use the standard `npx skills ...` to manage your skills collections. Agent skills are just a pile of files on your filesystem at the end of the day.

`npx skills ...` requires Node.js. We recommend using the node version manager `nvm` to flexibly install and manage Node versions.

Security best practices:

- Install only from the official [nvm-sh/nvm](https://github.com/nvm-sh/nvm/releases) repository.
- Pin the installer to a specific release tag instead of running an unpinned command.
- Review the installer script before executing it.
- Avoid `sudo npm -g ...`; use user-level installs with `nvm`.

1. Install prerequisites

WSL / Linux:

```bash
sudo apt update
sudo apt install -y curl ca-certificates git
```

macOS (with Homebrew):

```bash
brew install curl ca-certificates git
```

2. Install `nvm` from an official tagged release

Choose the latest release tag from: https://github.com/nvm-sh/nvm/releases

```bash
export NVM_VERSION="v0.40.4" # change to latest release
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash
```

3. Load `nvm` in your current shell or close and restart your shell

The following commands should be auto-appended to your shell profile (.bashrc / .zshrc / etc) but in case they aren't, make sure they are present:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

If needed, restart your terminal so your shell profile changes take effect.

4. Install and use the latest Node LTS

```bash
nvm install --lts
nvm alias default 'lts/*'
nvm use --lts
```

5. Verify toolchain

```bash
node -v
npm -v
npx -v
```

6. Keep Node LTS current

```bash
nvm install --lts --reinstall-packages-from=current
nvm use --lts
```

7. Continue with skills installation

```bash
npx skills add comses/skills
```

### Install a Skill

```bash
npx skills add comses/skills
```

Or install from GitHub directly:

```bash
npx skills add https://github.com/comses/skills
```

### Try the skills out

#### Open your modeling project in a coding agent

Examples: 

- Cursor: open the project folder and enable Agent mode
- Claude Code: run `claude` in the project root
- ChatGPT: open the repository in a coding-enabled workspace

#### Verify the agent can discover installed skills

Try:

```text
What skills are available from the comses/skills collection?
```
or:

```text
Read the installed skills and summarize when each should be used.
```

#### Run a small task

Generally the skills will always be triggered if you reference them by name, or you can use their associated slash command, e.g., 

Examples:

```text
/document generate ODD+2 documentation for this model.
```

or

```text
Use the document skill to generate ODD+2 documentation for this model.
```

```text
/peer-review evaluate this repository for reproducibility readiness
```

or

```text
Use the peer-review skill to evaluate this repository for reproducibility readiness.
```

etc.

Other examples:

- *"Set up an OSPool batch scaffolder for my sensitivity analysis"*
- *"Generate a FAIR4RS publication checklist for this model"*
- *"Generate a FAIR publication checklist for my model's output data"*

## Skills Overview

This repository currently includes five skills covering core computational modeling needs:

### 1. **document**
Generates and iteratively improves ODD+2 (Overview, Design Concepts, Details) documentation for agent-based models. Use when you have model code and need publication-ready narrative documentation that satisfies the 23-point ODD+2 checklist.

**Triggers:** "Document my model", "Generate ODD", "Write model narrative"

### 2. **fair4rs**
Creates FAIR4RS metadata with codemeta.json as canonical machine-readable metadata, citation files derived from codemeta.json, publication checklists, and EVERSE-aligned software management plans to ensure your computational artifacts are ready for archival and publication. Use when preparing models for Zenodo, arXiv, or disciplinary repositories.

**Triggers:** "Prepare for publication", "Generate publication checklist", "Create FAIR metadata"

### 3. **ospool**
Generates HTCondor job submission scripts and parameter sweep configurations for running models on the Open Science Grid (OSPool). Use for batch processing, large parameter sweeps, or distributed sensitivity analysis.

**Triggers:** "Run on OSPool", "Generate HTCondor batch script", "Set up parameter sweep"

### 4. **hpc**
Generates Slurm job scripts, job arrays, and resource allocation templates for running models on HPC systems. Use for multi-node simulations or large-scale experiments requiring direct HPC cluster access.

**Triggers:** "Run on HPC", "Generate Slurm script", "Set up batch array job"

### 5. **peer-review**
Evaluates computational model submissions for peer review readiness using required CoMSES criteria (ease of execution, documentation thoroughness, and code quality) plus supporting research software quality indicators inspired by EVERSE.

**Triggers:** "Peer review my model", "Is this model submission ready", "Review codebase quality", "Check reproducibility"

## Repository-Local Maintainer Skill

This repository also includes a local-only maintainer skill that is not part of the published `skills/` catalog:

### **update-skill** (`.github/skills/update-skill`)
Maintainer workflow for refreshing compressed artifacts, references, and eval expectations when upstream standards evolve.

Use cases:
- Refreshing rubric/indicator snapshots after upstream changes
- Keeping `SKILL.md`, `references`, `assets`, and `evals.json` synchronized in one PR
- Standardizing refresh PR notes for traceability

## Repository Structure

```
.
├── .github/
│   └── skills/
│       └── update-skill/        (repository-local maintainer skill)
│           ├── SKILL.md
│           ├── references/
│           │   └── REFRESH-WORKFLOW.md
│           └── assets/
│               └── REFRESH-PR-NOTE-TEMPLATE.md
├── AGENTS.md                    (repository-specific agent instructions)
├── README.md                    (this file)
├── CONTRIBUTING.md              (contribution guidelines)
├── LICENSE                      (MIT)
├── .gitignore
├── Makefile                     (validation shortcuts)
├── docs/                        (repository-level documentation)
│   ├── agent-skills-creation-reference.md
│   ├── roadmap.md
│   └── SKILL-TEMPLATE.md        (copy/fill template for new skills)
├── evals/                       (cross-skill evals and schema)
├── scripts/                     (validation and reporting helpers)
└── skills/                      (all skill folders)
    ├── document/
  │   ├── SKILL.md
  │   └── evals.json
    ├── fair4rs/
  │   ├── SKILL.md
  │   └── evals.json
    ├── ospool/
  │   ├── SKILL.md
  │   └── evals.json
    ├── hpc/
  │   ├── SKILL.md
  │   └── evals.json
    └── peer-review/
    ├── SKILL.md
    └── evals.json
```

## For Skill Authors

### Adding a New Skill

1. **Read** [AGENTS.md](AGENTS.md), [CONTRIBUTING.md](CONTRIBUTING.md), and [docs/agent-skills-creation-reference.md](docs/agent-skills-creation-reference.md) before drafting.
2. **Review** [Agent Skills best practices](https://agentskills.io/skill-creation/best-practices) before drafting.
3. **Ground from real expertise**: start from real task runs, corrections, and project artifacts, not generic advice.
4. **Scope coherently**: define one composable unit of work and keep the boundary clear.
5. **Design for context efficiency**: keep `SKILL.md` concise, move deep detail into `references/`, and add explicit load conditions.
6. **Prefer defaults over menus**: choose one default tool or approach and use alternatives only as fallbacks.
7. **Create the skill folder** with `/create-skill` if your agent supports it, or scaffold manually:

  ```bash
  mkdir -p skills/your-skill-name
  cp docs/SKILL-TEMPLATE.md skills/your-skill-name/SKILL.md
  cp skills/document/evals.json skills/your-skill-name/evals.json
  ```

8. **Fill in** the YAML frontmatter and markdown instructions, then immediately rename `skill_name`, replace the copied prompts, and ensure `name:` matches the folder exactly.
9. **Include optional resources** (`assets/`, `references/`, `scripts/`) as the workflow needs them.
10. **Refine with real execution**: test should-trigger and should-not-trigger prompts, review execution traces, and iterate.
11. **Run the repository validators** before opening a PR:

  ```bash
  python scripts/validate_individual_skills.py
  python scripts/validate_evals_schema.py
  python scripts/validate_cross_skills.py evals/cross-skills.json
  ```

12. **Submit** a pull request with the skill folder, its `evals.json`, and the prompts or checks you used to validate it.

### Skill Anatomy

Each skill lives in its own folder with a required `SKILL.md` file:

```
your-skill-name/
├── SKILL.md                     (required: frontmatter + instructions)
├── scripts/                     (optional: Python/shell scripts for automation)
├── references/                  (optional: compressed, detailed docs, checklists, guides)
└── assets/                      (optional: templates, icons, example files)
```

Recommended semantic purpose of each component:

- `SKILL.md` -> orchestration and enforcement language (when to trigger, required workflow steps, output constraints)
- `assets/` -> reusable output artifacts (templates, starter files, structured output skeletons)
- `references/` -> normative guidance / rules / compressed artifacts (checklists, standards mappings, policy summaries)
- `scripts/` -> deterministic automation helpers (validation, generation, extraction)

Authoring guidance:

- Keep operational decision logic in `SKILL.md`; do not duplicate it across assets.
- Put reusable content the model can copy/fill into `assets/`.
- Put standards and rule-oriented material in `references/`.

**Frontmatter (required fields):**
```yaml
---
name: your-skill-name
description: |
  Use this skill when...
  Triggers: "phrase 1", "phrase 2"
  Expected output: ...
license: MIT
---
```

**Optional fields:**
```yaml
compatibility: Tool/version requirements
metadata:
  domain: computational-modeling | documentation | publication | execution
  maturity: alpha | beta | stable
  audience: modelers | researchers | data-scientists
  category: documentation | quality-assurance | execution | publication
---
```

See [CONTRIBUTING.md](CONTRIBUTING.md), [AGENTS.md](AGENTS.md), and [docs/VALIDATION.md](docs/VALIDATION.md) for full guidance.

## Roadmap

See [docs/roadmap.md](docs/roadmap.md) for planned skills expanding into:
- **Reproducibility & containerization** (Docker, environment capture, snapshot verification)
- **Data & lineage tracking** (DVC integration, provenance metadata, parameter tracking)
- **Analysis & validation** (sensitivity analysis frameworks, unit testing templates, notebooks-to-workflows)
- **Integration & composability** (standard interchange formats, skill composition patterns)

## Links & References

- **Agent Skills specification**: [agentskills.io](https://agentskills.io)
- **Skills.sh leaderboard**: [skills.sh](https://skills.sh)
- **Agent Skills documentation**: [agentskills.io](https://agentskills.io)
- **Agent Skills CLI**: [github.com/vercel-labs/skills](https://github.com/vercel-labs/skills)
- **Example skills repository**: [github.com/anthropics/skills](https://github.com/anthropics/skills)

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- Contribution workflow
- Naming conventions and style guidance
- Review checklist
- Community contact

## License

All skills in this repository are licensed under the [MIT License](LICENSE) unless otherwise noted in individual `SKILL.md` files.
