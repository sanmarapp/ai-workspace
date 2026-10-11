# PROJECT STATUS — SANMAR SALES APP (canonical continuation entry point)

Created 2026-10-11, revised 2026-10-11 (Day 3 closeout). **Day 1: ENGINEERING PASS** (§2A). **Day 2: PASS** (§2B). **Day 3: V1 RELEASE-CANDIDATE PASS — NOT YET PRODUCTION DEPLOYED** (§2C).

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

## 2A. Day 1 checkpoint — ENGINEERING PASS

**Day 1: ENGINEERING PASS. V1 is NOT production-ready** (two acceptance items below are pending).

| Item | Value |
|---|---|
| Consolidated frontend branch | `v1/day1-saf-consolidation` @ `cd11282b5ba4d2b6e9b22241fcff993086293d17` (local worktree `cowork-af\frontend-v1`; 15 commits on `origin/main` `c9d3a2f`; 62 files, +9,283 / -2,960) |
| Remote preservation | `preservation/v1-day1-saf-consolidation-cd11282` → `cd11282b5ba4d2b6e9b22241fcff993086293d17` (verified on the live remote). **Preserved, not merged, not deployed, no PR.** |
| Final verification **[VERIFIED]** | `tsc -b` clean · production build pass · oxlint 0 warnings · **206/206** tests (baseline `main` was 108) · mocked-API browser functional QA pass |

**Outcome by stage**

| Stage | Result |
|---|---|
| 1A Inventory | `019291c`, `5971b14`, `12503c6` ported (relational UnitType, P3B document types; Unit Matrix / Present Unit kept dormant). Production backend supports `BROCHURE` / `FLOOR_PLAN` / `OTHER`. |
| 1B SAF functional parity | Ported selectively from `3ea9264` (never merged): shared role/status contract, flexible payment schedule, governed document/archive UI, executed uploads, Return / Cancel Booking / Mark No Sale, DP revision/waiver and submission evidence, **S18 as the routed SAF Edit**, route guards, create-from-unit, ≥20-character promo gate (production requires it; main checked 5), shared Final Decision (GMC + Director Sales, `final-decision`, lost-race refresh, non-final Defer). |
| 1C R1 visual continuation | All 7 R1 commits (`70ee312..8d0d493`) replayed; functional behaviour from 1B won in the overlap files. |

**Canonical decisions now in effect on the Day 1 branch (not on `main`)**

- **S18 (`SafFormEditS18Page`) is the canonical, routed SAF Edit.** Legacy `SafFormEditPage.tsx` (with `SalesApprovalFormPage`, `SafFormListPage`) stays in the tree **unrouted through Day 3**, as the regression reference. The legacy client-side `jsPDF/html2canvas` export is **not** reproduced; documents come from the governed archive.
- **R1 is canonical for Dashboard, Work Queue, Verification, Final Decision and Inventory.**
- **`7af8113` (old DS-v2 preview) remains `PRESERVED / REFERENCE` only.** Nothing from it ships (no preview API bridge, no `vercel.json` change; enforced by `scripts/no-preview-code.test.mjs`).
- Guard tests added: S18-vs-legacy field coverage, frontend ↔ production backend route map and role matrix (fixture from backend `eb9e481`), no-preview gate, create-flow, `saf-parity`.

**Held — not part of Day 1**

| Item | Held because |
|---|---|
| ~~Backend `044069a` + frontend `290fb5f`~~ | **Resolved in Day 2 (§2B).** Both are now incorporated into the V1 branches (unmerged). |
| `7447040` (AF Completion checkbox in User Management) | Held for AF backend availability. `can_complete_application_forms` is not in production `UpdateUserDto`; production runs `forbidNonWhitelisted`, so every user edit would return 400. |
| DP-escalation panel (`af225f6`) | Held. Production has no `GET /:id/dp-escalation`; DP escalation is intentionally inactive. |
| Lead Management · Sales Presentation | **PHASE 2 / DEFERRED — DO NOT TOUCH DURING V1 CONSOLIDATION.** |

**Remaining acceptance items — blockers to calling V1 production-ready (not reasons to undo Day 1)**

1. **R1 visual sign-off: PENDING.** DOM/functional browser QA was completed, but screenshots / rendered visual sign-off were not available (the browser pane would not draw).
2. **Real-backend role/flow QA: PENDING.** Day 1 browser QA used a **mocked API only**.

