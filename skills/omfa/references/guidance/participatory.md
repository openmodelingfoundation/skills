# Participatory Modeling Guidance

## Purpose

Use this guidance when developing computational models collaboratively with stakeholders, domain experts, decision makers, or other knowledge holders. It helps determine how participation should inform problem framing, conceptual modeling, model development, evaluation, interpretation, and decision support while maintaining scientific rigor, transparency, and traceability.

---

## Core Principle

Participatory modeling is a process of knowledge co-production. Participants contribute expertise, values, assumptions, and contextual knowledge throughout the modeling lifecycle. Scientific credibility depends on transparently documenting how stakeholder knowledge informed consequential modeling decisions, where disagreements remained unresolved, and which decisions ultimately rested with the modeling team.

---

## Decision Context

**Use this guidance when:**

- the modeling effort addresses complex socio-environmental, socio-technical, or policy systems involving multiple stakeholder perspectives;
- stakeholder knowledge is needed to define system boundaries, processes, objectives, scenarios, or evaluation criteria;
- the model is intended to support collaborative learning, deliberation, or decision making;
- legitimacy, transparency, or stakeholder acceptance are important project outcomes.

**Do not use this guidance when:**

- the primary challenge is developing the conceptual representation of a system independent of stakeholder engagement (use `conceptual-modeling.md`);
- the primary task is selecting modeling methods or implementation strategies (use `implementation-planning.md`);
- participation consists only of communicating completed modeling results without influencing the modeling process.

Participatory modeling complements conceptual modeling and project planning by defining how knowledge from multiple participants should be incorporated into those activities.

---

## Consequential Analytical Choices

### Stakeholder Selection

Identify which stakeholders participate and justify why they represent relevant knowledge, perspectives, interests, or decision authority. [MUST]

Document important stakeholder groups that were excluded and discuss potential implications. [MUST]

### Purpose of Participation

Clearly distinguish participation purpose [MUST]. Is it aimed to:

- define research questions;
- develop conceptual models;
- elicit assumptions;
- estimate parameters;
- construct scenarios;
- evaluate model behavior;
- interpret simulation results;
- support collective decision making.

Different objectives require different forms and timing of participation.

### Level of Participation

Document the intended role of participants throughout the modeling lifecycle. [MUST]

Examples include:

- consultation;
- collaboration;
- co-design;
- co-production;
- shared governance.

Avoid describing participation simply as "stakeholder involvement."

### Knowledge Integration

Document how qualitative knowledge, expert judgment, empirical observations, local knowledge, and scientific evidence are combined. [MUST]

Explicitly distinguish:

- consensus;
- majority agreement;
- competing viewpoints;
- unresolved disagreements.

Do not collapse conflicting perspectives into a single assumed system description without justification.

### Model Ownership

Clarify which modeling decisions remain scientific judgments by the modeling team and which are collectively negotiated. [MUST]

Participation does not imply that every modeling decision is determined by consensus.

### Iteration

Document opportunities for participants to review conceptual models, assumptions, scenarios, intermediate results, and interpretations. [SHOULD]

---

## Method Selection

Participatory modeling methods differ primarily in the kinds of knowledge they elicit, the level of stakeholder commitment they require, the degree of collaboration they support, and the resources needed to conduct them. Select the simplest approach that satisfies the scientific objectives while remaining feasible within project constraints.

| Method | Best suited for | Advantages | Tradeoffs |
| --- | --- | --- | --- |
| Structured expert elicitation | Estimating uncertain parameters, processes, or scenarios from subject matter experts | Efficient, repeatable, relatively inexpensive, integrates well with quantitative modeling | Limited interaction among participants, does not build shared understanding, susceptible to expert bias |
| Group model building | Developing shared conceptual models and identifying feedbacks | Produces common system understanding, surfaces assumptions and disagreements | Requires skilled facilitation, significant participant time, difficult with large or geographically distributed groups |
| Companion modelling (ComMod) | Supporting iterative learning through simulation, gaming, and negotiation | Encourages social learning, explores adaptive behavior, useful for conflict resolution | Time-intensive, resource-intensive, often tailored to specific communities, less scalable |
| Participatory agent-based modeling | Developing agent behaviors, decision rules, and scenarios collaboratively | Captures local knowledge and heterogeneous behaviors, improves behavioral realism | Requires participants to engage with model abstractions, greater implementation complexity, often longer development cycles |
| Knowledge co-production | Long-term collaborative research where stakeholders help shape questions, models, interpretation, and decisions | Highest legitimacy, strongest integration of scientific and local knowledge, supports sustained collaboration | Greatest coordination costs, requires long-term relationships, can complicate governance and decision making |

