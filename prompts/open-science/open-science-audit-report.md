# Open Science Audit Report Template

Version: 0.11 draft
Status: Experimental guidance; not an OMF certification or scoring standard

Use with the Open Science Research Packaging Assistant:
<https://www.openmodelingfoundation.org/prompts/open-science-agent.md>

Produce an actionable, evidence-based audit of a publication, computational
model, dataset or research package. Keep the numbered sections below for
consistency; scale their detail to the research and assessed purpose. Replace
the instructions and placeholders with findings. Do not create empty artifacts,
invent deficiencies or recommend work just to fill the template.
Retain all seven headings, but allow a one-line section where nothing
consequential needs discussion. Omit unused tables and placeholder rows.

Distinguish an obligation established by a cited policy, a requirement for the
assessed purpose, and an optional good practice. Do not impose software
requirements on work without executable code. Restricted access can be
appropriate; assess the documented conditions and any applicable access route.
Distinguish an author's stated reason for restriction from records inspected
and checks performed. Reporting that reason does not establish that consent
records were examined or that the restriction's sufficiency was verified.

## 1. Verdict and scope

- **Target:** title, authors, publication/release identifier and exact version.
- **Perspective:** external reader or internal author/collaborator; available
  evidence and authority to make changes.
- **Assessed purpose:** for example, understanding methods, inspecting evidence,
  running a model, reproducing named results or adapting code/data.
- **Verdict:** adequate, partly adequate or not adequate **for that purpose**;
  use not assessable where essential evidence is inaccessible.
- **Basis:** what works, consequential limitations, and the next useful action
  if one is warranted. If adequate, explain why and say no correction is needed.
- **Coverage:** materials inspected, audit date, guidance/template versions,
  exclusions and access or execution limitations. Distinguish an artifact not
  found in the supplied materials from one known not to exist.

Do not replace this verdict with a submission-eligibility grade, aggregate
FAIR score or claim of scientific validity. If a formal review was requested,
report its named rubric and decision separately from this audit.

Define adequacy by the outcome supported. For qualitative work, transparency
may enable examination of how evidence supports an interpretation without
requiring another analyst to derive identical themes. Assess that stated
outcome rather than imposing computational repetition as a universal criterion.

## 2. Supporting-material inventory and access

Follow the publication's availability statements, supplement links and
repository records. Inspect downloadable contents where accessible, rather
than inferring availability from a landing page or badge. Record code and data
separately, including data bundled with code or inside supplements.

| Material and role                                                                                                    | Exact version and source                                                           | Permanent identifier/URL and access conditions                                                                      | What it enables; limitations                  |
| -------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| [Code, inputs, processed data, qualitative coding, documentation, experiments, outputs or other applicable material] | [Release, path, supplement page/table; distinguish inspected from referenced-only] | [DOI, accession or stable URL; public, managed, restricted, unavailable or unknown; citation and applicable rights] | [Concrete supported task and any scope limit] |

Where underlying data exist, identify their persistent record and access
arrangements, including bundled or managed-access materials. Where release
is inappropriate, assess the available explanation and any appropriate
metadata or custodian route. Mark not applicable where no separate dataset
is indicated. Do not infer that a public access route must exist.

Distinguish complete, partial, unavailable and unknown coverage, and label
restrictions as documented or independently checked, stating the evidence for
any check. A paper DOI or availability statement alone does not establish that
inputs are deposited. Do not demand a separate data DOI when an existing
deposit containing the inputs serves the assessed purpose.

## 3. Assessment of open-science practices

Use **met, partial, missing, unknown or not applicable**, with evidence and a
brief consequence for each applicable area. These are descriptive statuses,
not an automatic pass/fail calculation. Inaccessibility is not proof of absence.

| Area                                     | Status   | Evidence and implication for the assessed purpose                                                                                    |
| ---------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Findability and preservation             | [Status] | [Publication links, persistent access, identifiable code/data versions]                                                              |
| Access, attribution and reuse conditions | [Status] | [Applicable access arrangements, citation, component-specific rights; stated restriction reasons and any checks performed]           |
| Data interpretation and provenance       | [Status] | [Sources, collection context, field/code definitions, units, exclusions, transformations and missing values]                         |
| Code inspection and execution            | [Status] | [Available source, dependencies/runtime, commands, inputs and consequential implementation issues]                                   |
| Methods and result traceability          | [Status] | [Inputs → computational or manual analysis → named outputs; settings, seeds/replications or qualitative coding rules where relevant] |
| Verification and claim boundaries        | [Status] | [Checks and robustness evidence relevant to the claims; distinguish calibration from independent validation]                         |

Explain important strengths as well as limits. Neither a badge nor successful
execution proves result reproduction. Missing CI, containers, a development
repository or a preferred folder layout is not by itself a consequential gap.

## 4. Prioritized findings and actions

Include only evidence-backed findings. If no consequential gaps were found,
state that and omit unnecessary action rows. Prioritize by benefit and effort.

| ID and priority                                                                          | Evidence and observed issue                                               | Why it matters                           | Smallest useful action                                             | Effort, responsible role and completion evidence            |
| ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ---------------------------------------- | ------------------------------------------------------------------ | ----------------------------------------------------------- |
| [F1; necessary correction, necessary for a named reuse purpose, or optional enhancement] | [Exact file/line, section, page/table or URL; label inference explicitly] | [Specific affected task, result or user] | [Concrete change or author decision; preserve published originals] | [Rough effort, who can resolve it, and an observable check] |

Keep unknowns separate from demonstrated defects. Explain when correcting code
or analysis could change the scientific result; do not silently make that change.
Do not equate absent provenance records with evidence that the data are wrong,
or an ambiguous rights statement with proven unauthorized use.

## 5. Verification record

| Check and status                                                      | Exact inputs/version, environment and procedure                 | Expected result/acceptance criterion      | Observed result and limits                                         |
| --------------------------------------------------------------------- | --------------------------------------------------------------- | ----------------------------------------- | ------------------------------------------------------------------ |
| [Executed, statically inspected, proposed, blocked or not applicable] | [Command or manual procedure; parameters and seeds if relevant] | [Declared before interpreting the result] | [Evidence/output reference; what this does and does not establish] |

Identify publication results actually reproduced, if any. Distinguish loading
files, a smoke run, deterministic repetition, numerical agreement and independent
validation. Record new audit settings as new choices, not recovered author settings.
State which material claims remain unassessed and what would enable assessment.

## 6. Questions and decisions for the authors or custodians

List only questions requiring their knowledge or authority. For each, identify:

- The unresolved fact or decision and the evidence that raised it.
- Which finding, reuse task or verification it affects.
- Who can answer or authorize it, and what information or approval would resolve it.

Separate requests for missing history from permission to process, redistribute,
change a scientific interpretation or publish a corrected version. Do not seek
permission again for ordinary work the user has already authorized.

## 7. Worked example or reason for no change

When requested and worthwhile, prepare the smallest improvement supported by
the supplied materials: for example, a source-referenced data dictionary excerpt,
input inventory, corrected cross-reference or explicit smoke experiment.

Record the source references, derivative locations, new assumptions/settings,
executed checks and unresolved author decisions. Preserve original materials.
Do not fabricate provenance or treat an illustrative check as paper reproduction.

If no change is warranted, say why. If the useful improvement requires missing
information or authorization, state exactly what is needed and show only the
portion that can be supported. End with the next few actions, or state that
the materials are adequate for the assessed purpose and no action is needed.
