# Architecture Decisions — pauseo.app

## Purpose

This document records current architecture and product-scope decisions.

The project is not yet in technical architecture mode. Do not overdesign.

Architecture should serve the MVP product loop:

> craving → micro-action → trigger log → no-shame recovery → local insight

## Decision status labels

- `Accepted` — current decision.
- `Deferred` — intentionally not decided yet.
- `Rejected for MVP` — should not be built in v0.1.
- `Needs review` — revisit later with evidence.

---

# ADR-001 — Local-first MVP

## Status

Accepted

## Decision

v0.1 will be local-first.

No backend will be built in MVP.

## Rationale

The app handles sensitive health-adjacent data:
- cravings,
- slips,
- nicotine use,
- emotional triggers,
- stress contexts.

The MVP can validate the core product loop without a server.

Local-first reduces:
- privacy risk,
- legal complexity,
- infrastructure cost,
- delivery complexity,
- App Store disclosure risk,
- Claude Code context complexity.

## Consequences

Allowed:
- local storage,
- local notifications,
- local trigger summaries,
- local settings.

Not allowed in v0.1:
- AWS,
- API,
- remote database,
- account creation,
- cloud sync,
- remote push notifications.

---

# ADR-002 — No AWS in MVP

## Status

Accepted

## Decision

Do not introduce AWS infrastructure at this stage.

## Rationale

AWS does not help validate the key MVP question:

> Does the craving flow help the user take one useful action and log a trigger?

Adding AWS would increase:
- architecture scope,
- privacy obligations,
- operational complexity,
- cost monitoring,
- security concerns,
- development time.

## Revisit when

Only revisit if the product has validated user value and needs:
- encrypted sync,
- optional account,
- cross-device support,
- remote content updates,
- backup/restore.

---

# ADR-003 — No account in v0.1

## Status

Accepted

## Decision

v0.1 does not require login or account creation.

## Rationale

Account creation adds friction before the user experiences value.

It also adds privacy and security obligations.

## Consequences

The user can start using the app immediately.

Data remains on device.

---

# ADR-004 — No AI coach in MVP

## Status

Rejected for MVP

## Decision

Do not build an AI coach, therapist chatbot, or LLM-powered conversation in v0.1.

## Rationale

An AI coach would add:
- safety risk,
- medical/therapy boundary risk,
- privacy risk,
- prompt complexity,
- cost,
- unclear MVP value,
- potential overclaiming.

The MVP needs micro-interventions, not open-ended coaching.

## Revisit when

Only after:
- core loop is validated,
- privacy model is mature,
- safety policies are defined,
- medical boundaries are reviewed,
- clear use case exists.

---

# ADR-005 — No medication/NRT module in MVP

## Status

Accepted

## Decision

v0.1 will not include medication, NRT, bupropion, varenicline, or cytisine guidance.

## Rationale

Medication support requires clinical accuracy, localization, contraindication awareness, and professional context.

MVP should avoid medical advice.

## Allowed

General safe copy:

> “Jeśli rozważasz leki lub nikotynową terapię zastępczą, skonsultuj się z lekarzem lub farmaceutą.”

## Not allowed

- dosing,
- treatment schedules,
- product recommendations,
- user-specific medication advice.

---

# ADR-006 — Trigger intelligence is local and simple

## Status

Accepted

## Decision

Trigger intelligence in v0.1 is a simple local summary derived from user logs.

## Rationale

The product needs useful pattern recognition, not predictive analytics.

## MVP trigger intelligence

Show:
- top triggers,
- recent trigger frequency,
- actions that helped,
- risky contexts if logged.

## Not in MVP

- relapse prediction score,
- ML model,
- risk classification,
- clinical dependence score,
- cloud analytics.

---

# ADR-007 — Progress is learning, not punishment

## Status

Accepted

## Decision

Progress UI should focus on learning and recovery rather than perfection.

## Rationale

Shame can make relapse worse and reduce return behavior.

## Consequences

Allowed:
- cravings logged,
- actions tried,
- top triggers,
- returns after slips,
- nicotine-free or reduced-use days if user selected that mode.

Avoid:
- harsh streak reset,
- red failure states,
- “you lost everything” copy,
- leaderboards,
- comparison.

---

# ADR-008 — Notifications are local, sparse, and privacy-aware

## Status

Accepted

## Decision

v0.1 uses local notifications only.

## Rationale

Local notifications are enough to test reminders without backend infrastructure.

## Rules

Notifications must be:
- opt-in,
- user-controlled,
- low frequency,
- calm,
- lock-screen safe.

## Not allowed

- remote push,
- shame messages,
- excessive reminders,
- explicit sensitive lock-screen text.

---

# ADR-009 — Documentation-first workflow

## Status

Accepted

## Decision

Product docs are the source of truth before code.

## Rationale

The project has clear constraints. Claude Code should execute against documented decisions, not invent product scope.

## Consequences

Before implementation:
- update docs if product decisions change,
- check `CLAUDE.md`,
- check MVP scope,
- identify contract drift.

---

# ADR-010 — iOS-first, but no technical stack details yet

## Status

Accepted

## Decision

The product is iOS-first.

Detailed app architecture is intentionally deferred until implementation starts.

## Rationale

Premature architecture may distract from product validation.

## Allowed now

