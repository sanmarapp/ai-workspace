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

## 2D. Day 4 checkpoint — isolated RC environment (PARTIAL: R2, Vercel pairing and human sign-off outstanding)

**Classification: RC STAGING PARTIAL.** The isolated Railway RC environment is built, deployed from the exact RC SHA and passing a real-Redis smoke. Real **R2** is *not* tested (no safe non-production R2 existed and none could be provisioned with an authorised tool). The Vercel preview is *not* yet paired (the connected Vercel identity cannot manage project env vars). **Human visual sign-off: PENDING OWNER/HUMAN SIGN-OFF.** Production and existing staging were not touched. No PR opened, nothing merged, nothing deployed to production.

| Item | Value |
|---|---|
| Backend deploy ref | `rc/v1-backend-7d5b22a` → `7d5b22a0c0c21d49353640232f1d4fbed0e80654` (new branch; remote SHA verified equal to `preservation/v1-rc-backend-7d5b22a`). Not a preservation ref. |
| Frontend deploy ref | `rc/v1-frontend-48c6c4f` → `48c6c4fa630a44c78027b59329c68c83c507883c` (new branch; remote SHA verified equal to `preservation/v1-rc-frontend-48c6c4f`). No code commits were made. |
| Railway | project `sanmar-meeting-system`, **new EMPTY environment `sales-v1-rc`** (id `23a4d6f2-17fe-4bec-9d38-47646735655d`; created empty, not a duplicate of production/staging, so no variables or services were copied). |
| RC API | **new service `sanmar-sales-api-rc`** (not the existing `sanmar-sales-api` service id, so nothing can reach production/staging config). Source `sanmarapp/sanmar-sales-backend`, branch `rc/v1-backend-7d5b22a`, **pinned to commit `7d5b22a0…`**. Railpack; pre-deploy `npm run prisma:migrate:prod`; healthcheck `/api/v1/health` (120 s). Domain `https://sanmar-sales-api-rc-sales-v1-rc.up.railway.app`. Pinned-commit deployments: `afb3b4d0…` then `1a1aab0d…` (same SHA, after the CORS variable change). |
| RC Postgres | `Postgres-7RHD`, image `postgres-ssl:18`, **server 18.6**, own volume. |
| RC Redis | `Redis-kp3e`, image **`redis:8.2.9`** (pinned from the template's `8.2`), own volume. |
| Isolation proof (from configuration, no secrets) | In the RC API's resolved environment: `DATABASE_URL` host = `postgres-7rhd.railway.internal` (the RC Postgres private domain), `REDIS_URL` host = `redis-kp3e.railway.internal`; both services exist **only** in `sales-v1-rc`. `JWT_SECRET` is a Railway-generated 64-char value unique to RC. `WALINKO_*` and `R2_*` unset. `NODE_ENV=production`. `ALLOWED_ORIGINS` = one exact origin (see below). |
| Production / staging | Verified unchanged afterwards: production's latest sales-api deployment is still `d094c4e3` (`eb9e481`); staging's is still `392fc7cc` (`788faff`). Production `/api/v1/health` still 200. |

**RC bootstrap exception — not the permanent migration-history remediation.** The fresh RC database was *not* built by replaying the (known-incomplete) migration chain. Procedure, RC database only: (1) `prisma migrate diff --from-empty --to-schema-datamodel` generated the full schema SQL (35 tables, 20 enums) with the RC's pinned Prisma 5.22.0; (2) applied it to the empty RC database (verified empty first); (3) applied a **supplement** for objects `migrate diff` cannot express and that a plain "mark as applied" would have silently omitted, sliced verbatim from the historical migrations: the `pgcrypto` extension, the partial unique index `saf_document_versions_one_pending_per_type_key`, the 5 document-archive CHECK constraints plus `recovery_attempts` CHECK, the `enforce_saf_document_archive_invariants()` function and its trigger, and the 12 `NotificationSetting` seed rows (migrations `20260829020000`, `20260829030000`, `20260813000000`). The `UPDATE` backfills in `20260828000000` / `20260828010000` are no-ops on an empty database and were deliberately not applied; (4) `prisma migrate resolve --applied` for all **31** historical migrations in canonical order (one call hit a transient P1002 and was retried, so that single ledger row is not in canonical `started_at` order — cosmetic); (5) `migrate status` → "Database schema is up to date!"; (6) drift comparison → **one cosmetic difference only**: PostgreSQL stores the `Project.id` default as `(gen_random_uuid())::text`, the schema text is `gen_random_uuid()::text` (same expression; no other difference); (7) `migrate deploy` → "No pending migrations to apply" (31 found), and the Railway **pre-deploy gate printed the same** on the real deployment. The ledger holds 31 rows, all finished. Nothing was run against production or staging.

**Deployment checks (real RC):** build success; pre-deploy no-op; healthcheck passes (`{"success":true,"status":"ok"}`); 1/1 replica running, 0 crashed, 0 failures; PrismaService "Database connected"; RedisService "Redis connected".

**Real Redis / BullMQ (Redis 8.2.9):**
- Receipt numbering through real Redis `INCR` (key `ptm:sales:receipt_seq:RCV1:2026`): sequential, idempotent per SAF, and **persisted across both an API restart and a Redis restart** (value 3 retained). Transient `RedisService` errors during the few seconds Redis was down, then automatic reconnect; no API crash.
- Three queues exist and their workers are attached: `dp-deadline`, `erp-overdue`, `saf-document`. Approval schedules an `erp-overdue` delayed job; approving a SAF carrying a `dp_completion_date` registered `dp-reminder-<formId>` and `dp-breach-<formId>` as **delayed jobs** in real Redis (they persisted across the Redis restart). **There is no cron-style repeatable DP job in this RC**; the DP deadline mechanism is delayed per-form jobs.
- Notification path: with phone numbers set on synthetic test users, SAF events reached `WalinkoService`, which logged **"Walinko not configured"** and returned without any HTTP call (supported disabled mode, no code change). No real message can be sent.
- `saf-document` generation jobs are consumed by the worker and fail with `ENOTFOUND sanmar-docs..r2.cloudflarestorage.com` (empty R2 account/bucket) and retry with backoff. This is the expected effect of the R2 gap, and proves nothing external was contacted.

**Core V1 smoke on the real RC backend (synthetic `@rc-test.invalid` users, one test project/units, created through the real admin API):** 63/63 checks — login (9 roles + wrong password), Inventory → Create SAF, S18 save → reload with no field loss, submit with evidence, Verification (BPC; SS/GMC refused), Final Decision (GMC; SS/BPC refused; second decision refused), Money Receipt (all non-CSD roles refused for issue and number; CSD issues in SUBMITTED / VERIFIED / APPROVED; second issue refused; customer signing creates no receipt; CSD refused in CUSTOMER_SIGNED), documents listing. Follow-up phases: DP jobs 12/12, post-restart numbering 11/11.

**R2: NOT TESTED — manual owner action required.** Railway buckets are not Cloudflare R2, so none was substituted; no Cloudflare tool/login is available here; production R2 credentials/bucket were never used. Required: create a **dedicated non-production R2 bucket + a bucket-scoped S3 API token**, then set on `sanmar-sales-api-rc` in `sales-v1-rc` only: `R2_ACCOUNT_ID`, `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`, `R2_BUCKET_NAME`. Then run: upload, metadata persistence, signed/read URL, retrieval + SHA-256 comparison, unauthorised-role denial, and `saf-document` generation. (The executed-document upload request reached the handler and returned 400 on a missing `source_document_id`; this is validation, not an R2 result.)

**Frontend ↔ backend pairing — Vercel preview NOT yet paired.** The existing READY preview `dpl_J35e5KySPLiVFx82LrY2mseSpd3P` was built from `preservation/v1-rc-frontend-48c6c4f` with whatever Preview-scoped `VITE_API_URL` the project has (unreadable: the connected Vercel identity returned 403 for listing and creating project env vars; no Vercel CLI here). The frontend falls back to `http://localhost:3000` (never production) when the variable is absent. **Manual owner action:** in Vercel project `sanmar-sales-frontend` add `VITE_API_URL=https://sanmar-sales-api-rc-sales-v1-rc.up.railway.app`, target **Preview only**, git branch **`rc/v1-frontend-48c6c4f`** (do not touch Production), let it build, then set `ALLOWED_ORIGINS` on `sanmar-sales-api-rc` to that preview's **exact** origin. No `previewApiProxy`, no donor `vercel.json` (the repo's `vercel.json` is the SPA rewrite only, identical to `main`).
**Substitute evidence (not a replacement for the Vercel preview):** the exact `48c6c4f` source was built locally with `VITE_API_URL` = the RC domain (bundle contains only the RC domain; no production domain anywhere) and served on `http://localhost:4173`; the RC backend's `ALLOWED_ORIGINS` is currently exactly `http://localhost:4173` (verified: allowed origin gets `access-control-allow-origin`, an arbitrary origin gets none). The app's first API requests (`/auth/me`, `/sales/forms`) went to the RC domain with **zero** requests to `sanmar-sales-api-production`. Dashboard, Work Queue and Inventory rendered real RC data with the designation shown correctly, and no console errors after the backend redeploy settled.

