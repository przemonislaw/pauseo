# pauseo.app

pauseo.app is an iOS-first product for people who want support while quitting or reducing smoking, vaping, or nicotine use.

The product is not a medical treatment, not a therapy replacement, and not a medication advisor. It is a low-cognitive-load behavioral support companion focused on:

- craving intelligence,
- micro-habit replacement,
- no-shame relapse recovery,
- trigger intelligence,
- privacy-by-design.

## Current status

This repository is in the **MVP skeleton phase**.

The repository contains:
- full product documentation in `/docs`,
- a minimal SwiftUI placeholder skeleton (screens stubbed, no feature logic implemented).

No feature implementation should happen unless it maps to one explicit backlog item in `docs/Backlog_v0.1.md`.

## Product thesis

Most quit-smoking apps compete on streaks, money saved, health timelines, badges, or generic motivation.

pauseo.app should focus on the moment that matters most:

> “I have a craving right now. Give me one small action I can do in the next 30–90 seconds.”

The MVP should help the user notice patterns, survive cravings, recover from slips without shame, and gradually replace nicotine-triggered routines with small alternative actions.

## MVP niche

**Craving intelligence + micro-habit replacement**

The app should not try to be:
- a full quit-smoking program,
- a medical app,
- a dosing assistant,
- a therapy chatbot,
- a social network,
- a full analytics platform,
- an AWS-backed health platform.

The app should be:
- fast,
- calm,
- private,
- lightweight,
- useful during cravings,
- forgiving after relapse,
- focused on one small next action.

## Core loop

1. User feels a craving, stress, boredom, shame, social pressure, or a slip risk.
2. User opens the app and taps **“Mam craving teraz”**.
3. App suggests one tiny replacement action.
4. User does or skips the action.
5. App asks for a very short trigger log.
6. App learns the top recurring triggers locally.
7. Next time, the app suggests a better-fitting micro-action.

## MVP scope

The first MVP should include:

1. Onboarding with minimal setup.
2. Craving flow.
3. Micro-habit replacement suggestions.
4. Trigger logging.
5. Relapse/slip recovery flow.
6. Simple progress view.
7. Local reminders/notifications.
8. Privacy and safety guardrails.

## Out of scope for MVP

The following are intentionally deferred:

- backend,
- AWS infrastructure,
- account creation,
- cloud sync,
- community features,
- AI coach,
- medical recommendations,
- medication/NRT dosing,
- HealthKit integrations,
- wearable integrations,
- advanced charts,
- gamified achievement economy,
- social sharing,
- clinician dashboard.

## Documentation map

- `CLAUDE.md` — operating instructions for Claude Code.
- `docs/Product_MVP.md` — product scope and MVP contract.
- `docs/Evidence_Base.md` — scientific and clinical guardrails.
- `docs/UX_Principles.md` — low-cognitive-load UX rules.
- `docs/Backlog_v0.1.md` — first implementation backlog.
- `docs/Privacy_Safety.md` — privacy, safety, and claim boundaries.
- `docs/Architecture_Decisions.md` — current architecture decisions and non-decisions.
- `docs/Claude_Workflow.md` — how to work with Claude Code safely.

## Product principles

### 1. One action now

The user may be stressed, ashamed, tired, distracted, or craving. The app should never require long reading or complex choices in that state.

### 2. Slip is data, not failure

Relapse or a slip should never reset the user emotionally. It should create a recovery path and improve trigger intelligence.

### 3. Privacy first

Craving, relapse, stress, nicotine use, and emotional triggers are sensitive data. MVP should be local-first.

### 4. No medical advice

The app may educate at a general level, but it must not diagnose, prescribe, recommend dosing, compare medication options for a specific person, or replace professional care.

### 5. MVP-first

Every feature must justify itself against one question:

> Does this help the user survive the next craving or understand their triggers with less cognitive load?

If not, defer it.