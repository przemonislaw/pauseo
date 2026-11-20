# Product MVP — pauseo.app

## Product name

pauseo.app

## Category

iOS behavioral support app for quitting or reducing smoking, vaping, or nicotine use.

## Positioning

pauseo.app is not another quit counter.

It is a calm, private, low-cognitive-load companion for the most vulnerable moments of quitting:

- craving,
- stress,
- boredom,
- social trigger,
- alcohol trigger,
- shame after slip,
- routine replacement.

## Core niche

> Craving intelligence + micro-habit replacement

The app helps users answer:

1. What usually triggers my cravings?
2. What can I do instead in the next 30–90 seconds?
3. What happened when I slipped?
4. What pattern should I prepare for next time?

## Starting persona

### Persona: stressed professional quitting nicotine

The initial user is an adult who smokes, vapes, or uses nicotine and wants to quit or reduce.

They may be:
- busy,
- cognitively overloaded,
- stressed at work,
- ashamed after previous failed attempts,
- skeptical of motivational slogans,
- tired of generic habit apps,
- not looking for a social community,
- needing fast support during cravings.

### Emotional state

The user may open the app while feeling:
- craving,
- stress,
- frustration,
- shame,
- boredom,
- loneliness,
- social pressure,
- “I already failed, so why bother?”

## Problem statement

People trying to quit nicotine often do not fail because they lack information.

They struggle because cravings happen in specific moments, under emotional and environmental pressure, when cognitive load is high and self-control is low.

Most apps emphasize streaks, dashboards, badges, money saved, or generic motivation. These can help some users, but they do not always support the critical moment:

> “I need one small action right now.”

## Value proposition

pauseo.app helps users get through cravings and learn their personal trigger patterns with minimal effort.

It provides:
- a visible craving button,
- short replacement actions,
- fast trigger logging,
- no-shame relapse recovery,
- simple progress,
- privacy-first local tracking.

## Product promise

Safe promise:

> “A calmer way to handle cravings and learn your nicotine triggers.”

Avoid:

> “Quit smoking in X days.”
> “Clinically proven to make you quit.”
> “Replace medication.”
> “Personalized medical treatment.”
> “Guaranteed success.”

## Core product loop

1. User experiences craving or slip risk.
2. User opens the app.
3. User taps **Mam craving teraz**.
4. App suggests one micro-action.
5. User completes, skips, or changes it.
6. App asks for a tiny trigger log.
7. App updates local trigger intelligence.
8. App uses patterns to improve future suggestions.

## MVP features

### 1. Minimal onboarding

Goal: configure only what is necessary. In v0.1 that is nothing: onboarding is a single welcome screen (see "Onboarding" below).

Deferred inputs (ask later, in context, only when the answer changes something):
- nicotine type: smoking / vaping / nicotine / mixed,
- goal mode: quit now / reduce / prepare,
- top initial trigger,
- preferred craving support time,
- optional personal reason.

Rules:
- no account,
- no medical questions beyond product-safe basics,
- no long questionnaire,
- no diagnosis,
- no dependence scoring in v0.1.

### 2. “Mam craving teraz” flow

Main action visible on home screen.

Flow:
1. User taps the button.
2. App shows one micro-action.
3. User can choose:
   - “Zrobię teraz”
   - “Daj inną”
   - “Nie teraz”
4. After action, app asks for a short trigger log.

Micro-actions should be short:
- breathe for 60 seconds,
- drink water,
- walk for 2 minutes,
- delay for 5 minutes,
- change location,
- message someone,
- chew gum,
- wash face,
- do 10 squats,
- hold something in hand,
- write one sentence,
- leave the smoking/vaping context.

No action should require equipment, long reading, or complex setup.

### 3. Trigger log

Trigger log should take less than 10–15 seconds.

Fields:
- craving intensity: low / medium / high,
- trigger: stress / boredom / alcohol / social / after meal / morning / work / driving / emotion / other,
- context: optional short note,
- outcome: resisted / used nicotine / skipped / still craving.

### 4. No-shame relapse/slip flow

Relapse or slip must not feel like failure.

Flow:
1. User taps “Miałem slip”.
2. App responds calmly.
3. User records what happened.
4. App asks one recovery question.
5. App offers one next action.

Core copy:

