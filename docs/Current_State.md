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
- Primary CTA: “Mam craving teraz”
- Secondary action: “Miałem slip”

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

## Next planned feature commit

feat: implement onboarding UI flow without persistence

Scope:
- Welcome / help during craving
- Nicotine type
- Goal mode
- Main trigger
- Notification info / defer option

Explicitly out of scope:
- Persistence
- UserDefaults
- SwiftData
- CoreData
- UserNotifications
- Permission request
- Local notifications
- Backend
- Auth
- Analytics
- AI coach
- HealthKit
- New models
- Medical / NRT guidance

## Workflow rule

Claude Code must:
1. Read this file before planning.
2. Propose a small plan.
3. Wait for approval.
4. Change only files required by the approved scope.
5. Avoid adding new features unless explicitly approved.