**Human visual sign-off: PENDING OWNER/HUMAN SIGN-OFF.** Required screens, desktop and mobile: Dashboard, Work Queue, Verification, Final Decision, Inventory, SAF Detail, S18 Edit, Money Receipt. Not self-approved.

**Observations (not fixed):** (a) the receipt-number reservation vs issued-number difference recorded in §2C was **reproduced on real Redis**: a reserved `…0003` became `…0004` at issue because issue recomputes from a DB count and writes it back; the `@unique` constraint held and no duplicate receipt exists (same code as production `eb9e481`). **RESOLVED in the RC by the §2E fix (`12d8a7d`); production `eb9e481` still has the old behaviour until the fix ships.** (b) The RC Postgres/Redis TCP proxies used for bootstrap and inspection were **removed** afterwards; no public database endpoint remains.

**Resources created that should later be deleted (they incur Railway cost):** environment `sales-v1-rc` and everything in it — services `sanmar-sales-api-rc`, `Postgres-7RHD`, `Redis-kp3e` and their volumes; branches `rc/v1-backend-7d5b22a`, `rc/v1-frontend-48c6c4f` (keep until the PR gate is closed); any Vercel branch env var added by the owner. Local-only scratch (scripts, synthetic-credential file, local build) is outside every repository.

**Remaining before the PR gate:** R2 bucket + credentials and the R2 smoke; the Vercel branch variable, preview build, exact-origin CORS and a re-run of the first-request proof on the real preview; human sign-off; owner decision on observation (a).