Day 1 tested history must not be amended, squashed, rebased or merged without an explicit decision.

## 2B. Day 2 checkpoint — Money Receipt authority: PASS

**Day 2: PASS.** The backend and frontend Money Receipt authority are aligned as one cross-repo change. Everything is on local V1 branches, preserved remotely, **not merged, not deployed, no PR**. V1 is still **not production-ready** (acceptance items in §2A remain pending).

| Item | Value |
|---|---|
| Backend branch | `v1/day2-money-receipt-backend` @ `bec4dbdaa8adb434f105ffb2366b49dd7590a28a` (worktree `cowork-af\backend-v1`, from production `eb9e48163fb8256bae6fa543b67c9eeeac625aef`) |
| Backend commits | `7cb89d7` = `044069a` cherry-picked cleanly (`-x`); `bec4dbd` = extra read-compatibility tests. **No schema, no migration.** |
| Backend preservation | `preservation/v1-day2-money-receipt-backend-bec4dbd` → `bec4dbdaa8adb434f105ffb2366b49dd7590a28a` (live remote verified) |
| Frontend branch | `v1/day2-money-receipt-frontend` @ `1eba47fbc865a6200c268337273db82ead7e51e4` (worktree `cowork-af\frontend-v1-day2`, from Day 1 `cd11282`) |
| Frontend commit | `1eba47f` — `290fb5f`'s approved behaviour ported **surgically** (a plain cherry-pick conflicts with the Day 1 contract/Detail restructuring) |
| Frontend preservation | `preservation/v1-day2-money-receipt-frontend-1eba47f` → `1eba47fbc865a6200c268337273db82ead7e51e4` (live remote verified). Vercel preview `dpl_9GE8aBCPptyfCdB4JQVaM3acq2DR`: **READY** (record only; preservation branch, not a deployment candidate). |

**Incorporated:** `044069a` is now in the V1 consolidated backend; `290fb5f`'s authority behaviour is now in the V1 consolidated frontend. Neither is on `main`.

**Authority contract now enforced (backend) and presented (frontend)**

- Customer signing records the signature only: no Money Receipt, no receipt number.
- Issue Receipt = CSD only. Generate Receipt Number = CSD only. ADMIN and Sales roles lose server-side issuance.
- New receipt actions only from `SUBMITTED` / `VERIFIED` / `APPROVED`; `ERP_UPLOADED` and `CSD_HANDOVER` removed.
- Unchanged: request-receipt (SS, TL, GL, HOD); send-to-CSD / signed copy (SS, CSD, ADMIN); CSD handover (SS, HOD, CSD, ADMIN, SALES_ADMIN at `ERP_UPLOADED`). Existing receipts stay readable in every status; a second issue is rejected.
- Cross-repo matrix: **11/11 rows MATCH** (creation trigger, issue roles, number roles, allowed states ×3, request roles, manage, handover, signing, `ERP_UPLOADED`).

**Verification**

| Repo | Result |
|---|---|
| Backend | Targeted Money Receipt spec **57/57** · full suite **18 suites, 386 passed, 1 todo, 0 failed** · `tsc --noEmit` clean · `nest build` pass · `prisma validate` valid. |
| Backend caveat | **4 DB-backed integration specs were excluded** (`*.integration.spec.ts`: admin-audit, inventory-phase2, project-content, saf.service). They connect to PostgreSQL at `127.0.0.1:55432`; no database was accessed. They are **not re-run** for this change (CI runs them on an ephemeral `postgres:17`). |
| Frontend | `tsc -b` clean · build pass · oxlint 0 warnings · **221/221** tests (Day 1: 206; +15 Money Receipt). Includes the Day 1 SAF parity/contract tests and the new cross-repo gate, which is itself proven by feeding it broken frontends (ADMIN or SS allowed, `ERP_UPLOADED` exposed, status-list issue panel, receipt assumed at signing). |

**Still held (unchanged):** `7447040` (AF backend dependency) · DP-escalation panel · AF backend recovery and migrations · **Lead Management / Sales Presentation: PHASE 2 / DEFERRED**.

**Still pending (blockers to calling V1 production-ready):** R1 visual sign-off; real-backend role/flow QA (all browser QA so far used a mocked API). Day 2 added no browser QA.

## 2C. Day 3 checkpoint — V1 RELEASE-CANDIDATE (NOT YET PRODUCTION DEPLOYED)

