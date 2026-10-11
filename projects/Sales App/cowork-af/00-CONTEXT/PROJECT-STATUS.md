# PROJECT STATUS — SANMAR SALES APP (canonical continuation entry point)

Created 2026-10-11, revised 2026-10-11 (Phase 0B). Day 1 source-code consolidation has **not** started.

## 0. Reading rules

Evidence tags:

| Tag | Meaning |
|---|---|
| **[VERIFIED 10-11]** | Checked by git command on 2026-10-11. **Wins over any audit snapshot.** |
| **[USER 10-11]** | Stated by the project owner on 2026-10-11, not independently re-run. |
| **[AUDIT 27-Sep]** | From the Final Consolidation Audit (27 Sep 2026 snapshot), kept in the project conversation, not stored in the repo. **Not re-tested today.** |
| **[DOC: path]** | Stated by a repository document, historical. |

Status labels (one per row; "preserved" never means "approved for merge"):
`PRODUCTION` · `COMPLETE ON MAIN` · `PARTIAL` · `IMPLEMENTED / UNMERGED` · `PRESERVED / REFERENCE` · `BLOCKED BY DECISION` · `BLOCKED BY CONTENT / LEGAL / ACCEPTANCE` · `NOT STARTED` · `PHASE 2 / DEFERRED`

## 1. Purpose and authority

- Single entry point for continuing the Sales App. It indexes older documents and does not restate them.
- `00-CONTEXT/START-HERE.md`, `CURRENT-STATE.md`, `NEXT-WORKSTREAM.md` (30 Aug) are **stale** (e.g. START-HERE pins backend `eeb9db1`). They remain history only.
- Precedence: today's verified git state > Final Consolidation Audit > older documents.
- The audit says **do not repeat** broad repo discovery, module inventories, the RBAC audit, AF blocker enumeration or Figma authority discovery. Extend them only with new evidence.
- Standing rules (`cowork-af/CLAUDE.md`): preserve-first, no secrets, no fake approvals, no force-push, no deploy or migration without explicit authorization.

## 2. Production baselines and current heads

| Item | Value | Evidence |
|---|---|---|
| Frontend `main` | `c9d3a2f1521875c9428aa185ba37e20ea055173c` | **[VERIFIED 10-11]** `git ls-remote`. Whether this exact build is deployed is not re-checked. |
| Backend `main` | `eb9e48163fb8256bae6fa543b67c9eeeac625aef` | **[VERIFIED 10-11]** same. |
| Current frontend working branch | `feature/saf-inventory-transaction-foundation-v2` @ `af225f6661f76ea05c82c3884774398468a930fb`, 6 ahead of `origin/main` | **[VERIFIED 10-11]**. Preserved remotely at `preservation/frontend-saf-inventory-v2-af225f6`. |
| Current AF recovery checkpoint (backend) | `recovery/application-form-foundation-v1` @ `2f955e4913a4ebfe9b6ec726d30f86e712f4cebd` | **[VERIFIED 10-11]**, tracked tree clean. Preserved at `preservation/af-recovery-20261011`. |
| PR #11 / remote `recovery/application-form-foundation-v1` | `e9fb2d6c9cf4a748fdd09ed50f8def1399e98e9a` | **[VERIFIED 10-11]**. **Stale / review-only.** It does not contain the current AF recovery tip. It was deliberately not moved. |
| `AF_R2_LAYOUT_PREVIEW_ONLY` | `true` | **[USER 10-11]** |

Latest AF verification at `2f955e4` **[USER 10-11]**: definition spec 42/42 · AF suite 630 tests · broad backend suite 1,098 tests, exit 0 · typecheck clean · build pass · Prisma validate pass.

Stale local `main` refs (frontend clone `51e5dc3`, old backend clone `42cee9d`). **Never branch from them.**

**27 Sep audit snapshot (superseded, do not treat as current):** AF HEAD `86207e4`; frontend work HEAD `12503c6`. **[AUDIT 27-Sep]**

## 3. Working repositories and worktrees

