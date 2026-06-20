# Current State — pauseo.app

Last updated: 2026-06-21

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

## Local persistence state

`EventStore` now persists completed craving and slip events locally.

- Storage: UserDefaults JSON only — no backend, no SwiftData, no CoreData.
- Stored events are **not displayed to the user yet** — no UI reads from EventStore.
- Progress view and trigger intelligence UI remain deferred and are not implemented.
- Daily check-in remains deferred and is not implemented.

## Recommended next product step

**Privacy & Safety screen.**

Because local behavioral events (craving and slip records) are now being stored on device, users need to know:
- what data is stored,
- that it stays on their device,
- how to delete it.

This should be implemented before adding any new event types or analytics-adjacent features.

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

## Workflow rule

Claude Code must:
1. Read this file before planning.
2. Propose a small plan.
3. Wait for approval.
4. Change only files required by the approved scope.
5. Avoid adding new features unless explicitly approved.