- product docs,
- UX flows,
- backlog,
- privacy/safety rules,
- conceptual data model.

## Deferred

- SwiftUI architecture,
- persistence layer choice,
- navigation architecture,
- design system implementation,
- testing framework,
- analytics implementation,
- deployment pipeline.

---

# ADR-011 — v0.1 language is Polish only

## Status

Superseded — see "Update" below.

## Decision

v0.1 originally shipped in Polish only.

Bilingual copy (Polish + English or other languages) was deferred until user validation was complete.

## Rationale

The initial target persona is a Polish-speaking adult.

Shipping one language reduces:
- copy complexity,
- translation overhead,
- UX inconsistency risk,
- scope creep before validation.

## Consequences (original)

All in-app copy, onboarding, notifications, and UX text in v0.1 should be Polish.

English-language strings were permitted only in:
- developer-facing code comments (where necessary),
- internal documentation,
- code identifiers.

## Update — Phase 1 PL/EN (approved)

Full PL/EN localization is now approved, explicit scope and has been implemented.

What changed:
- All user-facing copy (onboarding, Home, craving flow, slip recovery, guided loop, support cards and their fallback, Privacy & Safety, and the disconnected DailyCheckIn/Progress placeholders) is now available in Polish and English via a native String Catalog (`Pauseo/Localizable.xcstrings`), source language English, fallback to English for unsupported device languages.
- Enum `rawValue`s (`NicotineType`, `GoalMode`, `TriggerCategory`), the literal micro-action/context/recovery-action arrays, and `support_cards.json` card text remain unchanged Polish values — they are stored data, not just presentation. Only the on-screen presentation of these values is localized (looked up dynamically against the same catalog), so existing and newly created events keep writing the same Polish strings regardless of device language.
- No account, backend, sync, or settings-level language picker was added. Language selection uses only the standard iOS per-app language mechanism (Settings → Pauseo → Language).

See `docs/Current_State.md` for implementation detail and `docs/QA_Checklist_v0.1.md` section 15 for the pending physical-device PL/EN QA pass.

## Revisit when

Not applicable for PL/EN — this is now shipped. A future ADR would be needed only if additional languages beyond Polish/English are considered.

---

# ADR-012 — iPhone-only distribution for v0.1

## Status

Accepted

## Decision

`TARGETED_DEVICE_FAMILY` is set to `1` (iPhone only). iPad is not a supported device family in v0.1.

## Rationale

The product is designed and tested exclusively for iPhone-sized, one-handed, in-the-moment use (`docs/Product_MVP.md`, `docs/UX_Principles.md`). No screen has an iPad-adapted layout, and no QA pass (`docs/QA_Checklist_v0.1.md`) has run on iPad. Including iPad in the device family without adapting for it also fails Apple's App Store binary validation unless the app either supports all interface orientations on iPad or declares `UIRequiresFullScreen` — confirmed locally as a build warning ("All interface orientations must be supported unless the app requires full screen") during a Release archive while iPad was still included.

## Consequences

- The app is not installable on iPad from TestFlight or the App Store.
- No iPad-specific layout work is needed for v0.1.

## Revisit when

A future product decision explicitly scopes iPad support, with layout adaptation and QA to match.

---

# ADR-013 — Privacy Manifest and export compliance for distribution

## Status

Accepted

## Decision

`Pauseo/PrivacyInfo.xcprivacy` declares `NSPrivacyAccessedAPICategoryUserDefaults` with reason `CA92.1` ("access info exclusive to the app itself"), `NSPrivacyTracking: false`, an empty `NSPrivacyTrackingDomains`, and an empty `NSPrivacyCollectedDataTypes`. `Info.plist` sets `ITSAppUsesNonExemptEncryption: false`.

## Rationale

Apple requires every App Store Connect upload (as of May 1, 2024) to declare an approved reason for any "Required Reason API" usage, or the upload is rejected (ITMS-91053). `EventStore` and `AppState` use `UserDefaults`/`@AppStorage` for local-only storage exclusive to this app (no App Group, no MDM), matching reason `CA92.1` exactly. The app makes no network calls and uses no third-party SDKs, so `NSPrivacyTracking` is `false` and no data-collection types are declared. `ITSAppUsesNonExemptEncryption: false` reflects that the app uses no encryption beyond what the OS provides by default, avoiding the export-compliance prompt on every build upload.

## Consequences

- Any new required-reason API usage added later (e.g. file timestamps, disk space) needs its own declaration in `PrivacyInfo.xcprivacy` before the next upload.
- If the app ever adds network calls, tracking, or a third-party SDK, this ADR and the manifest must be revisited together with `docs/Privacy_Safety.md`.

## Revisit when

Before any change that adds network access, a third-party SDK, additional UserDefaults usage outside the app's own container, or any form of tracking.

---

# Open questions

These are intentionally not decided yet:

1. Exact visual identity and brand system.
2. Whether to show nicotine-free days in all modes or only quit-now mode.
3. Whether to include money saved.
4. Whether to include data export in v0.1.
5. Whether to support Apple Health later.
6. Whether to add paid features after validation.
7. Whether to introduce backend after v0.3.

## Architecture principle

Do not add architecture unless it directly supports the MVP product loop.

When in doubt, choose:
- less infrastructure,
- less data,
- fewer screens,
- fewer decisions,
- more privacy,
- faster craving support.