# Current State — pauseo.app

Last updated: 2026-08-01

## Product canon

- iOS / SwiftUI app for quitting smoking, vaping or nicotine.
- Niche: craving intelligence + micro-habit replacement.
- Low cognitive load.
- Relapse recovery without shame.
- Trigger intelligence later, not now.
- Privacy-by-design.
- No backend at this stage.
- No auth.
- No analytics.
- No AI coach.
- No HealthKit.
- No medical advice.
- No NRT / medication dosing.

## Current product decision

Home is not a dashboard.
Home is an emergency screen.

Current Home contains only:
- Primary CTA: "Mam craving teraz"
- Secondary action: "Miałem slip"
- Tertiary link: "Prywatność i dane" (opens PrivacySafetyView as a sheet)

## Local persistence state

`EventStore` now persists completed craving and slip events locally.

- Storage: UserDefaults JSON only — no backend, no SwiftData, no CoreData.
- Stored events are not shown as history, statistics, or charts — no progress/trigger intelligence UI exists yet.
- `EventStore.deleteAll()` is accessible from PrivacySafetyView — users can delete all local data.
- Progress view and trigger intelligence UI remain deferred and are not implemented.
- Daily check-in remains deferred and is not implemented.
- `EventStore.upsert(_:)` allows a `CravingEvent` to be created once and updated in place by `id` as the craving flow progresses. This exists so that abandoning the guided 2-minute loop mid-session (e.g. swiping the sheet away) still leaves an accurate partial record instead of no record at all.

## Guided 2-minute craving loop with support cards

**Implemented.**

After the micro-action step in `CravingFlowView`, the user is invited to stay for a guided 2-minute sequence ("Zostań ze mną jeszcze 2 minuty") instead of the flow ending immediately.

- During the round, one short local support card is shown at a time, rotating approximately every 10 seconds, with a visible countdown/progress bar. The round is wall-clock based (`TimelineView`), so backgrounding the app does not desync the timer; on return, the card shown matches actual elapsed time rather than restarting.
- Support card content lives in `Pauseo/SupportCards/support_cards.json` (15 Polish-language cards bundled with the app, no network, no remote config), decoded via `SupportCard`/`SupportCardLibrary`. Each card has an `id`, `category` (`normalization` / `fact` / `bodyEffect` / `action` / `perspective`), `text`, and optional `sourceLabel`/`sourceURL` for factual claims (WHO/NHS/NCI-style sources).
- If the bundled JSON is missing, malformed, or empty, `SupportCardLibrary` falls back to a small built-in set of safe, non-medical cards instead of crashing. No logging or remote reporting of this fallback is added.
- The card sequence for a round is built once when the round starts: up to 12 unique cards, shuffled, with a best-effort pass to avoid two adjacent cards from the same category. A second round (if started) prioritizes cards not shown in round 1. No per-card view, order, or engagement is persisted — only evidence that a guided round happened.
- The user can decline the invitation or exit the loop early at any point via a low-emphasis "Kończę na teraz" control — never gated or hidden.
- After a round (finished fully or exited early), the user is asked one outcome question: "Nie zapaliłem/am" / "Odłożyłem/am decyzję" / "Zapaliłem/am".
- A second round is offered only when the first round's outcome is "Odłożyłem/am decyzję", and at most once. After the second round, the outcome question is shown again with no further round offered.
- Every path ends on the same existing, neutral `CompletionStep` — copy does not vary by outcome.
- `CravingEvent` gained five optional fields to record this without a new persistence key: `guidedLoopStarted`, `guidedLoopCompleted` (true if at least one round ran the full 2 minutes), `guidedLoopOutcome` (most recent outcome), `guidedLoopSecondRoundStarted`, `guidedLoopDurationSeconds` (saved as `120` when a round starts). Old stored events decode unaffected since the new fields are optional.
- No summaries, history, or statistics are shown anywhere — this only preserves evidence for later product decisions, per the same rule as existing craving/slip events.
- Card text changes with no explicit animation/transition, so Reduce Motion needs no special handling. The visible card carries `.accessibilityAddTraits(.updatesFrequently)` so VoiceOver does not auto-announce it every ~10 seconds, but this has not yet been verified on a physical device (see `docs/QA_Checklist_v0.1.md` section 14).

## Privacy & Safety screen

**Implemented.**

`PrivacySafetyView` is accessible from HomeView as a tertiary sheet ("Prywatność i dane").