> “To był slip, nie porażka. Zapiszmy tylko, co go uruchomiło.”

No hard streak reset in MVP.

### 5. Simple progress view

Progress should focus on learning and recovery, not perfection.

Show:
- cravings handled,
- top 3 triggers,
- most helpful micro-actions,
- nicotine-free days or reduced-use days if user selected that mode,
- slips as learning events, not failures.

Avoid:
- complex charts,
- shame-based streaks,
- red failure states,
- competitive scoring,
- “you lost everything” messaging.

## Deferred features

Do not build in MVP:

1. Backend, AWS, account, login, sync.
2. AI coach or therapist chatbot.
3. Community, feed, social accountability.
4. Medication/NRT recommendation engine.
5. Advanced analytics dashboards.
6. HealthKit / wearable integrations.
7. Clinician portal.
8. Paid subscription mechanics.
9. Full content library.
10. Multi-language expansion beyond Polish and English.
11. Deep personalization engine.
12. App Store monetization experiments.
13. Gamified badge economy.
14. Public sharing.
15. Push notification backend.

## Onboarding

### Goal

Get the user to the first useful moment quickly.

### Desired length

Under 90 seconds.

### Screens

#### Screen 1 (only screen): Welcome

Title:

> “Pomoc na moment cravingu.”

Body:

> “pauseo pomaga wybrać jedną małą akcję, gdy pojawia się głód nikotynowy.”

Privacy line:

> “Bez konta. Twoje dane zostają w telefonie.”

CTA (goes straight to Home):

> “Zacznij spokojnie”

#### Removed setup questions (2026-11-20)

Onboarding was cut from 5 screens to 1 before the first App Review submission. The removed screens were: nicotine type, goal mode, main trigger, reminders.

Reason: their answers were never stored or used, so they added cognitive load between a new user and craving support without changing anything (see `docs/Inspiration_Onboarding_Reels.md`).

Rule for bringing any of them back: ask in context, at the moment the answer visibly changes something, not upfront. For example:
- goal mode when a Progress view needs it,
- reminders after the user has used the craving flow at least once (ADR-008),
- trigger intelligence is built from triggers logged in the craving flow, not from an onboarding guess.

## Home screen

Primary element:

> “Mam craving teraz”

Secondary actions:
- “Miałem slip”
- “Dzienny check-in”
- “Moje triggery”
- “Postęp”

Home must not become a dashboard.

## Daily check-in

Should take less than 30 seconds.

Questions:
1. “Jak dziś z nikotyną?”
   - Bez nikotyny
   - Mniej niż zwykle
   - Tyle co zwykle
   - Więcej niż zwykle
   - Wolę pominąć
2. “Najsilniejszy trigger?”
3. “Jedna rzecz, która pomogła?”

## Craving flow

### Entry

User taps:

> “Mam craving teraz”

### Step 1: Grounding

Copy:

> “Zatrzymajmy to na 60 sekund. Nie musisz decydować o całym dniu. Tylko o tej minucie.”

### Step 2: Micro-action

Display one action.

Example:

> “Wypij szklankę wody i zmień miejsce na 2 minuty.”

Buttons:
- “Robię”
- “Daj inną”
- “Pomiń”

Away-from-phone actions ("Wyjdź na 2 minuty", "Napisz do kogoś"): the guided-loop invitation must not say "stay with me". It gives permission to do the action first: "Śmiało, zrób to teraz. Będę tutaj." / "Gdy wrócisz, możesz zostać ze mną jeszcze 2 minuty. Albo zakończyć tutaj." Same two buttons, same logic.

### Step 3: Outcome

After the micro-action, the user may continue into a short guided 2-minute engagement sequence, with a rotating local support card shown every ~10 seconds, before this question appears.

Question:

> “Co się teraz dzieje?”

Options:
- Nie zapaliłem/am
- Odłożyłem/am decyzję
- Zapaliłem/am

### Step 4: Trigger log (after the outcome)

Asked last, on every path (guided loop finished, exited early, or declined), once the user has had help and is calmer. Optional: "Next" without a selection skips it. The event is already saved as completed before this step, so dismissing here keeps the record without a trigger.

Why last (decided 2026-11-20): the user opens the flow at peak craving and taps "Help me now"; the first thing they get must be help, not a question. Asked after the outcome, the question reads as reflection ("what set it off?"), matches the slip flow pattern ("zapiszmy, co go uruchomiło"), and is easier to answer accurately.

