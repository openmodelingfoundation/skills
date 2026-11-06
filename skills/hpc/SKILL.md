---
name: hpc
description: |
  Generate Slurm job scripts, job arrays, and resource allocation templates for running
  computational models on HPC (High-Performance Computing) clusters.

  Use this skill when you need multi-node execution, high-memory jobs, GPU/accelerator access,
  or direct Slurm cluster submission. Triggers: "run on HPC", "generate Slurm script",
  "set up batch array job", "submit to cluster", "create Slurm job array".

  Expected output: Slurm batch scripts (.slurm), job array configurations, resource allocation
  templates, and submission validation checklist.
license: MIT
compatibility: Requires Slurm job scheduler; HPC cluster account
metadata:
  omf-stewardship: stewardship.yaml
---

# HPC Slurm Scaffolder Skill

## Skill Contract

- **Activation:** Slurm, multi-node, accelerator, high-memory, or HPC batch execution needs; not distributed HTCondor/OSPool work.
- **Authority:** Slurm execution design, resource requests, job arrays, staging, dependencies, and scheduler validation.
- **Preconditions:** Runnable workload, cluster constraints or explicitly provisional assumptions, input/output paths, and required credentials held by the user.
- **Effects:** Generate Slurm scripts and resource plans; submit or mutate cluster state only when explicitly requested and authorized.
- **Invariants:** Preserve experiment parameters, input identity, output separation, and scheduler portability; never invent site policy.
- **Outputs:** Batch scripts, array configuration, resource rationale, staging plan, and validation checklist.
- **Handoffs:** Route scientific-design changes to `omfa`, implementation changes to `omfb`, and stewardship or lineage changes to `fair` with job and data evidence.
- **Completion:** Generated files pass available static or dry-run checks and unresolved site-specific values are visible.
- **Failure:** Produce a non-submitting scaffold and identify missing cluster facts when safe execution cannot be established.
- **Provenance:** When contributing execution evidence under `omf-artifacts/implementation/`, record immutable entities, actual participants, authorization, inputs, parameters, environment, and outputs.
- **Commits:** Before a commit that could affect scientific claims, present its changes, affected claims, evidence, uncertainty, and full message; request approval of that specific commit and wait. Review one commit at a time. Wording approval alone is insufficient; prior approval covers only unchanged reviewed changes and message. Routine meaning-preserving commits still need authorization but no scientific gate. Prefer native approve/revise/defer choices with free-text feedback; otherwise use plain text. Defaults or silence are not approval. List actual contributing OMF skills in `OMF-Skills` and other contributing skills in `Agent-Skills`, using comma-separated names and omitting empty trailers. Preserve legitimate `Co-authored-by` attribution. Keep exact executed revisions and ownership in provenance; do not duplicate Git history. This rule does not itself authorize a commit.

## When to Use This Skill

Use this skill when:

- You have computational models that require multi-node parallelism or significant memory
- You need to execute many parameter combinations across an HPC cluster (job arrays)
- You want to leverage GPUs, specialized accelerators, or high-memory nodes
- You require direct queue submission and resource control via Slurm
- You need to coordinate dependent jobs or chain simulations together

## Key Inputs

This skill works best with:

- **Model executable or script** (MPI-enabled application, Python/R script, or shell command)
- **Parallelization strategy** (single-node multi-core, multi-node MPI, embarrassingly parallel)
- **Resource requirements** (CPU cores, memory per node, GPU count, wall-clock time)
- **Job array configuration** (number of jobs, parameter range or sweep specification)
- **Module dependencies** (compilers, libraries, runtime environments loaded via `module load`)
- **HPC cluster specifics** (partition names, queue limits, storage paths)

## Step-by-Step Instructions

### 1. Understand Your Model's Parallelism

Determine how your model scales:

- **Single-node, multi-core:** Uses OpenMP or Python multiprocessing; request cores on one node
- **Multi-node MPI:** Uses MPI (Message Passing Interface); request multiple tasks across one or more nodes
- **Hybrid MPI plus OpenMP:** Uses MPI ranks, each with multiple threads; request tasks and CPUs per task
- **Embarrassingly parallel:** Independent jobs such as parameter sweeps; use job arrays
- **GPU-accelerated:** Uses CUDA, OpenCL, or accelerator-aware libraries; request GPU resources in Slurm

### 2. Translate Model Structure to Slurm Requests

Estimate resources from how the model actually runs, then validate with small or representative jobs. There is no universal formula; use observed scaling and cluster limits to refine requests.