It covers:
- what is stored locally (craving events, slip events),
- that there is no account and no backend,
- how to delete all local data (`EventStore.deleteAll()`),
- a medical disclaimer consistent with `docs/Privacy_Safety.md`.

It does not show statistics, event history, trigger insights, charts, or dashboard content.

## Recommended next step

No feature is locked as the next step. A manual QA pass and v0.1 checkpoint should happen before committing to new scope.

Candidates after QA:
- Progress / top trigger summary — EventStore has data but no UI reads it yet.
- Daily check-in — P1 in backlog, not yet started.

Do not start Progress or trigger intelligence without an explicit product decision. Those features carry dashboard risk.

## Deferred

- Daily check-in
- Trigger screen
- Progress dashboard
- Habit tracker
- Analytics
- Backend

## Completed commits

### docs: align documentation with MVP skeleton phase

Summary:
- Documentation aligned with MVP skeleton.
- Commit discipline added.
- ADR-011 added: Polish v0.1, bilingual later.
- .gitignore updated.

### ux: simplify home as craving-first entry point

Summary:
- Home simplified to craving-first rescue screen.
- Check-in, triggers and progress removed from Home.
- Placeholder views retained.

### docs: capture current state and AI-assisted project lens

Summary:
- docs/Current_State.md added as required reading before implementation.
- docs/AI_Assisted_Project_Lens.md added: PMI-CPMAI as learning/governance lens only.
- CLAUDE.md updated: Current_State.md added to source-of-truth list.

### feat: implement onboarding UI flow without persistence

Summary:
- OnboardingFlowView.swift replaced with 5 real screens.
- Welcome, nicotine type, goal mode, main trigger, notifications.
- All selections held in @State only — no new persistence added.
- Existing onboardingCompleted flag in AppState unchanged.

### feat: implement craving flow UI-only

Summary:
- CravingFlowView.swift replaced with 4-screen flow.
- Grounding, trigger selection, micro-action selection, completion.
- All state held in @State only — no new persistence added.
- HomeView already connected via sheet — no changes to HomeView.

### feat: implement slip recovery UI-only

Summary:
- SlipRecoveryView.swift replaced with 4-screen flow.
- Shame reduction, context selection, recovery action, completion.
- All state held in @State only — no new persistence added.
- HomeView already connected via sheet — no changes to HomeView.

### feat: add local persistence for craving and slip events

Summary:
- EventStore.swift added: local ObservableObject store managing craving and slip event arrays.
- CravingEvent and SlipEvent structs added: Codable, stored as JSON in UserDefaults.
- CravingFlowView and SlipRecoveryView updated to call EventStore on completion.
- Persistence is local-only UserDefaults JSON — no backend, no SwiftData, no CoreData.
- Stored events are not yet displayed in any UI view.

### feat: add privacy and safety screen

Summary:
- PrivacySafetyView.swift added: explains local storage, no account/backend, delete option, medical disclaimer.
- EventStore.deleteAll() added: clears both in-memory arrays and removes both UserDefaults keys.
- HomeView updated: tertiary "Prywatność i dane" button opens PrivacySafetyView as a sheet.
- No statistics, event history, charts, or trigger insights on this screen.

### chore: regenerate project.pbxproj after adding PrivacySafetyView

Summary:
- xcodegen generate run after adding Pauseo/Privacy/PrivacySafetyView.swift.
- New group, file reference, and build file added for PrivacySafetyView.swift.
- No other project changes.

### feat: switch guided craving loop to 2 minutes with local support cards

Summary:
- Guided loop shortened from 3 minutes to 2 minutes; all user-facing copy updated.
- `SupportCard`/`SupportCardCategory` model and `SupportCardLibrary` loader/sequencer added.
- `support_cards.json` (15 Polish cards, sourced) bundled locally; safe fallback if missing/malformed/empty.
- `GuidedLoopStep` now rotates one support card every ~10 seconds instead of 3 fixed 60-second stages.
- `CravingEvent` gained optional `guidedLoopDurationSeconds`, saved as 120.
- No new persistence of card views/order; no network, settings, or personalization added.

### chore: regenerate project.pbxproj after adding SupportCards

Summary:
- xcodegen generate run after adding Pauseo/SupportCards/ (SupportCard.swift, SupportCardLibrary.swift, support_cards.json).
- New group, file references, and build/resource files added.
- Confirmed support_cards.json is present in Copy Bundle Resources.

## Workflow rule

Claude Code must:
1. Read this file before planning.
2. Propose a small plan.
3. Wait for approval.
4. Change only files required by the approved scope.
5. Avoid adding new features unless explicitly approved.