Question:

> “Co najbardziej odpaliło craving?”

Options:
- Stres
- Nuda
- Alkohol
- Po jedzeniu
- Towarzystwo
- Emocje
- Praca
- Rano
- Inne

### Step 5: Close

Copy examples:
- “Dobra robota. Zrobiłeś jedną rzecz zamiast automatu.”
- “To nadal się liczy. Zebraliśmy dane na następny raz.”
- “Nie musisz wygrywać całego dnia. Wystarczy wrócić do następnej małej decyzji.”

## Relapse/slip flow

### Entry

User taps:

> “Miałem slip”

### Response

Copy:

> “To był slip, nie porażka. Zapiszmy tylko, co go uruchomiło.”

### Log

Fields:
- trigger,
- situation,
- emotion,
- optional note,
- next micro-action.

### Close

Copy:

> “Następny krok jest mały: wróć do planu od teraz, nie od jutra.”

## Progress view

Show:
- number of cravings logged,
- number of cravings handled without nicotine,
- most common triggers,
- most used micro-actions,
- days tracked,
- slips recorded without judgment.

Progress should communicate:

> “Uczysz się wzorca.”

Not:

> “Jesteś dobry/zły.”

## Notification rules

MVP supports local notifications only.

Allowed:
- gentle reminders at user-selected risky times,
- daily check-in reminder,
- “prepare for trigger” reminder,
- optional evening reflection.

Not allowed:
- guilt messages,
- excessive notifications,
- emergency-style urgency,
- manipulative copy,
- shame after missing check-ins,
- backend push notifications.

Example notification copy:

> “Może pojawić się craving. Wystarczy jedna mała akcja.”

> “30 sekund check-inu? Bez oceniania.”

> “Jeśli dziś był slip, nie musisz zaczynać od zera.”

## Minimal conceptual data model

No backend in MVP.

Local-only data concepts:

### UserPreferences

- nicotineType
- goalMode
- initialTrigger
- reminderPreference
- personalReason
- onboardingCompleted

### CravingEvent

- id
- timestamp
- intensity
- trigger
- suggestedMicroActionId
- actionOutcome
- nicotineUsed
- optionalNote

### SlipEvent

- id
- timestamp
- trigger
- emotion
- context
- nextActionId
- optionalNote

### MicroAction

- id
- title
- durationSeconds
- category
- triggerFit
- copy
- isDefault

### DailyCheckIn

- id
- date
- nicotineUseStatus
- strongestTrigger
- helpfulAction
- optionalNote

### TriggerSummary

Can be derived locally from events.

- trigger
- count
- recentFrequency
- helpfulActions
- riskyContexts

## MVP success metrics

These are product learning metrics, not medical success claims.

### Activation

- onboarding completion rate,
- first craving flow completed,
- first trigger logged.

### Engagement

- number of craving events logged,
- daily check-ins completed,
- local notification opt-in,
- repeat use after first slip.

### Usefulness

- user marks action as helpful,
- user returns to app during craving,
- trigger log completion rate,
- micro-action completion rate.

### Safety

- no medical advice shown,
- no dosing recommendations,
- no shame-based copy,
- no forced streak reset.

## Versions

### v0.1 — Local MVP

Goal: prove that the craving flow is useful.

Includes:
- onboarding,
- home screen,
- craving button,
- micro-actions,
- trigger log,
- slip flow,
- simple progress,
- local notifications,
- privacy/safety screen.

No backend.

### v0.2 — Better trigger intelligence

Goal: make suggestions more context-aware while staying local-first.

Possible additions:
- top trigger insights,
- better micro-action matching,
- configurable reminder windows,
- improved progress view,
- more polished copy,
- basic export for user-owned data if needed.

Still no backend unless explicitly revisited.

### v0.3 — Validation and retention

Goal: test whether users keep returning and find the app useful.

Possible additions:
- lightweight paywall experiment,
- App Store polish,
- structured user feedback,
- optional content cards,
- more robust local analytics.

Bilingual (PL/EN) copy already shipped in v0.1 Phase 1 — see `docs/Architecture_Decisions.md` ADR-011.

Backend remains a separate decision, not default.