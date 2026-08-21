# Upwind Security — GitHub Integration Demo Repo

This is a **synthetic / faux repository** built to demonstrate an end-to-end
GitHub ↔ Upwind Security integration. It is not a real product — it exists
to give the Upwind console (and any connected CI/CD pipeline) realistic
surface area to scan across every major control category:

| Category | Where it lives | What it demonstrates |
|---|---|---|
| Source Composition Analysis (SCA) | `src/python-service/requirements.txt`, `src/node-service/package.json` | Dependency graph + known-CVE detection across two ecosystems |
| Shift-left (pre-merge) scanning | `.github/workflows/ci.yml` (PR-triggered jobs) | Secrets scanning, SAST, dependency review gating a PR before merge |
| Container scanning | `Dockerfile`, `.github/workflows/container-scan.yml` | Base-image + layer vulnerability scanning, image signing step |
| IaC scanning | `terraform/`, `kubernetes/` | Misconfiguration detection (public S3, open security groups, privileged pods) |
| CI/CD pipeline integration | `.github/workflows/*.yml` | Where Upwind's CLI/action hooks into build → scan → deploy |
| Source code SCA / SBOM | `.github/workflows/sbom.yml` | CycloneDX SBOM generation and upload as a build artifact |

## Intentional "findings"

To make the Upwind console show real results, several files contain
**deliberately outdated or misconfigured** components. These are marked
with `# DEMO-FINDING:` or `// DEMO-FINDING:` comments so they're easy to
explain live and easy to strip out before this ever touches anything real:

- Pinned, older versions of Flask/requests/lodash/express with known CVEs (SCA)
- A Dockerfile built on an older, larger base image instead of a minimal/distroless one (container scanning)
- A Terraform S3 bucket without `block_public_access` and a security group open on `0.0.0.0/0` (IaC scanning)
- A Kubernetes Deployment running as root with `privileged: true` and no resource limits (IaC/K8s scanning)
- A hard-coded placeholder secret string in a config file (secrets scanning) — **not a real credential**

## How to use this for the Upwind demo

1. Push this repo to a **new, empty GitHub repository** under an account/org you control.
2. Connect that GitHub org/repo in the Upwind console (Settings → Integrations → GitHub → install the GitHub App, scope it to this repo only).
3. Let the existing GitHub Actions workflows run once (or trigger manually via `workflow_dispatch`) so Upwind has commits/PRs/pipeline runs to correlate with the scans.
4. Open a demo PR (e.g., bump a dependency) to show shift-left checks running pre-merge.
5. Walk through the Upwind console showing: code → build → image → runtime correlation, using this repo as the "code" anchor.

## Structure

```
upwind-demo-repo/
├── .github/
│   ├── dependabot.yml
│   └── workflows/
│       ├── ci.yml                # build/test + shift-left gate on PRs
│       ├── container-scan.yml    # image build + container scanning
│       ├── iac-scan.yml          # Terraform/K8s scanning
│       └── sbom.yml              # SBOM generation
├── src/
│   ├── python-service/           # Flask microservice (SCA target)
│   └── node-service/             # Express microservice (SCA target)
├── Dockerfile
├── docker-compose.yml
├── terraform/                    # IaC target (AWS)
├── kubernetes/                   # IaC target (K8s manifests)
└── .gitignore
```