**Classification: V1 RELEASE-CANDIDATE — NOT YET PRODUCTION DEPLOYED.** Nothing is merged to `main`, deployed, or in a PR. The two RC heads must ship **together** (the frontend assumes the Day 2 Money Receipt backend authority).

| Item | Value |
|---|---|
| **Backend RC** | `v1/day3-rc-backend` @ `7d5b22a0c0c21d49353640232f1d4fbed0e80654` (worktree `cowork-af\backend-v1-day3`) = production `eb9e481` + `044069a` + Day 2 tests + one test-only guard commit. **No production-code change after Day 2; no schema or migration.** |
| Backend RC preservation | `preservation/v1-rc-backend-7d5b22a` → `7d5b22a0c0c21d49353640232f1d4fbed0e80654` (live remote verified) |
| **Frontend RC** | `v1/day3-rc-frontend` @ `48c6c4fa630a44c78027b59329c68c83c507883c` (worktree `cowork-af\frontend-v1-day3`) = Day 2 `1eba47f` + two Day 3 fix commits (`1da21d2`, `48c6c4f`) |
| Frontend RC preservation | `preservation/v1-rc-frontend-48c6c4f` → `48c6c4fa630a44c78027b59329c68c83c507883c` (live remote verified). Vercel preview `dpl_J35e5KySPLiVFx82LrY2mseSpd3P`: **READY** (record only). No Vercel deployment for the backend; no Railway deployment observed for the pushes (the Railway project hosting the Sales backend was not identified, so this is not exhaustive). |

**Day 3A — PostgreSQL-backed evidence** (fresh disposable PostgreSQL **17.10** on loopback ports 55433/55436; the existing 55432 service was **not** used):

| non-DB tests | DB-backed tests | total executed | skipped / todo | failures |
|---|---|---|---|---|
| 386 passed (18 suites) | 46 passed: SAF 4 · project-content 16 · inventory-phase2 16 · admin-audit 10 | 432 | 4 placeholders (the DB suites when the DB flag is off) + 1 todo | 0 |

`tsc --noEmit` clean · `nest build` pass · `prisma validate` valid. The earlier "386 = full suite" wording is retired: 386 is the **non-DB suite**.
Test-infrastructure change: the SAF integration guard (pinned to `127.0.0.1:55432`) now also accepts `127.0.0.1:55433/sanmar_saf_test`; loopback and database name restrictions are unchanged.
**Migration chain NOT validated:** `prisma migrate deploy` into an empty PostgreSQL 17.10 database fails at `20260816000000_add_project_onboarding_fields` (P3018, `type "ProjectType" does not exist`) after 14 migrations apply. This is the known pre-existing defect and was not repaired. As in CI, the test schema was materialised with `prisma migrate diff --from-empty`, so these runs validate the **schema and behaviour**, not the migration history.

**Day 3B — real frontend ↔ real backend QA** (no mocked `fetch`; real V1 backend on the disposable database; test-only accounts for SS, TL, GL, HOD, BPC, GMC, Director Sales, CSD, ADMIN):

- API workflow suite **123/123**: create requires `project_id` + `unit_id`; edit role protection and save→reload round trip with no field loss; flexible schedule (timeline, count, monthly amount); verification ≥20-character promo rule; final decision (first valid wins, concurrent GMC vs Director gives exactly one winner, Defer stays Verified, Director can decide after a Defer); Cancel / No Sale / Return role+state behaviour; document archive reads and team scoping; executed uploads role-gated; Money Receipt authority (customer signing creates no receipt; SS and ADMIN rejected; CSD issues in exactly SUBMITTED / VERIFIED / APPROVED; ERP_UPLOADED and other states rejected; existing receipt readable; handover and manage aligned).
- Real-UI flows driven through the browser: genuine login form; Inventory → Unit → create SAF (`POST /sales/forms` → 201 with `project_id` + `unit_id`); S18 fill, flexible schedule (10 instalments, remainder 0), save and hard reload with every field intact; Verification (`/verify`), Director Sales Final Decision (`/final-decision` → APPROVED, decider role and designation recorded); CSD generate-number and issue (real UI); per-role receipt panels (CSD: generate + issue; SS/TL: request only; ADMIN: none; none in DRAFT / RETURNED / CANCELLED / NO_SALE). No `dp-escalation` request was made.
- **Environment limits (be honest):** no Redis was installed, so a minimal in-house Redis stub supplied receipt-number `INCR` — **BullMQ queues, notification delivery and the DP-deadline processor were NOT exercised**; **R2 storage was not configured** (executed-upload requests reach the handler and are role-gated, but no file was stored or retrieved); only one team was seeded (documents are team-scoped; out-of-team 403 and in-team 200 were both checked).

