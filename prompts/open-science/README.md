# Open science prompts

These standalone resources are maintained here, alongside OMF skills, but are
not Agent Skills and do not require skill installation. The public entry point
is the [Open Science Assistant resource page](https://www.openmodelingfoundation.org/resources/open-science-assistant/).

| File                                                         | Role                               | Current version |
| ------------------------------------------------------------ | ---------------------------------- | --------------- |
| [open-science-agent.md](open-science-agent.md)               | Research packaging assistant       | 0.11 draft      |
| [open-science-audit-report.md](open-science-audit-report.md) | Audit report template              | 0.11 draft      |
| [open-science-tutor.md](open-science-tutor.md)               | Practice tutor                     | 0.12 draft      |
| [open-science-sandbox.md](open-science-sandbox.md)           | Computational model sandbox runner | 0.1 draft       |

Packaging assistant and audit template version 0.11 clarify assessment scope,
tooling boundaries, stewardship and outcome-based adequacy. Tutor version 0.12
adds learning from existing strengths, transfer and maintenance checks, and
recognition of explicit authorized scientific decisions. It accompanies
packaging assistant version 0.11 and retains the practical Git instruction
introduced in tutor version 0.11.
The tutor requires the packaging assistant; audits use the report template.
The sandbox prompt remains independent. These are experimental instructions,
not certifications of scientific quality or execution security.

## Ownership and publication

This repository owns the prompt text, report template and associated behavioral
evaluations in [evals/](evals/README.md). The website owns explanations, starter
prompts, presentation and the dependency pin. Its build generates the four
downloads at their existing `/prompts/open-science-*.md` URLs from an explicit
Skills commit and checks their SHA-256 digests. Do not maintain website source
copies or track the latest branch automatically.

The [initial manual evaluation suite](evals/initial/README.md) defines thirteen
cases with synthetic fixtures. Its cases are not behavioral results; no model
execution or sandbox containment checks are included.

For an update, review the changes here, run `make validate`, and obtain the
required authorization before committing or publishing. After that exact commit
is retrievable, update the website's `data/open-science-source.json` revision
and file hashes together. Follow the website's `docs/open-science-prompts.md`
for local-source preview, pin updates and render checks. A draft version label
alone does not identify the exact bytes consumed or evaluated.

Repository validation includes style lint for these prompts; it does not execute
them or establish their behavioral quality. Use `make format` with
`FORMAT_FILES='prompts/open-science/*.md'` to format only these resources.
