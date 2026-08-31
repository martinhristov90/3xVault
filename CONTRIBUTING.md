# Contributing to 3xVault

Thank you for your interest in contributing! This document explains how to set up your local environment, what checks run automatically, and how to submit a pull request.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Pre-commit Hooks](#pre-commit-hooks)
- [GitHub Actions CI](#github-actions-ci)
- [Submitting a Pull Request](#submitting-a-pull-request)

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) `~> 1.16.0`
- [pre-commit](https://pre-commit.com/#install) `>= 3.x`
- [TFLint](https://github.com/terraform-linters/tflint) `v0.64.0` (used by pre-commit hooks)
- [tfsec](https://github.com/aquasecurity/tfsec) `v1.28.0` (used by pre-commit hooks)
- [Gitleaks](https://github.com/gitleaks/gitleaks) `v8.18.2` (used by pre-commit hooks)
- [jq](https://stedolan.github.io/jq/) (required for replication token commands)
- AWS account with the necessary permissions

---

## Getting Started

1. Fork and clone the repository:
   ```bash
   git clone https://github.com/martinhristov90/3xVault.git
   cd 3xVault
   ```

2. Install pre-commit hooks:
   ```bash
   pre-commit install
   ```

3. (Optional) Run all hooks manually against the full repo:
   ```bash
   pre-commit run --all-files
   ```

---

## Pre-commit Hooks

Pre-commit hooks are defined in [`.pre-commit-config.yaml`](.pre-commit-config.yaml) and mirror the checks that run in CI. They execute automatically on every `git commit`.

| Hook | What it checks |
| --- | --- |
| `check-yaml` / `check-json` | Valid YAML and JSON syntax |
| `check-added-large-files` | Files must be under 1 MB |
| `check-case-conflict` | No case-insensitive filename collisions |
| `check-merge-conflict` | No unresolved merge conflict markers |
| `detect-private-key` | No private keys accidentally staged |
| `mixed-line-ending` | Enforces LF line endings |
| `terraform_fmt` | Equivalent to `terraform fmt -check -recursive` |
| `terraform_validate` | Runs `terraform init -backend=false && terraform validate` per module |
| `terraform_tflint` | Runs `tflint --recursive` using [`.tflint.hcl`](.tflint.hcl) |
| `terraform_tfsec` | Runs tfsec using [`.tfsec.yml`](.tfsec.yml) |
| `gitleaks` | Secret detection using [`.gitleaks.toml`](.gitleaks.toml) |

> **Note:** The `modules/sub-modules/vpc_peering` module is excluded from `terraform_validate` because it declares `configuration_aliases` (provider injection from the parent) and cannot be validated in isolation. It is fully validated when the root configuration is validated.

### Files excluded from hooks

The following paths are excluded globally (kept in sync with the Gitleaks allowlist):

```
.terraform/
terraform.tfstate*
.terraform.lock.hcl
private_keys/
license_vault.*
*.tfvars
crash.log
```

---

## GitHub Actions CI

Two workflows run automatically. Both ignore changes to `**.md`, `docs/**`, `.gitignore`, and `LICENSE`.

### [`pr.yml`](.github/workflows/pr.yml) — Pull Request checks

Triggered on all pull requests regardless of target branch.

| Job | Description |
| --- | --- |
| `terraform-fmt` | `terraform fmt -check -recursive` — posts a PR comment on failure |
| `terraform-validate` | `terraform validate` across root and all modules in a matrix |
| `tflint` | `tflint --recursive` using [`.tflint.hcl`](.tflint.hcl) |
| `tfsec` | Security scan using [`.tfsec.yml`](.tfsec.yml) |
| `secrets-scan` | Gitleaks secret detection using [`.gitleaks.toml`](.gitleaks.toml) |
| `terraform-docs` | Renders and pushes updated [`README_TF_DOCS.md`](README_TF_DOCS.md) |
| `cost-estimation` | Infracost diff comment on the PR (optional, `continue-on-error: true`) |
| `pr-summary` | Aggregates all job results — fails the PR if any required job failed |

### [`main.yml`](.github/workflows/main.yml) — Main branch checks

Triggered on pushes to `main`. Runs the same core checks plus:

| Job | Description |
| --- | --- |
| `terraform-docs` | Auto-commits updated [`README_TF_DOCS.md`](README_TF_DOCS.md) with `[skip ci]` |
| `security-audit` | Posts a tfsec + Gitleaks results summary to the Actions step summary |
| `notify-failure` | Opens a GitHub Issue automatically if any job fails on `main` |
| `success-summary` | Posts a full checklist to the Actions step summary on success |

### Tool versions used in CI

| Tool | Version |
| --- | --- |
| Terraform | `1.16.0` |
| TFLint | `v0.64.0` |
| tfsec | `v1.28.0` |

---

## Submitting a Pull Request

1. Create a feature branch from `main`:
   ```bash
   git checkout -b my-feature
   ```

2. Make your changes. Ensure pre-commit hooks pass before pushing:
   ```bash
   pre-commit run --all-files
   ```

3. Format Terraform code:
   ```bash
   terraform fmt -recursive
   ```

4. Push and open a pull request against `main`. All CI jobs in [`pr.yml`](.github/workflows/pr.yml) must pass before merging.

---

PRs are welcome!
