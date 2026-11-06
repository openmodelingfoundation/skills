---
name: ospool
description: |
  Generate HTCondor job submission scripts, parameter sweep configurations, and batch job templates 
  for running computational models on the Open Science Grid (OSPool).

  Use this skill when you need to run parameter sweeps, large ensembles, or distributed sensitivity 
  analysis on OSPool infrastructure. Triggers: "run on OSPool", "generate HTCondor script", 
  "set up batch parameter sweep", "submit to OSG", "create HTCondor DAG".

  Expected output: HTCondor submit files (.submit), DAG specification files, parameter sweep 
  configuration, and submission checklist.
license: MIT
compatibility: Requires HTCondor 8.9+; OSPool account and certificate
metadata:
  omf-stewardship: stewardship.yaml
---

# OSPool HTCondor Scaffolder Skill

## Skill Contract

- **Activation:** HTCondor, OSPool, OSG, distributed ensembles, or high-throughput parameter sweeps; not Slurm-specific HPC work.
- **Authority:** HTCondor submit design, DAG dependencies, file transfer, resource requests, checkpointing, and distributed dry runs.
- **Preconditions:** Runnable workload, enumerable tasks, transferable inputs and outputs, and required credentials held by the user.
- **Effects:** Generate submit files, DAGs, wrappers, and transfer plans; submit externally only when explicitly requested and authorized.
- **Invariants:** Preserve experiment parameters and input identity, isolate per-job outputs, and avoid unsupported shared-state assumptions.
- **Outputs:** Submit files, DAG or parameter configuration, wrapper scripts, transfer plan, and validation checklist.
- **Handoffs:** Route scientific-design changes to `omfa`, implementation changes to `omfb`, and stewardship or lineage changes to `fair` with job and data evidence.
- **Completion:** Generated files pass available syntax or dry-run checks and unresolved pool-specific values are visible.
- **Failure:** Produce a non-submitting scaffold and identify missing portability or transfer facts when safe execution cannot be established.
- **Provenance:** When contributing execution evidence under `omf-artifacts/implementation/`, record immutable entities, actual participants, authorization, inputs, parameters, environment, and outputs.
- **Commits:** Before a commit that could affect scientific claims, present its changes, affected claims, evidence, uncertainty, and full message; request approval of that specific commit and wait. Review one commit at a time. Wording approval alone is insufficient; prior approval covers only unchanged reviewed changes and message. Routine meaning-preserving commits still need authorization but no scientific gate. Prefer native approve/revise/defer choices with free-text feedback; otherwise use plain text. Defaults or silence are not approval. List actual contributing OMF skills in `OMF-Skills` and other contributing skills in `Agent-Skills`, using comma-separated names and omitting empty trailers. Preserve legitimate `Co-authored-by` attribution. Keep exact executed revisions and ownership in provenance; do not duplicate Git history. This rule does not itself authorize a commit.

## When to Use This Skill

Use this skill when:

- You have a working computational model and want to run it on the Open Science Grid (OSPool)
- You need to execute a parameter sweep or sensitivity analysis across many parameter combinations
- You want to submit batch jobs that leverage distributed HTCondor scheduling
- You need a dry-run mode to validate your job configuration before submission
- You are setting up checkpoint/restart for long-running simulations

## Key Inputs

This skill works best with:

- **Model executable or script** (Python .py, R script, compiled binary, or bash wrapper)
- **Parameter ranges** (variables to sweep over, with min/max or discrete values)
- **Input files** (data files, configuration, or dependencies your model needs)
- **Runtime estimate** (approximate wall-clock time per job in minutes)
- **Resource requirements** (CPU cores, memory, scratch disk)
- **Success criteria** (what constitutes a successful run)

## Step-by-Step Instructions

### 1. Prepare Your Model for OSPool

Before scaffolding, ensure:

- **Model is self-contained:** All code, dependencies, and input files can be packaged or referenced via HTTP
- **Single entry point:** Model can be invoked with a simple command: `python model.py --param1 value1 --param2 value2`
- **Output to stdout/file:** Model writes results to a file (not database) so outputs can be staged back from the worker node
- **No GUI/graphics:** HTCondor jobs are headless; remove any display dependencies
- **Reproducible with seed:** If your model uses randomness, accept a seed parameter: `--seed 42`

