# Current State — pauseo.app

Last updated: 2026-05-24

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

Deferred:
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

## Next planned feature commit

feat: implement slip recovery UI-only

Scope:
- Entry: "Miałem slip"
- Calm response screen
- Trigger / situation log
- Next micro-action
- Completion / return to Home

Explicitly out of scope:
- Persistence
- UserDefaults
- SwiftData
- CoreData
- UserNotifications
- Backend
- Auth
- Analytics
- AI coach
- HealthKit
- New models
- Medical / NRT guidance
- Gamification / streaks

## Workflow rule

Claude Code must:
1. Read this file before planning.
2. Propose a small plan.
3. Wait for approval.
4. Change only files required by the approved scope.
5. Avoid adding new features unless explicitly approved.