Canonical method foundations: group model building draws on Vennix (1996); companion modelling draws on the ComMod collective's founding charter, Barreteau et al. (2003), and its later synthesis in Étienne (2014).

Default to iterative knowledge co-production when stakeholders are genuine research partners throughout the modeling lifecycle. It provides the strongest foundation for integrating diverse knowledge and improving legitimacy, although it also requires the greatest investment in coordination, facilitation, and trust building.

Prefer more focused methods when participation serves a narrower purpose. For example, structured expert elicitation is often sufficient when only parameter estimates or process knowledge are required, while group model building may be appropriate when the primary objective is collaboratively developing a conceptual model rather than maintaining ongoing stakeholder involvement.

---

## Transparency

Clearly distinguish:

- observed evidence;
- stakeholder knowledge;
- expert judgment;
- modeling assumptions;
- unresolved disagreements;
- analytical decisions made solely by the modeling team.

Document:

- participant roles;
- elicitation methods;
- facilitation process;
- major revisions resulting from stakeholder feedback;
- assumptions introduced despite stakeholder disagreement;
- limitations arising from incomplete or unbalanced participation.

Maintain traceability between stakeholder input and consequential modeling decisions. [MUST]

---

## Intermediate Artifacts

- `stakeholder-analysis.md`
- `participation-plan.md`
- `conceptual-model.md`
- `assumptions.md`
- `decision-log.md`
- `meeting-notes.md`
- `elicitation-results.md`
- `scenario-definitions.md`
- `model-review.md`

Place these artifacts under `artifacts/` at the project root using predictable, semantic filenames. If `artifacts/` is created during this work, also create `artifacts/README.md` describing artifacts as living documents created early, revised throughout the project, and gated by explicit status/review triggers.

---

## Common Failure Patterns

- Treating participation as a one-time workshop rather than an ongoing modeling activity.
- Confusing stakeholder engagement with scientific validation.
- Allowing dominant participants to suppress minority viewpoints.
- Failing to distinguish empirical evidence from stakeholder opinion.
- Recording conclusions without documenting how they were reached.
- Assuming consensus where disagreement actually exists.
- Ignoring stakeholders who are affected by the model but lack formal authority.
- Treating stakeholder preferences as objective properties of the modeled system.
- Failing to revisit assumptions as the model evolves.

---

## Routing

**Primary entry point**

Use this guidance whenever stakeholder knowledge substantially influences model development, evaluation, or interpretation.

Combine with:

- `conceptual-modeling.md` to collaboratively develop system representations;
- `project-planning.md` to organize participatory activities;
- `uncertainty.md` when eliciting uncertain assumptions or expert judgments;
- `analysis-planning.md` when designing participatory evaluation or scenario analyses.

**Specialist execution skills**

Potential specialist skills include:

- stakeholder identification;
- expert elicitation;
- workshop design;
- consensus analysis;
- participatory scenario development.

**Downstream consumer skills**

Outputs from this guidance should support conceptual modeling, implementation planning, uncertainty analysis, model documentation, and decision support.

---

## Primary References

### Foundational Concepts

- Voinov & Bousquet (2010)
- Barreteau et al. (2010)

### Method-Specific Foundations

- Vennix (1996) — group model building
- Barreteau et al. (2003) — companion modelling (ComMod founding charter)
- Étienne (2014) — companion modelling (edited synthesis volume)

### Operational Guidance

- Voinov et al. (2016)
- Norström et al. (2020)
- Jakeman et al. (2024)

### Applied Practice

- Hamilton et al. (2019)
- Saltelli et al. (2020a)

See `references/REFERENCES.md` for complete citations.