## 2E. Receipt-number RC fix gate — RECEIPT RC FIX: PASS

**Owner decision:** the §2C/§2D receipt-number mismatch is a **V1 blocker**. Approved invariant: *if a receipt number has been generated/reserved for a SAF, issuing the receipt must reuse that exact number; issuance must never silently replace a number already presented.* The fix is **accepted as RECEIPT RC FIX: PASS**. Nothing was merged, no PR was opened, production and staging were not touched.

| Item | Value |
|---|---|
| **Corrected backend RC** | `12d8a7d081ac24a231dd4820517cc06a9f25249b` on branch `v1/rc-fix-receipt-number-consistency` (worktree `cowork-af\backend-v1-day3`), built on the original Day-3 backend RC `7d5b22a0c0c21d49353640232f1d4fbed0e80654` |
| Commits | `cb6e841` fix (`fix(saf): one canonical money receipt number; issue reuses the reserved number`) + `12d8a7d` test-only (`test(saf): reserved-but-unissued receipt numbers are never allocated again`). **No schema or migration change.** |
| Preservation | `preservation/v1-rc-receipt-number-fix-12d8a7d` → `12d8a7d081ac24a231dd4820517cc06a9f25249b` (live remote verified) |
| Deployment ref | `rc/v1-backend-12d8a7d` → `12d8a7d081ac24a231dd4820517cc06a9f25249b` (live remote verified). `rc/v1-backend-7d5b22a` and `preservation/v1-rc-backend-7d5b22a` were **not moved**: both the original and the corrected RC stay on record. |
| Railway | environment `sales-v1-rc`, service `sanmar-sales-api-rc`, deployment `fac1b784-dac5-45ef-a017-0de7f518611e` (SUCCESS, deployed commit exactly `12d8a7d…`; build ok; pre-deploy "31 migrations found… No pending migrations to apply"; health 200; 1/1 running, 0 crashed; real RC Redis and Postgres connected; BullMQ workers attached). The RC database was **not** re-baselined. |

**Root cause.** `generateReceiptNumber` reserved a number from the Redis sequence and stored it on `SalesApprovalForm.receipt_number`, but `issueReceipt` ignored it and recomputed `COUNT(non-deleted receipts) + 1` from the database, then overwrote the form's number. Two independent generators, so a presented number could be replaced at issue. Related defects removed: the count excluded soft-deleted receipts while the unique constraint did not; racing issues surfaced raw unique-violation 500s; two concurrent generates on one SAF could present a number that was then replaced.

