# AZ-104 Microsoft Azure Administrator Course

A practical, Azure-focused course for preparing for the **AZ-104: Microsoft Azure Administrator** exam. The course plan follows a 30-day progression across identity and governance, storage, compute, networking, monitoring, and final revision.

## Start here

1. Read the [30-day study plan](docs/30-DAY-STUDY-PLAN.md) and choose a pace that fits your available time.
2. Check the prerequisites and cost guidance before creating Azure resources.
3. Open the relevant module below. Begin with its concept notes, then use its lab and command references.
4. Review Microsoft's current [AZ-104 exam page](https://learn.microsoft.com/en-us/credentials/certifications/exams/az-104) before booking; objectives and exam details can change.

## Course map

### Daily modules

| Days | Module folders |
|---|---|
| 1–6 | [Module 1](Module-1/README.md) · [Module 2](Module-2/README.md) · [Module 3](Module-3/README.md) · [Module 4](Module-4/README.md) · [Module 5](Module-5/README.md) · [Module 6](Module-6/README.md) |
| 7–11 | [Module 7](Module-7/README.md) · [Module 8](Module-8/README.md) · [Module 9](Module-9/README.md) · [Module 10](Module-10/README.md) · [Module 11](Module-11/README.md) |
| 12–18 | [Module 12](Module-12/README.md) · [Module 13](Module-13/README.md) · [Module 14](Module-14/README.md) · [Module 15](Module-15/README.md) · [Module 16](Module-16/README.md) · [Module 17](Module-17/README.md) · [Module 18](Module-18/README.md) |
| 19–23 | [Module 19](Module-19/README.md) · [Module 20](Module-20/README.md) · [Module 21](Module-21/README.md) · [Module 22](Module-22/README.md) · [Module 23](Module-23/README.md) |
| 24–30 | [Module 24](Module-24/README.md) · [Module 25](Module-25/README.md) · [Module 26](Module-26/README.md) · [Module 27](Module-27/README.md) · [Module 28](Module-28/README.md) · [Module 29](Module-29/README.md) · [Module 30](Module-30/README.md) |

These 30 folders are the only course sequence. Existing lessons, labs, notes, PowerShell scripts, and quick references have been moved into the relevant day folders. See the [content audit](CONTENT-AUDIT.md) for per-day material status and missing lab components. Supplemental legacy references are grouped inside Day 28 and the relevant day folders.

## How lessons are organized

Use the course plan for the daily sequence. In each module, follow the available theory, lab notes, exercises, and quick reference. The [module template](MODULE-TEMPLATE.md) defines the full instructor-led lesson structure: definition, purpose, components, architecture, workflow, Portal, CLI, safe lab, DevOps use case, troubleshooting, mistakes, exam focus, interview questions, practice questions, revision notes, and a short AWS comparison.

Some day folders still share cross-day lab material or need dedicated lessons and exercises. The content audit identifies those gaps; do not treat an outline as a completed deep-dive lesson.

## Lab safety

- A Free or student subscription does not make every service or configuration free. Check current prices, regional availability, quotas, and eligibility before deploying.
- Use a dedicated lab resource group, least privilege, and tags such as `Purpose=AZ104-Lab`.
- Restrict public access. For SSH or RDP, allow only your current IP and remove the rule after testing.
- Budgets and alerts notify you; they do not guarantee automatic spending caps.
- Delete the resource group after each lab and check for remaining disks, snapshots, public IPs, storage, registries, Log Analytics data, and backup items.
- Never put credentials, access keys, or SAS tokens in notes or source control.

## Useful resources

- [30-day study plan](docs/30-DAY-STUDY-PLAN.md)
- [Quick start](docs/QUICK-START.md)
- [Start here](docs/START-HERE.md)
- [Microsoft Learn: AZ-104](https://learn.microsoft.com/en-us/credentials/certifications/exams/az-104)
- [Azure CLI documentation](https://learn.microsoft.com/en-us/cli/azure/)