# Reviewing AI-generated research software: failure modes and verification

AI-generated code should earn trust through evidence appropriate to its purpose. A successful build, passing test suite, or plausible result each answers a different question. None alone establishes that the software implements the intended scientific model.

Language and framework choices influence which mistakes tools can detect. Reviewers still need to establish what the program should do, whether the checks exercise that behavior, and what remains uncertain. The same reasoning applies to human-written code; when using coding agents, it also applies to their changes to tests, configuration, dependencies, and documentation.

## Start with the change and its consequences

Before selecting checks, identify the intended behavior and the consequences of getting it wrong. A documentation correction, a data migration, and a change to an agent activation rule warrant different scrutiny.

Consider the scope of the change, its scientific and operational consequences, its reversibility, and the available evidence. Small changes can have large effects: changing an update order or a missing-data default may alter results without causing an exception.

Use repository instructions, model specifications, established conventions, and relevant examples to define acceptance criteria. If those sources conflict, resolve the conflict explicitly. An agent should not silently choose the scientific interpretation that is easiest to implement.

## Five sources of risk

These categories help select checks to be made, and keep in mind that any single defect may involve several of them.

| Source of risk                | Review question                                                                                    | Useful response                                                                                                  |
| ----------------------------- | -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| Language and runtime          | Could memory, coercion, array, nullability, or concurrency behavior violate an assumption?         | Apply compiler checks, static analysis, runtime validation, sanitizers, and focused tests as appropriate.        |
| Version and API compatibility | Does this code use interfaces supported by the actual environment?                                 | Inspect dependency versions and consult documentation for those versions; run representative integration checks. |
| Framework conventions         | Does the implementation respect lifecycle, scheduling, state ownership, and execution conventions? | Compare with maintained examples and inspect framework-specific behavior.                                        |
| Domain semantics              | Does the code implement the intended model, units, algorithm, or statistical procedure?            | Use specification-based review, independent expected results, invariants, and scientific judgment.               |
| Agent workflow                | Did the agent make the intended changes and actually validate them?                                | Review the complete diff, changes to tests and configuration, executed commands, failures, and omissions.        |

Do not infer model accuracy from language popularity, community size, or the model's stated confidence. A framework's visibility may suggest where to investigate, but it does not establish proficiency. Comparative claims require task-specific evaluations with documented conditions.

## Language-specific review priorities

The following mechanisms identify where focused review can help. Tool coverage depends on configuration, code paths exercised, dependencies, and interfaces with other languages.

| Language   | Review priorities                                                                                                                    | Useful checks                                                                                                                                                                |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Python     | Mutation and aliasing, missing values, swallowed exceptions, numerical shapes, pandas label alignment, library contracts             | Existing linting and type checks where applicable; tests for shapes, labels, missingness, and boundaries. Type annotations do not establish numerical or domain correctness. |
| R          | Recycling, coercion, `NA` behavior, factors, dimension dropping, differences between base R and package semantics                    | Explicit dimension and type checks; small examples with known results; tests of missing-data and statistical assumptions.                                                    |
| Julia      | Broadcasting, mutation, dispatch, package interfaces, allocations and type instability                                               | Correctness tests first; then profiling and type-inference inspection where performance matters. Assess type instability primarily through its measured performance effects. |
| Rust       | Error propagation, state transitions, cancellation, unnecessary cloning or synchronization, `unsafe` and foreign-function boundaries | Compiler and lint checks, behavioral tests, and targeted review of unsafe boundaries. Ownership checks do not establish algorithmic correctness or freedom from deadlocks.   |
| TypeScript | `any`, assertions, nullability settings, unchecked external input, asynchronous behavior                                             | Inspect compiler settings and run type checking explicitly; validate external data at runtime. Assertions do not perform runtime validation.                                 |
| JavaScript | Coercion, missing properties, `null`/`undefined`, shared mutation, asynchronous ordering                                             | Linting, optional static checking, runtime boundary validation, and tests of error paths and asynchronous behavior.                                                          |
| C          | Bounds, lifetimes, allocation ownership, initialization, overflow, undefined behavior                                                | Compiler warnings, suitable static analysis and sanitizers, and focused boundary tests. A clean run covers only the execution exercised.                                     |
| C++        | Object and reference lifetimes, iterator invalidation, ownership, concurrency, undefined behavior                                    | Use existing ownership conventions and standard abstractions; combine compiler diagnostics, sanitizers, and lifetime/concurrency review.                                     |
| Fortran    | Bounds and shapes, implicit typing in legacy code, kinds and precision, aliasing, array layout and language interoperability         | Explicit declarations, compiler diagnostics, development-time runtime checks, and numerical reference cases.                                                                 |
| Java       | Nullability, resource lifecycle, concurrency, generic boundaries, framework contracts                                                | Compiler and static checks, resource and concurrency review, and integration tests against the actual framework version.                                                     |

