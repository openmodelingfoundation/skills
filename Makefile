# ---- config ----
PYTHON ?= python3
SCRIPTS := scripts
EVALS := evals
FORMAT_FILES ?= *.md **/*.{md,json}

CROSS_EVAL := $(EVALS)/cross-skills.json
TOOLS_RUN := docker compose run --rm --entrypoint python3 tools
TOOLS_EXEC := docker compose run --rm tools

# ---- default ----
.PHONY: all
all: help

# ---- help ----
.PHONY: help
help:
	@echo "OMF Skills repository — supported make targets"
	@echo ""
	@echo "  make help              Show this help message"
	@echo "  make validate          Run the canonical repository validation suite (CI-equivalent)"
	@echo "  make container-validate  Run the full validation suite inside the supported container"
	@echo "  make validate-citation  Validate the repository CITATION.cff metadata"
	@echo "  make test              Run repository tests / evals only (no lint or format)"
	@echo "  make validate-provenance  Validate the OMF provenance schema and template"
	@echo "  make validate-stewardship Validate skill stewardship records and subject digests"
	@echo "  make refresh-stewardship  Refresh subject manifests after skill-content changes"
	@echo "  make lint              Run static analysis (markdown lint on all *.md)"
	@echo "  make format            Apply repository formatting (set FORMAT_FILES to limit scope)"
	@echo "  make clean             Remove generated artifacts"
	@echo "  make report            Aggregate failure report from evals"
	@echo ""
	@echo "Prefer these targets over invoking docker, python, pytest, npm, etc. directly."

# ---- canonical validation ----
# make validate is the single obvious entry point. It runs the same checks as CI.
.PHONY: validate
validate: container-validate

# ---- containerized validation ----
# Authoritative, CI-equivalent validation runs inside the supported container.
.PHONY: container-validate
container-validate:
	@echo "=== Running containerized validation ==="
	@$(MAKE) lint
	@$(MAKE) test
	@$(MAKE) validate-citation
	@echo "=== Container validation completed ==="

# ---- citation validation ----
.PHONY: validate-citation
validate-citation:
	@echo "=== Validating CITATION.cff ==="
	@$(TOOLS_EXEC) 'cd /app && PATH="/opt/venv/bin:$$PATH" cffconvert --validate'

# ---- tests (no lint, no format) ----
.PHONY: test
test: validate-evals validate-provenance validate-stewardship cross validate-skills

# ---- individual validation targets ----
.PHONY: validate-skills
validate-skills:
	@$(TOOLS_RUN) $(SCRIPTS)/validate_individual_skills.py

.PHONY: validate-evals
validate-evals:
	@$(TOOLS_RUN) $(SCRIPTS)/validate_evals_schema.py

.PHONY: validate-provenance
validate-provenance:
	@$(TOOLS_RUN) $(SCRIPTS)/validate_provenance.py

.PHONY: validate-stewardship
validate-stewardship:
	@$(TOOLS_RUN) $(SCRIPTS)/validate_stewardship.py

.PHONY: refresh-stewardship
refresh-stewardship:
	@$(TOOLS_RUN) $(SCRIPTS)/refresh_stewardship_subjects.py

.PHONY: cross
cross:
	@$(TOOLS_RUN) $(SCRIPTS)/validate_cross_skills.py $(CROSS_EVAL)

# ---- aggregate report ----
.PHONY: report
report:
	@$(TOOLS_RUN) $(SCRIPTS)/aggregate_failures.py

# ---- full pipeline (legacy alias, same as validate) ----
.PHONY: full
full: validate

# ---- CI Pipeline (legacy alias, same as validate) ----
.PHONY: ci
ci: validate

# ---- formatting ----
.PHONY: format
format:
	$(TOOLS_EXEC) 'prettier --write $(FORMAT_FILES)'

# ---- linting ----
.PHONY: lint
lint:
	$(TOOLS_EXEC) 'markdownlint-cli2 **/*.md "prompts/**/*.md"'

# ---- clean ----
.PHONY: clean
clean:
	@rm -f results_cross.json
	@find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name '*.pyc' -delete 2>/dev/null || true
	@echo "Cleaned generated artifacts"
