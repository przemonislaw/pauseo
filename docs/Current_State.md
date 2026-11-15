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
- Card text changes with no explicit animation/transition, so Reduce Motion needs no special handling. The visible card carries `.accessibilityAddTraits(.updatesFrequently)` so VoiceOver does not auto-announce it every ~10 seconds. This has been verified on a physical device, including VoiceOver and Reduce Motion behaviour (see `docs/QA_Checklist_v0.1.md` section 14, Pass).

## Visual system

**Implemented.**

A visual design pass (warm ivory background, deep indigo primary action color, selection chips with a checkmark in addition to color fill) was designed and reviewed in a Stitch MCP project ("pauseo — iOS MVP"), then applied to the real screens: Home, Onboarding, CravingFlow, SlipRecovery, Privacy.

- `Pauseo/DesignSystem/Colors.swift` defines adaptive color tokens (`pauseoBackground`, `pauseoPrimary`, `pauseoTextPrimary`, `pauseoTextSecondary`, `pauseoSurface`, `pauseoBorder`, `pauseoNeutralAction`). Light mode uses the reviewed palette; dark mode intentionally reproduces the exact system colors the app used before this file existed (no dark mode was designed or reviewed).
- Selection chips (`OptionChip`/`CravingChip`/`SlipChip`) now show a checkmark on the selected option, not just a color fill, per `docs/UX_Principles.md`'s "no interaction dependent only on color" accessibility principle.
- Progress/DailyCheckIn placeholders were left untouched (disconnected, out of scope per the same rule as elsewhere in this file).
- Verified: `xcodegen generate`, Debug and Release builds (Simulator) succeed with no new warnings; Home screen visually confirmed on an iOS Simulator in both light and dark mode. The chip/checkmark screens were verified by code review against the approved Stitch mockups, not a live on-device screenshot — this environment has no UI-tap automation (no idb/XCUITest harness) to navigate there non-interactively.

## Privacy & Safety screen

**Implemented.**

`PrivacySafetyView` is accessible from HomeView as a tertiary sheet ("Prywatność i dane").

It covers:
- what is stored locally (craving events, slip events),
- that there is no account and no backend,
- how to delete all local data (`EventStore.deleteAll()`),
- a medical disclaimer consistent with `docs/Privacy_Safety.md`.

It does not show statistics, event history, trigger insights, charts, or dashboard content.

## PL/EN localization

**Implemented. Verified on a physical device in both Polish and English — see `docs/QA_Checklist_v0.1.md` section 15 (Pass).**

Full PL/EN localization, per ADR-011's update, covers onboarding, Home, the full craving flow (including the guided loop invitation/outcome/second-round copy and all support cards), slip recovery, Privacy & Safety (including the delete-data alert), and the disconnected `DailyCheckInView`/`AppProgressView` placeholders.

- Mechanism: a single native String Catalog, `Pauseo/Localizable.xcstrings`, source language English, with full English and Polish translations. `project.yml` sets `options.developmentLanguage: en` and declares `CFBundleLocalizations: [en, pl]` on the target's generated Info.plist (xcodegen does not infer this automatically from the catalog alone — without it the device/simulator language override is ignored and the app always renders in English). Unsupported device languages fall back to English, matching the catalog's source language.
- Static, non-data UI copy (titles, instructions, buttons, alerts) was changed from Polish literals to English literals in the Swift source — these English strings are the catalog keys, with Polish translations added in the catalog.
- Data-backed strings — `NicotineType`/`GoalMode`/`TriggerCategory` `rawValue`s, the literal micro-action/context/recovery-action option arrays in `CravingFlowView` and `SlipRecoveryView`, and `support_cards.json` card `text` — were **not** changed. They remain the exact Polish values already used as stored data (`CravingEvent.trigger`/`.action`, `SlipEvent.context`/`.recoveryAction`). Their on-screen presentation is localized separately, by wrapping the stored Polish string in `LocalizedStringKey(...)` at the display call site (e.g. the shared `OptionChip`/`CravingChip`/`SlipChip` views, and the guided-loop card `Text`), which performs a runtime catalog lookup keyed by that Polish text. This means a craving logged while the device is set to English still writes the same Polish trigger/action string as before — only the label shown to the user differs.
- `support_cards.json` itself is unchanged in structure and still ships one file with 15 Polish-language cards; only the `body-heart-rate` card's `sourceLabel`/`sourceURL` were corrected to WHO's smoking-cessation health-benefits page (per approved scope), since the NHS homepage it previously cited does not specifically support the heart-rate/blood-pressure claim. Card `sourceLabel`/`sourceURL` are still not rendered anywhere in the UI.
- No account, backend, sync, remote content, or in-app language-switcher setting was added. Language selection is the standard iOS per-app mechanism (Settings → Pauseo → Language).
- Verified: `xcodegen generate`, Debug and Release builds (iOS Simulator destination) both succeed with no new warnings; the built app bundle contains `en.lproj/Localizable.strings` and `pl.lproj/Localizable.strings` (111 keys each); a Simulator smoke test confirmed the app actually renders in Polish and English depending on the device language and falls back correctly. Full manual QA (real device, all flows, both languages, accessibility, VoiceOver, Reduce Motion, language switching, fallback) has passed — see `docs/QA_Checklist_v0.1.md` section 15.

## Release readiness (Phase 2, in progress)

Goal: first Internal TestFlight build. No application feature work — this is packaging/signing/compliance only.

Done:
- App ID `app.pauseo` registered in Apple Developer Portal; app record created in App Store Connect ("Pauseo", primary language Polish).
- `DEVELOPMENT_TEAM` corrected to `5T4Z65558R` (the previous value, `36WKZ8Q4L5`, matched no locally available certificate); `CODE_SIGN_STYLE: Automatic` pinned in `project.yml` so it survives `xcodegen generate`. Verified working in Xcode's Signing & Capabilities (automatic profile + certificate resolved).
- `TARGETED_DEVICE_FAMILY` set to `1` (iPhone only) — see ADR-012.
- `Pauseo/PrivacyInfo.xcprivacy` added, declaring the app's `UserDefaults` usage; `ITSAppUsesNonExemptEncryption: false` set — see ADR-013.
- Verified: `xcodegen generate` plus Debug and Release builds (Simulator destination) succeed with no new warnings after all of the above.
- App icon added (`Pauseo/Assets.xcassets/AppIcon.appiconset/AppIcon-1024.png`, opaque 1024x1024, single-size/universal slot) — solid deep indigo square with two warm ivory pause bars, matching the visual system. A matching native launch screen (`UILaunchScreen` in `Info.plist`, no storyboard) shows the same pause-mark glyph on `LaunchBackground` (ivory light / black dark).

Still pending before an Internal TestFlight build can be uploaded:
- An actual Archive + upload, which requires Xcode signed into the Apple ID for team `5T4Z65558R` (confirmed working in the Xcode GUI; this cannot be done from an unattended/headless shell in this environment — `xcodebuild archive` here fails with "No Account for Team" since no Apple ID session exists outside the interactive Xcode app).
- Export-compliance and any other build-specific prompts in App Store Connect once a build is uploaded.

Out of scope for Internal TestFlight (confirmed from App Store Connect's own UI): the "iOS App Version" distribution page (description, keywords, screenshots, promotional text, support/marketing URLs) is for the public App Store listing, not required to test via Internal TestFlight.

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