### 2. Define Parameter Space

Specify parameters to sweep:

```yaml
# Example sweep configuration (YAML)
sweep_type: factorial # or: one-at-a-time, latin-hypercube
parameters:
  population_size: [10, 50, 100]
  patch_count: [5, 10, 20]
  mutation_rate: [0.01, 0.05, 0.1]
replicas: 3 # replicate runs per parameter combination
```

The skill will generate all combinations (or use a design-of-experiments strategy).

### 3. Generate HTCondor Submit Files

The skill creates:

- **Main submit file** (.submit): Job description, input/output, resource requests
- **DAG file** (optional): Coordinate dependencies among jobs (e.g., run analysis after all simulations complete)
- **Parameter sweep file** (CSV or JSON): All parameter combinations to be executed
- **Wrapper script** (bash): Handles environment setup, input staging, and output staging

### 4. Dry-Run Validation

Before submitting to OSPool:

```bash
# Inspect the generated submit file before submitting. At minimum, check:
# - HTCondor syntax is valid
# - Executable is present or accessible
# - Input files are staged or remotely accessible
# - Output directory is writable
# - Resource requests are reasonable
```

Address any validation errors before proceeding.

### 5. Submit to OSPool

Once validated:

```bash
condor_submit my_job.submit
# Submits N jobs to OSPool
# Track status: condor_q
# Monitor: htop (if interactive) or check submission log
```

## ⚠️ Gotchas

- **Path dependencies:** HTCondor workers run in a sandbox directory. Use relative paths or stage files explicitly. Absolute paths like `/home/user/...` will break on worker nodes.
- **Environment differences:** Worker nodes may have different OS versions, libraries, or Python versions. Container/Singularity is recommended for complex dependencies.
- **Data staging:** Large input files should be staged via HTTP or OSPool's data cache, not embedded in submit files.
- **Output size:** Limit per-job output size. HTCondor has file size caps. If outputs are large, write directly to OSPool storage or compress before staging back.
- **Long-running jobs:** HTCondor has wall-clock time limits (~24 hours typical). If your model runs longer, implement checkpointing or break into smaller jobs.
- **Random seed conflicts:** If multiple replicas use the same random seed, they'll produce identical results. The skill will assign unique seeds automatically if you set `replicas > 1`.

## Templates & Resources

This skill currently has no bundled `references/`, `assets/`, `examples/`, or
`scripts/` files. Generate HTCondor submit files, DAGs, parameter sweep files,
and wrapper scripts directly from the guidance and examples in this `SKILL.md`.
If reusable validators or templates are added later, reference them here with
explicit load conditions.

## Example

**Input:** Python model `run_sim.py` with parameters, parameter sweep config

**Output:**

1. **HTCondor submit file** (`sim_sweep.submit`):

   ```
   universe = vanilla
   executable = scripts/run_wrapper.sh
   arguments = run_sim.py --population $(population) --patches $(patches)
   input = run_sim.py, data.csv
   output = results_$(ClusterId)_$(ProcId).csv
   error = err_$(ClusterId)_$(ProcId).log
   log = job_$(ClusterId)_$(ProcId).log
   request_cpus = 1
   request_memory = 512MB
   request_disk = 1GB
   queue 30  # 30 jobs (3 population × 2 patches × 5 replicates)
   ```

2. **Parameter sweep file** (swept combinations):

   ```csv
   population,patches,seed
   10,5,1001
   10,5,1002
   10,10,1001
   ...
   100,20,1005
   ```

3. **Validation output:**
   ```
   ✓ Submit file syntax is valid
   ✓ Executable found: scripts/run_wrapper.sh
   ✓ Input files present: run_sim.py, data.csv
   ✓ Resource requests reasonable (1 CPU, 512MB RAM)
   ✓ Ready to submit: 30 total jobs
   ```

---

## Quick Reference

| Task                     | Command/Reference                          |
| ------------------------ | ------------------------------------------ |
| Validate HTCondor config | Review submit syntax, transfer directives, executable paths, and resource requests |
| Submit jobs              | `condor_submit my_job.submit`              |
| Monitor jobs             | `condor_q`                                 |
| Review logs              | Check `.log`, `.out`, and `.err` files     |

---

For community feedback or issues, see the [OMF Skills](https://github.com/openmodelingfoundation/skills) repository.