| Role | Path | Branch @ HEAD | State **[VERIFIED 10-11]** |
|---|---|---|---|
| Backend (active AF) | `authority-h10\sanmar-sales-backend` | `recovery/application-form-foundation-v1` @ `2f955e4` | Clean. `.gp-verify-output/` untracked by design. |
| Frontend (AF line) | `authority-h10\sanmar-sales-frontend` | `work/application-form` @ `0d03811a54138c1ee9364e5e0423ce933e53d25b` | Uncommitted `D public/sanmar-s.png` (unresolved, do not commit or restore without a decision). |
| Frontend (current working) | `frontend\` | `feature/saf-inventory-transaction-foundation-v2` @ `af225f6` | Clean. 2 stashes (§4). `cowork-af/CLAUDE.md` marks it "do not touch"; Phase 0/0B only created branches. |
| Frontend (DS-v2 preview, separate clone) | `cowork-af\frontend-dsv2-preview` | `feature/dsv2-r1-operational-ui` @ `8d0d493` | Clean. |
| cowork-af frontend worktree | `cowork-af\frontend` | detached @ `3ea9264` | Preserved in Phase 0B (§4). |
| cowork-af backend worktree | `cowork-af\backend` | `ops/h1-health-endpoint` @ `9e190c4` | Tip preserved at `preservation/backend-ops-h1-health-endpoint-9e190c4` (§4). |
| Older backend clone | `backend\` | local branches, all preserved (§4) | Historical. Not a base. |

## 4. Preservation register

All pushes were new branches. No merge, force, PR, checkout, or stash applied.

| Original ref / object | SHA | Preservation / remote ref | Remote |
|---|---|---|---|
| Dangling frontend commit (dropped inventory WIP) | `11f01575c99a867e89cd32747d57b18c14df2aba` | `preservation/dropped-inventory-11f01575` | pushed. Not applied. |
| `feature/block-b2-record-drawer` | `1ea3aeac43b13a51a6169742e0059fef2c28799f` | `preservation/block-b2-record-drawer` | pushed |
| `feature/block-v2v3-verification-pages` | `b86077d4df16e0f9a2d4f4635bcda61d8b53f6d6` | `preservation/block-v2v3-verification-pages` | pushed |
| `feature/dsv2-r1-operational-ui` (DS-v2 clone) | `8d0d4933ea8781c9d2fe426e9d925472e671af49` | `preservation/dsv2-r1-operational-ui` | pushed |
| `work/application-form` (authority frontend) | `0d03811a54138c1ee9364e5e0423ce933e53d25b` | `preservation/frontend-af-work` | pushed |
| `feature/saf-inventory-transaction-foundation-v2` | `af225f6661f76ea05c82c3884774398468a930fb` | `preservation/frontend-saf-inventory-v2-af225f6` | pushed |
| `stash@{0}` pre-P4D-A1-unrelated-local-changes | `692b0f43dd10c604f62f36171ce6d4101e4767d1` | `preservation/stash-pre-p4d-a1-692b0f4` | pushed. Stash still present, not applied. |
| `stash@{1}` temp responsive validation work | `7d84fc6a1bd0895002e1fb93fec543d211a67005` | `preservation/stash-responsive-validation-7d84fc6` | pushed. Stash still present, not applied. |
| AF recovery checkpoint (backend) | `2f955e4913a4ebfe9b6ec726d30f86e712f4cebd` | `preservation/af-recovery-20261011` | pushed |
| Backend `work/application-form` | `64a80eee9ac35fd5cffd37787beb592931eb2048` | `work/application-form` | already on remote **[USER 10-11]** and seen in `ls-remote`. |
| **Phase 0B** detached `cowork-af/frontend` | `3ea9264cad7593825714798dd051187d8a1d92a6` | `preservation/frontend-saf-functional-parity-3ea9264` | pushed (not on any live remote ref before) |
| **Phase 0B** `feature/block-b1-booking-approval-overview` | `c016f0756b1d3dcaa2240ec80c2424d0c1cdd7e3` | none needed | already in remote `main` |
| **Phase 0B** `feature/block-g2-gmc-frontend` | `8c57907ca62c39c5828e08f6e72341b8115be737` | none needed | already in remote `main` |
| **Phase 0B** `feature/dashboard-refresh-2026-07-30` | `60346ebbcb84f21ab369bf9296a36e3d923d1f5b` | none needed | already in remote `main` |
| **Phase 0B** `feature/saf-inventory-transaction-foundation` (frontend) | `93959f123496c7b610e6b2f22fc89f3ed7f8109d` | none created | reachable only as base of `preservation/stash-pre-p4d-a1-692b0f4` (live remote ref). No branch of its own. |

Unresolved pre-existing local state (not committed, not deleted): `public/sanmar-s.png` deletion in the authority frontend; `.gp-verify-output/` in the authority backend.

**Phase 0B-2 — older backend clone `backend\` [VERIFIED 10-11].** After `fetch --prune`, live backend remote heads were only `main`, `recovery/application-form-foundation-v1`, `work/application-form` and `preservation/af-recovery-20261011`. None of the 16 branches below nor the stale local `main` was reachable from them, so each got a preservation branch (new, pushed, remote SHA verified equal). Preserved does **not** mean approved for merge.

| Source branch | SHA | Preservation branch |
|---|---|---|
| `arch/adm2-a3-hierarchy-capability-scope-lock` | `44067ab9f63ee2978ad421f431f04844731d1dc1` | `preservation/backend-arch-adm2-a3-hierarchy-capability-scope-lock-44067ab` |
| `ci/ops-ci1-backend-ci` | `fcc7f158d79937d2f98b5d5c9821cb30a127f7c8` | `preservation/backend-ci-ops-ci1-backend-ci-fcc7f15` |
| `feature/adm2-admin-audit-foundation` | `74c53ae49f6bec873cc165d7abe76ff984f97e0a` | `preservation/backend-feature-adm2-admin-audit-foundation-74c53ae` |
| `feature/application-form-foundation` (**DEAD / REFERENCE ONLY**, status unchanged) | `df45cea0b286d169b0f41c46fa9271830bd04e3e` | `preservation/backend-feature-application-form-foundation-df45cea` |
| `feature/block-v1-verification-backend` | `6b9b7156304e7b3d5e07ebfd8c1c490f3e605646` | `preservation/backend-feature-block-v1-verification-backend-6b9b715` |
| `feature/dp-price-revision` | `b1e01bd284ca86639f230a5af43428a8f8715ef4` | `preservation/backend-feature-dp-price-revision-b1e01bd` |
| `feature/project-content-phase-1` | `3f193b2360eb6c6c2ffe4dea5a9c117e9890c60f` | `preservation/backend-feature-project-content-phase-1-3f193b2` |
| `feature/saf-inventory-transaction-foundation` | `3ee10a0a84365b1f96284fc09cb9c4fd26a67c66` | `preservation/backend-feature-saf-inventory-transaction-foundation-3ee10a0` |
| `fix/saf-a1-ss-own-record-visibility` | `831042e2689297e28d8ba7fb88d6c6b5d2e04be9` | `preservation/backend-fix-saf-a1-ss-own-record-visibility-831042e` |
| `hotfix/gmc-total-unit-value` | `788faffd8335fac70a4dd5b0737e3ecd323efeef` | `preservation/backend-hotfix-gmc-total-unit-value-788faff` |
| `hotfix/user-select-project-content-capability` | `9afffaacc967f3c325adbdebc82297098c45abb9` | `preservation/backend-hotfix-user-select-project-content-capability-9afffaa` |
| `inv2/phase2-foundation` | `08c7504b76ec8bcbb3e219422bb767c6bd3de3de` | `preservation/backend-inv2-phase2-foundation-08c7504` |
| `ops/h1-health-endpoint` (also checked out in `cowork-afackend`) | `9e190c4755b25ac6235e185b061c407eb24d0bda` | `preservation/backend-ops-h1-health-endpoint-9e190c4` |
| `release/inv2-backend-foundation` | `1fb3d3684e5ee51d9cf1bb64b7206ffcca23a070` | `preservation/backend-release-inv2-backend-foundation-1fb3d36` |
| `release/inv2-schema-foundation` | `4069fd83f904dc7986c245d09e59a33419dd7d01` | `preservation/backend-release-inv2-schema-foundation-4069fd8` |
| `release/project-content-phase-1-clean` | `bc35cd6ab570057460ad34e284195aa4274b846d` | `preservation/backend-release-project-content-phase-1-clean-bc35cd6` |
| stale local `main` (do not branch from it) | `42cee9d19c9db8f8b250153aca3556c0df28f04f` | `preservation/backend-stale-main-42cee9d` (not an ancestor of live `origin/main`) |

## 5. Module status register

All rows below are **[AUDIT 27-Sep] — not re-tested today** unless marked otherwise. Today's git facts override.

### Frontend

| Module | Status | Note |
|---|---|---|
| Auth / Login | COMPLETE ON MAIN | |
| Global shell / navigation | COMPLETE ON MAIN | DS-v2 R0. R1 refinement `IMPLEMENTED / UNMERGED`. |
| Work Queue / Booking & Approval | PARTIAL | Functional on main; DS-v2 skin unmerged. |
| Verification Queue | PARTIAL | Functional on main; DS-v2 skin unmerged. |
| GMC / Final Approval | PARTIAL | Functional on main; DS-v2 skin unmerged. |
| SAF Detail | PARTIAL | A materially more advanced dormant candidate exists on `feature/saf-functional-parity-v1` (see `preservation/frontend-saf-functional-parity-3ea9264` for the cowork-af baseline commit `3ea9264`). |
| **SAF Edit** | **PARTIAL / FRAGMENTED, highest-risk consolidation area** | Three divergent implementations. Reconcile before choosing a canonical one. |
| SAF print / customer document | PARTIAL | Base on main; enhanced dormant variant `IMPLEMENTED / UNMERGED`. |
| Provisional Money Receipt | COMPLETE ON MAIN | Base only. Additional unmerged work exists elsewhere (e.g. `c0dc770` on `work/application-form`). |
| Inventory | PARTIAL | Functional on main; **two independent DS-v2 skins** exist. |
| Project Detail / Unit Detail | COMPLETE ON MAIN | Delta against the DS-v2 branch not fully reconciled. |
| UnitType / Floor Navigator / Unit Matrix / Present Unit | COMPLETE ON MAIN | DS-v2 skin not done. |
| Project content / media | COMPLETE ON MAIN | |
| Application Form frontend (distinct module) | NOT STARTED | In the audited state. `work/application-form` (`0d03811`) is `PRESERVED / REFERENCE` and its AF content is not an accepted module. |
| Administration | COMPLETE ON MAIN | Functionally; DS-v2 visual migration only partial. |
| Portfolio Explorer / Notification Settings | COMPLETE ON MAIN | |

### Backend

| Module | Status | Note |
|---|---|---|
| Auth / roles / permissions | COMPLETE ON MAIN | |
| Inventory · UnitType | COMPLETE ON MAIN | |
| Project content / media | COMPLETE ON MAIN | One historical post-merge-fix landing was unverified at audit time. |
| SAF core · SAF final approval / GMC · SAF document generation | COMPLETE ON MAIN | |
| Money Receipt | COMPLETE ON MAIN (base) | CSD-authority correction (`044069a`) was unmerged at audit time; it sits in the AF recovery lineage. `IMPLEMENTED / UNMERGED`. |
| DP clearance · Administrative audit · Health/ops | COMPLETE ON MAIN | Health on hardened main. |
| DP escalation | IMPLEMENTED / UNMERGED + BLOCKED BY DECISION | Intentionally inactive until `DP_ESCALATION_EFFECTIVE_FROM` is supplied. |
| AF governance, eligibility, transaction engine, PDF, revision-finalization | IMPLEMENTED / UNMERGED | Recovery lineage is the most advanced. **Not production-ready.** See §6. |
| AF external secure customer link/session (KYC) | NOT STARTED | Dormant future/reference work. |
| Dead lineage `feature/application-form-foundation` @ `df45cea` | PRESERVED / REFERENCE | **Do not resurrect or merge.** Its migration `20260830000000_application_form_foundation` must never be applied. |

Consolidation conclusions **[AUDIT 27-Sep]**: backend core on production `main` needs no consolidation action. DS-v2 R0 on frontend `main` needs none. SAF Edit must be reconciled first. The two DS-v2 R1 lineages must be reconciled, and **no third lineage may be built**.

## 6. Application Form checkpoint

- **Current backend tip `2f955e4`** ("fix(af-fe-r2): sanitize application-form definition response boundary") **[VERIFIED 10-11]**. Verification numbers in §2 **[USER 10-11]**.
- `AF_R2_LAYOUT_PREVIEW_ONLY=true`: **preview-only remains enabled. AF is NOT customer-ready.**
- PR #11 is stale and review-only (§2).
- Open gates, carried from the 21 Sep recovery docs and **not re-enumerated** (`docs/recovery/application-form-foundation-v1/06_OPEN_FINDINGS_AND_NEXT_TASK.md`; reconciliation in `04_DESIGN_STATUS_RECONCILIATION.md`):
  - Clause 7 EN wording conflict, page-model conflict, clipped-label check — BLOCKED BY DECISION.
  - BN Clause 7 legal wording, BN AF start unavailable by design — BLOCKED BY CONTENT / LEGAL / ACCEPTANCE.
  - PDF parity acceptance against the locked masters — BLOCKED BY CONTENT / LEGAL / ACCEPTANCE. Current acceptance state is not re-confirmed.
  - `DP_ESCALATION_EFFECTIVE_FROM` supply — BLOCKED BY DECISION.
  - No admin path sets `can_complete_application_forms`, so nobody can start an AF yet.
  - Production DB migration history and R2/DB bindings were never verified. A pre-deployment prerequisite.
- Still true **[DOC]**: AF is not payment-gated, one logical AF per SAF, R2 is current storage. Do not implement the Office Server / ERP boundary.

## 7. Design / Figma authority

- Figma file `bW6SJoHjNLrRUYO3XI6YE8`. Node IDs and the **V/L/P** split (visual locked / legal wording approved / PDF accepted) are in `04_DESIGN_STATUS_RECONCILIATION.md`. These three must never be collapsed.
- Typography rule: 12 pt preferred, 11 pt minimum, add pages rather than shrink; SANMAR wordmark, no tagline, no Sales App logo.
- Not re-discovered (audit rule). Figma was not opened.

## 8. Known conflicts requiring consolidation

1. **SAF Edit** — three divergent implementations (§5). Highest risk. Reconcile before choosing one.
2. **DS-v2 R1** — two independent lineages (including `feature/dsv2-r1-operational-ui` @ `8d0d493`, now preserved). Reconcile; do not create a third.
3. **Conflicting design-system documents** — `01-PLANS/design-system/SANMAR-SALES-DESIGN-SYSTEM-V2.md` vs `_design_handoff_audit/06_FIGMA_DESIGN_SYSTEM_BLUEPRINT.md` vs `06_FIGMA_DESIGN_PREPARATION_PACKAGE.md`. No document is declared authoritative here; needs a ruling.
4. **AF page-model and Clause 7** — §6.

## 9. Test and deployment evidence

- Phase 0/0B: no deploy, no database access, no migration, no stash applied, no merge.
- AF-FE-R2 verification: §2 **[USER 10-11]**.
- Earlier evidence **[DOC]**: `01_TEST_REPORT.md` (21 Sep); CI run `35544085600` on `7cbc8ab` ran `saf.service.integration.spec.ts` 4/4; `02_MIGRATION_REHEARSAL_REPORT.md` is **synthetic** only; `07_STAGING_DEPLOY_AND_ROLLBACK_PLAN.md` is for a later gate.
- SAF live R2 archive proof **[DOC: CURRENT-STATE.md]**, 30 Aug, not re-verified.

## 10. Do-not-redo register

- Phase 0 / 0B preservation is complete: do not recreate or move any `preservation/*` branch.
- Do not move PR #11 / `origin/recovery/application-form-foundation-v1` without a decision.
- No broad repo discovery, module inventory, RBAC audit, AF blocker enumeration or Figma authority discovery.
- Do not resurrect or merge `feature/application-form-foundation`; never apply its migration.
- Do not apply the stashes or cherry-pick `11f01575` without a recorded decision.
- Do not commit the `sanmar-s.png` deletion or `.gp-verify-output/`.
- Do not redesign stable SAF, Inventory, payment, archive, R2, verification, approval, ERP, Money Receipt or cancellation behavior while working on AF.
- Do not build a third DS-v2 R1 lineage.
- Do not treat preservation as approval to merge.

## 11. V1 / Phase 1 scope

Governed by the approved 3-day V1 completion strategy **[USER 10-11]** (text not stored in the repo). The module list and statuses in §5 define what Phase 1 consolidates. Backend core needs no action; frontend DS-v2 R1 and SAF Edit reconciliation are the main consolidation work; AF stays preview-only.

## 12. Phase 2 deferred scope

- **Lead Management** — PHASE 2 / DEFERRED — DO NOT TOUCH DURING V1 CONSOLIDATION.
- **Sales Presentation** — PHASE 2 / DEFERRED — DO NOT TOUCH DURING V1 CONSOLIDATION.

## 13. Exact continuation checkpoint

- Phase 0 and 0B preservation: complete (§4), including all older backend clone branches. No known unique local work remains outside a live remote ref.
- This file: updated, uncommitted (`cowork-af\00-CONTEXT` is untracked in the outer repo `D:\AIWorkspace`).
- Next: owner review and explicit Day 1 clearance. Then: choose the SAF Edit canonical implementation, reconcile the two DS-v2 R1 lineages, and cut Day 1 work from a clean branch off remote `main`. Never cut from a stale local `main`.