**Day 3C — visual acceptance:** rendered screenshots reviewed plus a programmatic layout audit (overflow, off-screen, clipped, covered controls) of **App shell/navigation, Dashboard, Work Queue (+ record drawer, create dialog), Verification (queue + review), Final Decision (queue + review), Inventory, SAF Detail and S18 Edit at 1440px and 390px**: no horizontal overflow, clipping or overlap on any surface in the final state; R1 surfaces are visually consistent. Formal design sign-off by a human reviewer is still advisable; screenshot capture was usable but low-resolution and inconsistent in scale, so the automated audit carries much of the evidence. Screenshots and result files are kept as QA artifacts **outside every repository** (scratchpad `qa-artifacts-day3`, 29 screenshots + API results).

**Day 3 fixes (found only by real-backend and rendered review; each has a regression test):**

1. Account chip showed "Designation not set" for every user: `/auth/login` returns no `position`. The shell now reads it from `/auth/me`, resets per user, and falls back quietly. (Mock QA had hid this.)
2. Mobile drawer: the fixed toggle/close button covered the brand mark; the brand is offset in the open drawer.
3. Work Queue record drawer was a fixed 520px panel, so on a 390px phone its left 130px was off-screen; now `min(520px, 100vw)` (desktop unchanged).
4. Inventory project rows clipped the tier badge, availability count and "Open project →" on phones (fixed pixel offsets up to 597px in a 326px card); the offsets moved to a stylesheet (desktop identical, stacked layout below 640px).

**Final frontend gate:** `tsc -b` clean · build pass · oxlint **0 warnings** · **232/232** tests (221 at Day 2 + 11) including SAF parity, route/role contract, Money Receipt cross-repo authority and the no-preview-code gate. Confirmed absent: `previewApiProxy`, a donor `vercel.json` (identical to `main`), any DP-escalation request/code, any AF-completion capability, any Lead Management / Sales Presentation change.

**Day 2 Money Receipt alignment: RETAINED** (backend `044069a`, frontend authority; 11/11 contract rows still MATCH, re-proven end to end by the real-backend suite).
**R1 status:** R1 is the canonical skin for Dashboard, Work Queue, Verification, Final Decision and Inventory; it is part of the RC and visually reviewed at both widths.

**Observations (not fixed, not blockers):** (a) the receipt number reserved by "Generate number" (Redis sequence) can differ from the number on the issued receipt (computed from a database count and written back to the form) — same code on production `eb9e481`; (b) the R0 shell's decorative glow overflows by 190px under `overflow: hidden`, so a programmatic scroll can shift the shell sideways (no effect in normal use; same CSS as `main`); (c) a few text-link buttons are under 24px tall on phones ("View all", "Work Queue" back, "Open project" before the fix); (d) team-scoped document access means TL/GL/HOD cannot open documents of SAFs created outside their team (by design).

**Still outside the V1 release candidate (not completed merely because the core RC passed):** AF backend recovery and its migrations · `7447040` (AF completion checkbox, needs the AF backend) · the DP-escalation panel and `/dp-escalation` route · Lead Management · Sales Presentation (**PHASE 2 / DEFERRED**).

**Before production (not done):** merge/PR path and CI on the PRs (the CI `db-integration` job on a clean runner); deploy the two RC heads together, backend first, with production DB checks (migration status/backup — the migration chain cannot be replayed from empty); a staging smoke with **real Redis and R2** (queues, notifications, DP-deadline processor, document upload/retrieval); human visual/design sign-off; secrets and environment review.

## 3. Working repositories and worktrees