- **MPI:** One process per model rank. Request `--ntasks` across one or more nodes; use `--cpus-per-task=1` unless each rank also uses threads.
- **OpenMP or threaded code:** One process with multiple threads. Request `--ntasks=1`, set `--cpus-per-task` to the thread count, and export `OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK`.
- **Hybrid MPI plus OpenMP:** Request MPI ranks with `--ntasks` or `--ntasks-per-node`; request threads per rank with `--cpus-per-task`.
- **Embarrassingly parallel sweeps:** Use a job array. Each array task usually requests one node, one task, and the cores or memory needed by one parameter run.
- **GPU workloads:** Request GPUs with the cluster-supported Slurm option, keep CPU tasks aligned with the GPU program, and size host memory separately from GPU memory.

Examples:

```bash
# 64 MPI ranks total, no threading
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1

# 1 threaded run using 8 CPU cores
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# 8 MPI ranks, each with 4 OpenMP threads
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=4
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# 200 independent runs, at most 20 active at once
#SBATCH --array=1-200%20
#SBATCH --nodes=1
#SBATCH --ntasks=1

# 1 GPU job; exact GPU directive may vary by cluster
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
```

### 3. Set Resource Requests

Define resource needs:

```bash
# Example resource profile
#SBATCH --nodes=2              # 2 compute nodes
#SBATCH --ntasks-per-node=16   # 16 MPI processes per node (32 total)
#SBATCH --cpus-per-task=1      # 1 CPU core per MPI task
#SBATCH --mem=64GB             # 64 GB per node
#SBATCH --time=04:00:00        # 4-hour wall-clock limit
#SBATCH --partition=standard   # queue name (cluster-specific)
#SBATCH --gres=gpu:2           # 2 GPUs (if needed)
```

For memory, profile one process or a representative smaller run, then scale conservatively for the requested number of ranks, threads, or array tasks. Leave headroom for input loading, libraries, and variation across parameter sets, then compare the request with observed usage after the run.

### 4. Generate Slurm Batch Script

The skill creates a `.slurm` script that:

- Loads required modules (compilers, libraries, runtime)
- Sets environment variables (OMP threads, MPI settings)
- Stages input data from shared storage
- Runs your model using `srun` (for MPI) or local execution
- Copies results back to persistent storage
- Records the job ID, script, software environment, and run parameters needed to reproduce the execution

If Apptainer or Singularity is available on the target cluster, use a container to keep runtime libraries and model dependencies consistent across login and compute nodes. Keep the Slurm script responsible for resource requests, staging, and launching the containerized command; do not assume container support or module names unless the cluster documents them.

### 5. Plan Storage and File Movement

Use scratch or fast temporary storage for intermediate files created during the run, and copy final outputs back to persistent project storage before the job ends. Keep paths generic in scaffolds, such as `PROJECT_DIR`, `SCRATCH_DIR`, or `OUTPUT_DIR`, and let users replace them with cluster-appropriate locations.

For parallel filesystems, avoid creating many tiny files from many ranks or array tasks when possible. Prefer grouped outputs, per-task subdirectories, or periodic aggregation. Stage large read-only inputs once per job or per node when that is faster than repeated shared-filesystem reads, and archive or compress completed outputs when downstream analysis no longer needs individual files.

### 6. Set Up Job Arrays for Parameter Sweeps

For parameter sweeps, use Slurm job arrays:

```bash
#SBATCH --array=1-100%10    # 100 jobs, max 10 running simultaneously
```

Each job receives a unique `$SLURM_ARRAY_TASK_ID` to index parameter combinations:

```bash
# In your script:
params=$(sed -n "${SLURM_ARRAY_TASK_ID}p" parameters.txt)
python model.py $params --output results_${SLURM_ARRAY_TASK_ID}.csv
```

The skill generates:

- **Slurm submit script** (.slurm)
- **Parameter list** (one per line, one parameter set per job)
- **Array submission command** ready to run

### 7. Chain Dependent Jobs

Use dependency chains when a workflow has ordered stages, such as preprocessing, simulation, then analysis. Keep each stage restartable and submit the next stage only after the previous one succeeds:

```bash
prep_id=$(sbatch prep.slurm | awk '{print $4}')
sim_id=$(sbatch --dependency=afterok:${prep_id} simulate.slurm | awk '{print $4}')
sbatch --dependency=afterok:${sim_id} analyze.slurm
```

Avoid long dependency chains when a workflow manager or explicit checkpointing would make failures easier to recover from.

### 8. Validate Before Submission

Check your job script:

```bash
# Inspect the generated script before submitting. At minimum, check:
# - Slurm directives are valid for the user's cluster
# - Resource requests do not exceed cluster limits
# - Module names match `module avail` on the target cluster
# - Executable and input files exist from the submit directory
# - Output directories are writable
```

Address warnings before submitting.

### 9. Submit, Monitor, and Review

```bash
sbatch my_job.slurm                 # Submit single job
sbatch --array=1-100 my_job.slurm   # Submit job array
squeue -u $USER                     # Check pending and running jobs
sacct -j $JOBID                     # Review completed job state and resource use
seff $JOBID                         # Summarize CPU and memory efficiency, if available
scancel $JOBID                      # Cancel job
```

