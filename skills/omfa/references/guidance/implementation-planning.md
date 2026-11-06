# Implementation Planning Guidance

## Purpose

OMFA does not own implementation planning artifacts. Use this guidance only to decide whether the scientific prerequisites are ready for handoff to `omfb`.

## Routing

For any request to create, revise, or review these artifacts, route to `omfb` and stop:

- `omf-artifacts/implementation/plan.md`
- `omf-artifacts/implementation/architecture.md`
- `omf-artifacts/implementation/module-mapping.md`
- `omf-artifacts/implementation/parameter-schema.md`
- `omf-artifacts/implementation/verification-plan.md`

## OMFA Readiness Check

OMFA may assess whether `conceptual-model.md`, `assumptions.md`, and `uncertainty-register.md` are sufficiently developed for implementation handoff.

If those scientific prerequisites are not ready, identify the missing scientific work and remain in OMFA.

## Deliberate Gate Triggers

Apply the parent Deliberate Gates contract only where an implementation choice materially changes scientific meaning, such as a scheduling rule or approximation that changes represented interactions. Pass the unresolved choice and affected scientific artifacts to OMFA for resolution; implementation planning remains owned by `omfb`. Routine implementation choices that preserve accepted scientific intent need no gate.