| Role | Path | Branch @ HEAD | State **[VERIFIED 10-11]** |
|---|---|---|---|
| Backend (active AF) | `authority-h10\sanmar-sales-backend` | `recovery/application-form-foundation-v1` @ `2f955e4` | Clean. `.gp-verify-output/` untracked by design. |
| Frontend (AF line) | `authority-h10\sanmar-sales-frontend` | `work/application-form` @ `0d03811a54138c1ee9364e5e0423ce933e53d25b` | Uncommitted `D public/sanmar-s.png` (unresolved, do not commit or restore without a decision). |
| **Backend (Day 3 RC)** | `cowork-af\backend-v1-day3` | `v1/day3-rc-backend` @ `7d5b22a0c0c21d49353640232f1d4fbed0e80654` | Clean. `node_modules` is a junction to `backend-v1\node_modules`. Head of the V1 backend line. |
| **Frontend (Day 3 RC)** | `cowork-af\frontend-v1-day3` | `v1/day3-rc-frontend` @ `48c6c4fa630a44c78027b59329c68c83c507883c` | Clean. `node_modules` junction to `frontend\node_modules`. Head of the V1 frontend line. |
| **Backend (Day 2 V1 line)** | `cowork-af\backend-v1` | `v1/day2-money-receipt-backend` @ `bec4dbdaa8adb434f105ffb2366b49dd7590a28a` | Clean. Own `node_modules` (isolated `npm ci`; the recovery checkout's Prisma client was not touched). |
| **Frontend (Day 2 V1 line)** | `cowork-af\frontend-v1-day2` | `v1/day2-money-receipt-frontend` @ `1eba47fbc865a6200c268337273db82ead7e51e4` | Clean. `node_modules` is a junction to `frontend\node_modules`. Supersedes Day 1 as the head of the V1 frontend line. |
| **Frontend (Day 1 consolidated)** | `cowork-af\frontend-v1` | `v1/day1-saf-consolidation` @ `cd11282b5ba4d2b6e9b22241fcff993086293d17` | Clean. Local branch, preserved remotely (§2A). `node_modules` is a junction to `frontend\node_modules`. |
| Frontend (previous working checkout) | `frontend\` | `feature/saf-inventory-transaction-foundation-v2` @ `af225f6` | Clean. 2 stashes (§4). `cowork-af/CLAUDE.md` marks it "do not touch"; Phase 0/0B only created branches. |
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
| **Day 1 consolidated frontend** | `cd11282b5ba4d2b6e9b22241fcff993086293d17` | `preservation/v1-day1-saf-consolidation-cd11282` | pushed, live remote verified |
| **Day 2 backend (Money Receipt authority)** | `bec4dbdaa8adb434f105ffb2366b49dd7590a28a` | `preservation/v1-day2-money-receipt-backend-bec4dbd` | pushed, live remote verified |
| **Day 2 frontend (Money Receipt authority)** | `1eba47fbc865a6200c268337273db82ead7e51e4` | `preservation/v1-day2-money-receipt-frontend-1eba47f` | pushed, live remote verified |
| **Day 3 backend RC** | `7d5b22a0c0c21d49353640232f1d4fbed0e80654` | `preservation/v1-rc-backend-7d5b22a` | pushed, live remote verified |
| **Day 3 frontend RC** | `48c6c4fa630a44c78027b59329c68c83c507883c` | `preservation/v1-rc-frontend-48c6c4f` | pushed, live remote verified |
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
| `ops/h1-health-endpoint` (also checked out in `cowork-af\backend`) | `9e190c4755b25ac6235e185b061c407eb24d0bda` | `preservation/backend-ops-h1-health-endpoint-9e190c4` |
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
| Work Queue / Booking & Approval | PARTIAL → **IMPLEMENTED / UNMERGED (Day 1)** | R1 skin on the Day 1 branch with create-from-unit; not on `main`. Visual sign-off pending (§2A). |
| Verification Queue | PARTIAL → **IMPLEMENTED / UNMERGED (Day 1)** | R1 skin + ≥20-char promo gate on the Day 1 branch. |
| GMC / Final Approval | PARTIAL → **IMPLEMENTED / UNMERGED (Day 1)** | R1 skin + shared GMC/Director Sales Final Decision on the Day 1 branch. |
| SAF Detail | PARTIAL | A materially more advanced dormant candidate exists on `feature/saf-functional-parity-v1` (see `preservation/frontend-saf-functional-parity-3ea9264` for the cowork-af baseline commit `3ea9264`). |
| **SAF Edit** | **IMPLEMENTED / UNMERGED (Day 1)** — was PARTIAL / FRAGMENTED | **S18 is canonical and routed on the Day 1 branch.** Legacy editor unrouted through Day 3. Not on `main`. |
| SAF print / customer document | PARTIAL | Base on main; enhanced dormant variant `IMPLEMENTED / UNMERGED`. |
| Provisional Money Receipt | COMPLETE ON MAIN (base) → **IMPLEMENTED / UNMERGED (Day 2)** | CSD-only authority on the Day 2 frontend branch, matching the Day 2 backend (§2B). `290fb5f` incorporated; `c0dc770` on `work/application-form` is separate and not ported. |
| Inventory | PARTIAL → **IMPLEMENTED / UNMERGED (Day 1)** | R1 is the canonical skin; `7af8113` is reference-only. |
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
| Money Receipt | COMPLETE ON MAIN (base) → **IMPLEMENTED / UNMERGED (Day 2)** | `044069a` incorporated into `v1/day2-money-receipt-backend` (clean cherry-pick onto production `eb9e481`, no migration). Not on `main`; not deployed. |
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

1. **SAF Edit** — **RESOLVED on the Day 1 branch (unmerged):** S18 canonical (§2A).
2. **DS-v2 R1** — **RESOLVED on the Day 1 branch (unmerged):** R1 canonical, `7af8113` reference-only (§2A). Do not create a third lineage.
3. **Conflicting design-system documents** — `01-PLANS/design-system/SANMAR-SALES-DESIGN-SYSTEM-V2.md` vs `_design_handoff_audit/06_FIGMA_DESIGN_SYSTEM_BLUEPRINT.md` vs `06_FIGMA_DESIGN_PREPARATION_PACKAGE.md`. No document is declared authoritative here; needs a ruling.
4. **AF page-model and Clause 7** — §6.

## 9. Test and deployment evidence

- Phase 0/0B: no deploy, no database access, no migration, no stash applied, no merge.
- Day 1 **[VERIFIED]**: `tsc -b` clean, build pass, oxlint 0 warnings, 206/206 tests at `cd11282`. Browser QA was DOM/functional against a **mocked API**; no screenshots; no real-backend role QA (§2A).
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
- Do not amend, squash, rebase or merge the tested Day 1 history (`cd11282`) without an explicit decision.
- Do not re-port `3ea9264`, `7447040` or the `af225f6` DP panel into the V1 lines outside their dependency gates. (`290fb5f` / `044069a` are done in Day 2.)
- Do not amend, squash, rebase or merge the tested Day 2 commits (`bec4dbd`, `1eba47f`) without an explicit decision.
- Do not ship the Day 2 frontend without the Day 2 backend (and vice versa): they are one authority change.
- Do not amend, squash, rebase or merge the tested Day 3 RC commits (`7d5b22a`, `48c6c4f`) without an explicit decision; do not deploy them without the "before production" list in §2C.
- Never point integration tests at the existing `127.0.0.1:55432` service; use a disposable cluster.
- Do not treat preservation as approval to merge.

## 11. V1 / Phase 1 scope

Governed by the approved 3-day V1 completion strategy **[USER 10-11]** (text not stored in the repo). The module list and statuses in §5 define what Phase 1 consolidates. Backend core needs no action; the frontend SAF Edit and DS-v2 R1 consolidation is **done on the Day 1 branch (unmerged)**; AF stays preview-only.

## 12. Phase 2 deferred scope

- **Lead Management** — PHASE 2 / DEFERRED — DO NOT TOUCH DURING V1 CONSOLIDATION.
- **Sales Presentation** — PHASE 2 / DEFERRED — DO NOT TOUCH DURING V1 CONSOLIDATION.

## 13. Exact continuation checkpoint

- Phase 0 / 0B preservation complete (§4). **Day 1: ENGINEERING PASS** (§2A). **Day 2: PASS** (§2B). **Day 3: V1 RELEASE-CANDIDATE PASS — NOT YET PRODUCTION DEPLOYED** (§2C).
- RC heads: frontend `v1/day3-rc-frontend` @ `48c6c4fa630a44c78027b59329c68c83c507883c`; backend `v1/day3-rc-backend` @ `7d5b22a0c0c21d49353640232f1d4fbed0e80654`. Both preserved on the remotes; nothing merged to `main`, deployed, or in a PR.
- Next: the owner decides the merge/PR and release path, then the "before production" list in §2C (CI on PRs, real Redis + R2 staging smoke, human visual sign-off, production DB checks, backend-first deploy of both heads together).
- Still held / outside the RC: `7447040`, DP-escalation panel, AF backend recovery and migrations. Phase 2: Lead Management, Sales Presentation. Legacy `SafFormEditPage.tsx` stays unrouted through Day 3.