Use `squeue` while the job is pending or running, `sacct` after the scheduler has accounting data, and `seff` for a quick postmortem on requested versus used resources.

### 10. Debug Failed Jobs

When a job fails, first separate scheduler problems from application problems:

- **Scheduler failures:** The job never starts, is cancelled by policy, exceeds time or memory limits, or requests resources the cluster cannot allocate. Inspect `sacct -j $JOBID` and scheduler output/error logs.
- **Application failures:** The allocation starts, but the model exits with an error, missing input, bad module or container environment, segmentation fault, or nonzero exit code. Reproduce the command in an interactive allocation when possible.

For recovery, fix the resource request or script, then resubmit; restart from checkpoints for long runs; or reduce to a small representative case that can be debugged interactively before launching the full batch again.

## Gotchas

- **Module availability:** HPC clusters vary widely. Confirm module names with `module avail` before scripting.
- **Storage paths:** Keep paths cluster-neutral in templates and ask the user to map them to the site's home, project, scratch, and archival storage. Understand quotas and retention policies.
- **Wall-clock time:** Underestimate penalties for exceeding wall-clock limits. If your model might run long, add buffer (for example, 1.5x estimated time) and implement checkpointing.
- **Memory oversubscription:** Request memory conservatively. If you request 128GB and only use 10GB, you waste resources and delay job start.
- **MPI initialization:** Multi-node MPI jobs require careful process placement. Use `srun` for MPI jobs, not direct executable invocation.
- **GPU scheduling:** GPUs are scarce. Request only what you need, and use the site's documented GPU directive.
- **GPU runtime checks:** Match the application or container's CUDA expectations to the cluster driver/runtime, check `CUDA_VISIBLE_DEVICES` inside the job, and remember that host memory and GPU memory are separate limits.
- **Job dependency chains:** If you have dependent jobs (for example, preprocessing to simulation to analysis), use `sbatch --dependency` to coordinate them.
- **Containers:** Apptainer or Singularity can improve environment consistency, but bind paths, GPU passthrough, and filesystem access are cluster-specific. Keep examples generic.
- **Provenance:** Record Slurm job IDs, submitted scripts, module list or container image identifier, key environment variables, input manifest, random seeds, and the git commit or release tag used for the run.

## Templates & Resources

This skill currently has no bundled `references/`, `assets/`, `examples/`, or
`scripts/` files. Generate Slurm scripts directly from the guidance and examples
in this `SKILL.md`. If reusable validators or templates are added later,
reference them here with explicit load conditions.

## Example

**Input:** Python model with parameter sweep over 100 combinations, estimated 10 min per job

**Output:**

1. **Slurm batch script** (`param_sweep.slurm`):

   ```bash
   #!/bin/bash
   #SBATCH --job-name=param_sweep
   #SBATCH --array=1-100%20
   #SBATCH --nodes=1
   #SBATCH --ntasks=1
   #SBATCH --cpus-per-task=4
   #SBATCH --mem=16GB
   #SBATCH --time=00:30:00
   #SBATCH --output=logs/sweep_%a.out
   #SBATCH --error=logs/sweep_%a.err

   module load python/3.10
   cd $SLURM_SUBMIT_DIR

   params=$(sed -n "${SLURM_ARRAY_TASK_ID}p" params.txt)
   python model.py $params --output results_${SLURM_ARRAY_TASK_ID}.csv
   ```

2. **Parameter list** (`params.txt`, 100 lines):

   ```
   --pop 10 --patches 5 --seed 1001
   --pop 10 --patches 5 --seed 1002
   --pop 10 --patches 10 --seed 1001
   ...
   --pop 100 --patches 20 --seed 1005
   ```

3. **Submission & monitoring:**

   ```bash
   $ sbatch --array=1-100%20 param_sweep.slurm
   Submitted batch job 12345

   $ squeue -u $USER
   JOBID  PARTITION  NAME  USER  ST  TIME  NODES  NODELIST(REASON)
   12345_1  standard  param_sweep  user  R  00:05  1  node01
   12345_2  standard  param_sweep  user  R  00:03  1  node02
   12345_3  standard  param_sweep  user  PD  0:00  1  (Priority)
   ...
   ```

---

## Quick Reference

| Task                  | Command/Reference                         |
| --------------------- | ----------------------------------------- |
| Validate Slurm script | Review directives, modules, paths, and resource limits before `sbatch` |
| Submit single job     | `sbatch my_job.slurm`                     |
| Submit job array      | `sbatch --array=1-100%20 my_job.slurm`    |
| Monitor jobs          | `squeue -u $USER`                         |
| Inspect completed job | `sacct -j $JOBID`                         |
| Review efficiency     | `seff $JOBID`                             |
| Cancel job            | `scancel $JOBID`                          |

---

For community feedback or issues, see the [OMF Skills](https://github.com/openmodelingfoundation/skills) repository.
