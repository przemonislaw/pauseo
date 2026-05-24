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

Accepted

## Decision

v0.1 ships in Polish only.

Bilingual copy (Polish + English or other languages) is deferred until user validation is complete.

## Rationale

The initial target persona is a Polish-speaking adult.

Shipping one language reduces:
- copy complexity,
- translation overhead,
- UX inconsistency risk,
- scope creep before validation.

## Consequences

All in-app copy, onboarding, notifications, and UX text in v0.1 should be Polish.

English-language strings are permitted only in:
- developer-facing code comments (where necessary),
- internal documentation,
- code identifiers.

## Revisit when

After v0.1 validation, if there is evidence of demand from users in other language markets.

See `docs/Product_MVP.md` — v0.3 lists bilingual copy as a possible addition.

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