**Fix (one canonical allocation path, Redis sequence kept).** `reserveReceiptNumber` reuses the number already on the SAF, otherwise draws one from the Redis sequence and claims it atomically (`UPDATE … WHERE receipt_number IS NULL`); `allocateReceiptNumber` skips any number already present on a `MoneyReceipt` (including soft-deleted) **or on any SAF's `receipt_number`** (reserved-but-unissued) and fast-forwards a lagging/lost counter via the new atomic `RedisService.raiseCounterTo()`; `issueReceipt` no longer generates or rewrites a number, and a unique violation maps to 400 "already issued" (if the SAF already has a receipt) or a clear 409. `MoneyReceipt.receipt_number` / `form_id` uniqueness remains the final guard. A lost claim race leaves a harmless one-number gap. The unused `MoneyReceiptSequence` table and the dead `SafFormNumberService.generateReceiptNumber` (`SPL-MR-…`, no callers) were **not** touched.

**Test evidence (local, before deploy).** New unit spec 18 (stateful fakes with real interleaving) · new real-PostgreSQL 17.10 integration spec 10 (12-way concurrency on one SAF, 10 SAFs in parallel, counter reset, soft-deleted numbers, reserved-only numbers) · existing Money Receipt authority spec 57 (only gained two mock primitives; no assertion changed) · full non-DB suite 400 passed (386 + 14 at `cb6e841`) · the four existing DB suites 46 (SAF 4, project-content 16, inventory-phase2 16, admin-audit 10) · `tsc --noEmit`, `nest build`, `prisma validate` clean. **Mutation-checked:** with the reservation lookup removed, 3 new unit tests and all 3 new DB tests fail; restored, all pass.

**Live RC validation — 35/35 checks passed** (real RC Redis 8.2.9 + RC Postgres 18.6; test-only SAFs; evidence file kept outside every repository, no secrets):
- **Generate → Issue preserves the exact reserved number** (`…0006` generated, `…0006` issued; form and receipt both carry it).
- **Repeated generate consumes no additional sequence** (counter 5 → 6 → 6; same number returned).
- **Direct issue allocates once** (`…0007`, counter 6 → 7); a retried issue returns 400 and allocates nothing.
- **Historical issued numbers are skipped:** the RC held `0001`–`0004` (`0004` issued by the old DB-count rule) with the Redis counter at 3; the new allocator skipped `0004` and gave `…0005`.
- **Reserved-but-unissued SAF numbers are skipped:** SAF R1 reserved `…0009` unissued; with the counter set exactly one behind it, SAF R2 skipped it (`…0010`); after a full counter reset to 0, SAF R3 still got an unused number (`…0011`); R1 kept `0009`.
- **API restart preserves the reservation through PostgreSQL:** after restarting only the RC API (fresh process confirmed in logs), `0009` was still on R1; issuing it returned exactly `…0009` and consumed no sequence value; a new SAF got an unused `…0013`.
- **Redis restart preserves the sequence through the RC-only volume:** after restarting only the RC Redis (RC-only service and volume; nothing outside `sales-v1-rc` affected), Redis was back healthy within ~10 s, still 8.2.9, counter 13 retained.
- **Allocator stays safe with the counter artificially behind:** counter forced to 1 after the Redis restart, a new SAF got an unused `…0014` and the counter moved forward; 14 numbers across 14 SAFs, no duplicates; every issued receipt equals its SAF's reserved number.
- **CSD authority and the allowed-state contract are unchanged:** CSD generates/issues; SS and ADMIN are refused (403) on both issue and generate, allocating nothing; new receipt actions work only in SUBMITTED / VERIFIED / APPROVED, and DRAFT, CUSTOMER_SIGNED and CANCELLED return 400 on generate and issue and consume no number (the other four states are covered by the unit spec).
- Logs: only intended 4 × 403 and 7 × 400, the known no-R2 `saf-document` retries and the brief Redis-restart reconnect errors; no 5xx.
- **Production / staging untouched:** production's latest sales-api deployment is still `d094c4e3` (`eb9e481`); staging's is still `392fc7cc` (`788faff`). Only the RC API service's source was changed (staged, RC environment only); the temporary RC Redis TCP proxy was removed afterwards.

**Safety note (production Railway access).** During this gate a single `railway run -e production` command was used **only to print the environment name**; it did not connect to or query any database or Redis and modified nothing. **Do not use `railway run -e production` again during RC work.** Production and staging inspection must remain **read-only** (describe/list tools only); any RC data or Redis manipulation must go through a helper that refuses to run unless the environment is `sales-v1-rc`.