The mechanisms above are grounded in language and library behavior. For example, NumPy broadcasting can legally expand compatible shapes; R defines recycling rules; TypeScript removes type assertions during compilation; and Rust's unsafe facilities permit operations with additional obligations on the programmer. These facts identify checks to consider. [NumPy broadcasting](https://numpy.org/doc/stable/user/basics.broadcasting.html), [R language definition](https://cran.r-project.org/doc/manuals/R-lang.html), [TypeScript handbook](https://www.typescriptlang.org/docs/handbook/2/everyday-types.html), [Rust unsafe code](https://doc.rust-lang.org/book/ch20-01-unsafe-rust.html).

For performance review in Julia and development checks in Fortran, consult the relevant implementation documentation. [Julia performance guidance](https://docs.julialang.org/en/v1/manual/performance-tips/), [GNU Fortran runtime-check options](https://gcc.gnu.org/onlinedocs/gfortran/Code-Gen-Options.html).

## Framework-specific verification

Fluency in a host language does not establish that a particular framework is being used correctly. Verify the installed version before applying examples from documentation. For reproducible environments, the appropriate API is the one the project actually uses, which may differ from the latest release.

The following are suggested review targets, without comparative confidence ratings:

| Framework       | Concrete pitfalls and checks                                                                                                                                                                                                     |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NetLogo         | Assuming `ask` over an agentset uses a fixed order: agents execute in randomized order. Check whether later agents observe earlier agents' updates and whether this matches the specified scheduling.                            |
| Mesa            | Mixing examples across versions: Mesa 3 changed model initialization, agent IDs, and activation APIs. Check constructors and scheduler replacements against the installed version, preserving the intended activation semantics. |
| AgentPy         | Accidentally reusing a seed across intended independent replications or recording results before the intended update. Check resolved experiment parameters, seed assignments, and when observations are recorded.                |
| Agents.jl       | Assuming the selected scheduler randomizes activation or that agent and model steps occur in the intended sequence. Inspect the configured scheduling and stepping behavior, and trace one small run.                            |
| MASON           | Leaving interacting events at the same simulation time without considering their ordering. Check event times, ordering values, and whether state updates become visible at the intended point.                                   |
| Repast Simphony | Assuming annotated methods run in the intended order or that agents belong to the intended context and projection. Check scheduling parameters and membership in a minimal batch run.                                            |
| Repast4Py       | Reading stale ghost-agent state across partition boundaries or omitting model state from synchronization. Check synchronization points and serialization, then exercise interactions across a partition boundary.                |

Check that an apparently familiar method actually belongs to the framework and version in use. Mixing conventions across frameworks can produce plausible code with incorrect behavior. NetLogo's programming guide documents its agent execution semantics, while Mesa's migration guide illustrates why version-specific verification matters. [NetLogo programming guide](https://docs.netlogo.org/programming.html), [Mesa migration guide](https://mesa.readthedocs.io/stable/migration_guide.html). Repast4Py documents synchronization of distributed agents and their ghost copies in its [shared-context API](https://repast.github.io/repast4py.site/apidoc/source/repast4py.context.html). The other entries are candidate checks to adapt to the project and framework version.

## Establish scientific correctness with independent evidence

A test is useful when its expected result has a defensible basis. If an agent writes both the implementation and its tests from the same mistaken interpretation, their agreement can conceal the error. Review the basis of expected results and the assumptions behind each assertion.

For agent-based models, link the review to the project's ODD (Overview, Design concepts, and Details) description, especially _Process overview and scheduling_, alongside equations and other specifications. Use it to establish the intended rules, update order, and timing. An independently maintained specification can ground expected behavior; omissions and ambiguities still require domain judgment. [ODD protocol and guidance](https://www.jasss.org/23/2/7.html).

Select checks that fit the model:

| Concern                      | Candidate evidence                                                                                                                                                                                                           |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Model implementation         | Trace key rules, equations, state transitions, and scheduling decisions to the specification.                                                                                                                                |
| Numerical behavior           | Compare with analytical solutions, limiting cases, or independently established reference results; examine convergence where appropriate.                                                                                    |
| Invariants                   | Check conservation, population accounting, admissible ranges, or other justified constraints.                                                                                                                                |
| Stochastic behavior          | Use multiple seeds and assess distributions or summary statistics with scientifically justified tolerances.                                                                                                                  |
| Activation-order sensitivity | Where scientifically meaningful and computationally feasible, compare output distributions under shuffled or alternative activation orders. Investigate unexpected sensitivity against the specified scheduling assumptions. |
| Data interpretation          | Check units, dimensions, missingness, join cardinality, coordinate alignment, and category meanings.                                                                                                                         |
| Parallel execution           | Compare serial and parallel behavior under explicitly stated numerical and stochastic reproducibility expectations.                                                                                                          |
| Behavioral relationships     | Test justified relationships between inputs and outputs when exact expected values are unavailable.                                                                                                                          |

First verify that activation follows the specification. Altering that order is a sensitivity experiment: differences may be scientifically meaningful, and agreement across orders is not a general correctness requirement. Start with a small representative scenario and expand only when the question warrants the cost. Record the baseline and altered schedules, replicate seeds, and comparison measures. Reusing a seed alone does not guarantee comparable random draws when activation changes their assignment or consumption.

Record why a tolerance or expected relationship is appropriate. Do not assume monotonicity, exact conservation, or bitwise reproducibility unless the model and implementation warrant it. Agreement with a legacy implementation is useful regression evidence, but the legacy implementation may itself contain errors.

Distinguish implementation verification from model validation. Correctly implementing a specification does not establish that its assumptions are suitable for the research question or that its predictions are supported by observations.

Worked example: an agent changes an expected value

This scenario is illustrative. The model and numbers are invented.

A project maintains a Python agent-based model of shared-resource harvesting. Its ODD description states, under Process overview and scheduling, that harvesters act in a freshly randomized order each step and that every harvest immediately reduces the shared stock, so later harvesters see the depleted value. A coding agent is asked to upgrade the model to a newer Mesa release. It reports that the upgrade is complete and all tests pass.

The diff contains one changed test. The expected final population for seed 42 moved from 412 to 388, with the commit note "update expected value after framework migration."

1. Treat the changed value as a claim. A framework upgrade should preserve model behavior, so a different output needs an explanation. The commit note says when the value changed and gives no reason for the change.

2. Trace to the specification. Read the ODD scheduling paragraph, then the replacement activation code. Suppose the new code iterates agents in a fixed order, or computes every harvest from a start-of-step snapshot. Either conflicts with the ODD. A fixed order lets the same agents always harvest first, and a snapshot removes the depletion effect.

3. Compare distributions. Run the pre-migration and post-migration revisions on a small scenario with an initial exploratory batch of replicate seeds, with replication determined by variability, the effect of interest, and computational cost, and compare the distribution of final population. A single-seed comparison cannot separate a behavior change from a different sequence of random draws, because changing the activation order changes how draws are consumed. Record the seeds, the schedules, and the comparison measure.

4. Decide who resolves the discrepancy. If the distributions differ and the ODD describes the intended behavior, ask the agent to restore the specified activation behavior, then determine whether the original exact-value assertion remains valid under the updated framework. If the maintainers decide the new behavior is intended, that is a scientific decision. Update the ODD, record who decided and why, and then update the test.

5. Strengthen the test. An exact single-seed value ties the test to one random-number sequence. Add checks with a defensible basis, e.g., check the resource balance, accounting for harvesting, regeneration, and any other inflows or losses.

6. Record the outcome. The review summary states what changed, the ODD section consulted, the comparison run and its result, and what remains uncertain. Here, agreement with the specification says nothing about whether the specified model matches field observations, and that validation question stays open.

## Review the agent's work as a repository change

Give the agent a bounded objective and access to the relevant repository instructions, domain definitions, and acceptance criteria. Require it to surface consequential ambiguity for explicit resolution.

Review the complete diff. Pay particular attention to changed expected results, removed assertions, skipped tests, suppressed diagnostics, new dependencies, and configuration changes that make checks pass. Such changes can be legitimate, but should have a reason grounded in the intended behavior.

Validation report. Ask for a concise report identifying the commands run, their exit statuses, the relevant environment, and any checks skipped or blocked. A successful command is evidence only for what it actually exercised. Mocked boundaries and local configurations may leave integration or deployment behavior untested.

Reproducibility record. For consequential scientific changes, retain the code revision, a dependency lockfile or environment snapshot with exact versions, input references, parameters, seeds, and relevant execution settings such as process counts. Record separate random-number generators or streams where they affect repeatability. For a narrow change, a commit reference and the test command are often enough. Reuse existing project records where they exist.

AI involvement. Record it proportionately: the tool and model or version where available, the task and scope of its contribution, and the human review and verification performed. State when an identifier is unavailable. Retain prompts or interaction excerpts when they explain a consequential decision or when a venue requires them. A full transcript need not be a routine deliverable. This record supports peer review and provenance, and the environment and validation records support reproducibility.

Use additional agent review to generate questions and candidate checks. Agreement between agents is not independent confirmation of correctness. For consequential scientific changes, seek evidence beyond the generating explanation, such as a specification, an analytical case, observations, or expert review.

## Keep the review proportionate

Choose the smallest set of checks that addresses the concrete risks. A focused test and a short explanation may be enough for a narrow correction. Changes to scientific assumptions, numerical methods, distributed execution, or irreversible data operations usually need stronger evidence.

Summarize what changed, why it is justified, what was checked, and what remains uncertain. Avoid adding process or tooling solely because AI contributed to the code. Add safeguards where they address an identifiable failure mode.

Maintain this guidance using documented failures, useful checks, evaluations, and changes in language or framework behavior. If publishing model-specific comparisons, report the model version, task, context, tools, attempts, and evaluation criteria. Self-assessment alone is not a basis for a reliability ranking.