**Still outstanding (unchanged by this gate):**
- **R2 is still not configured in the RC** (needs a dedicated non-production bucket + bucket-scoped token set on `sanmar-sales-api-rc`; R2 smoke not run).
- **Vercel RC frontend pairing is still pending** (branch-scoped `VITE_API_URL` for `rc/v1-frontend-48c6c4f`, preview build, exact-origin CORS, first-request proof on the real preview).
- **Human visual sign-off is still PENDING OWNER/HUMAN SIGN-OFF.**
- **No PRs opened; nothing merged; no production deployment.** The production backend still runs `eb9e481` with the old receipt-number behaviour; the corrected backend `12d8a7d` ships only through the release gates (it supersedes `7d5b22a` as the backend RC; the frontend RC `48c6c4f` is unchanged).

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
| **Day 4 backend RC deploy ref** (deployment-oriented, *not* a preservation ref) | `7d5b22a0c0c21d49353640232f1d4fbed0e80654` | `rc/v1-backend-7d5b22a` | pushed, live remote verified; Railway `sales-v1-rc` is pinned to this commit |
| **Day 4 frontend RC deploy ref** (deployment-oriented, *not* a preservation ref) | `48c6c4fa630a44c78027b59329c68c83c507883c` | `rc/v1-frontend-48c6c4f` | pushed, live remote verified; intended branch for the RC Vercel preview |
| **Corrected backend RC (receipt-number fix)** | `12d8a7d081ac24a231dd4820517cc06a9f25249b` | `preservation/v1-rc-receipt-number-fix-12d8a7d` | pushed, live remote verified (§2E). Original `preservation/v1-rc-backend-7d5b22a` untouched. |
| **Corrected backend RC deploy ref** (deployment-oriented, *not* a preservation ref) | `12d8a7d081ac24a231dd4820517cc06a9f25249b` | `rc/v1-backend-12d8a7d` | pushed, live remote verified; Railway `sales-v1-rc` / `sanmar-sales-api-rc` is pinned to this commit. `rc/v1-backend-7d5b22a` was not moved. |
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
- Do not repoint production or existing staging to the RC; the RC lives only in Railway environment `sales-v1-rc` (§2D).
- The RC database baseline is an **RC bootstrap exception**, not the permanent migration-history remediation; do not apply it to production or staging, and do not mark it as fixing the chain.
- Never reuse production R2 credentials or the production bucket for RC testing; never copy production secrets into `sales-v1-rc`.
- Do not amend, squash, rebase or merge the tested receipt-number fix commits (`cb6e841`, `12d8a7d`) without an explicit decision; do not move `rc/v1-backend-7d5b22a` or `rc/v1-backend-12d8a7d`. The corrected backend RC is `12d8a7d` (§2E); do not ship `7d5b22a` or the old DB-count receipt numbering.
- **Do not use `railway run -e production` (or any production/staging command that resolves their variables) during RC work.** Production and staging inspection stays read-only (describe/list); any RC data or Redis manipulation goes through a helper that refuses to run unless the environment is `sales-v1-rc` (§2E safety note).

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
- **Day 4 (§2D): RC STAGING PARTIAL.** Isolated Railway environment `sales-v1-rc` is live on backend RC `7d5b22a` (own Postgres 18.6, Redis 8.2.9; real-Redis smoke green; core 63/63). Outstanding manual items: dedicated R2 bucket + credentials (R2 untested), Vercel branch-scoped `VITE_API_URL` + preview build + exact-origin CORS, human visual sign-off (**PENDING OWNER/HUMAN SIGN-OFF**). No PR opened, nothing merged, production and staging untouched. PRs only after those are green.
- **Receipt-number fix gate (§2E): RECEIPT RC FIX: PASS.** Corrected backend RC is **`12d8a7d081ac24a231dd4820517cc06a9f25249b`** (preservation `preservation/v1-rc-receipt-number-fix-12d8a7d`, deploy ref `rc/v1-backend-12d8a7d`), deployed to `sales-v1-rc` / `sanmar-sales-api-rc` as deployment `fac1b784-dac5-45ef-a017-0de7f518611e`; 35/35 live checks passed; no schema or migration change. It supersedes `7d5b22a` as the backend RC; frontend RC `48c6c4f` is unchanged. Still pending: R2 (not configured in the RC), Vercel RC frontend pairing, human visual sign-off. No PRs, no merge, no production deployment.
