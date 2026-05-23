# Backlog v0.1 — pauseo.app

## Version goal

v0.1 should prove the core loop:

> craving → one micro-action → quick trigger log → no-shame feedback → simple local insight

This version should be local-first and should not include backend, accounts, cloud sync, AI coach, medication guidance, or advanced analytics.

## MVP success definition

v0.1 is successful if a test user can:

1. Complete onboarding in under 90 seconds.
2. Open the app and immediately start craving support.
3. Receive one small replacement action.
4. Log a trigger in under 15 seconds.
5. Record a slip without feeling punished.
6. See a simple summary of top triggers.
7. Understand privacy and medical boundaries.

## Prioritization labels

- `P0` — required for v0.1
- `P1` — useful for v0.1 but can be simplified
- `P2` — defer unless trivial
- `OUT` — explicitly out of scope

## Epic 1 — Project foundation

### P0 — Documentation source of truth

Create and maintain:
- `README.md`
- `CLAUDE.md`
- `/docs/Product_MVP.md`
- `/docs/Evidence_Base.md`
- `/docs/UX_Principles.md`
- `/docs/Backlog_v0.1.md`
- `/docs/Privacy_Safety.md`
- `/docs/Architecture_Decisions.md`
- `/docs/Claude_Workflow.md`

Acceptance criteria:
- Claude Code can read the docs and understand constraints.
- Docs clearly say no backend in MVP.
- Docs clearly say no medical advice and no medication dosing.
- Docs define MVP scope and out-of-scope features.

## Epic 2 — Onboarding

### P0 — Welcome screen

User story:

> As a new user, I want to understand what pauseo.app does in one screen, so I know whether it can help me.

Acceptance criteria:
- Explains craving support in simple language.
- Does not promise quitting.
- Does not use medical claims.
- CTA starts onboarding.

### P0 — Nicotine type selection

Options:
- Papierosy
- Vape
- Nikotyna
- Mieszane
- Wolę nie podawać

Acceptance criteria:
- Optional.
- No judgmental copy.
- No medical interpretation.

### P0 — Goal mode selection

Options:
- Rzucam teraz
- Ograniczam
- Przygotowuję się
- Jeszcze nie wiem

Acceptance criteria:
- Does not force abstinence-only framing.
- Does not promise outcomes.

### P0 — Initial trigger selection

Options:
- Stres
- Nuda
- Alkohol
- Po jedzeniu
- Rano
- Praca
- Jazda autem
- Emocje
- Towarzystwo
- Inne

Acceptance criteria:
- One-tap input.
- Can skip.
- Used later for initial micro-action relevance.

### P1 — Personal reason

User may optionally enter a short reason.

Acceptance criteria:
- Optional.
- Not shown as guilt.
- Can be edited later.

## Epic 3 — Home screen

### P0 — Main craving CTA

Primary button:

> “Mam craving teraz”

Acceptance criteria:
- Visually dominant.
- Available on app start.
- Starts craving flow immediately.
- No dashboard clutter.

### P0 — Secondary actions

Include:
- “Miałem slip”
- “Dzienny check-in”
- “Moje triggery”
- “Postęp”

Acceptance criteria:
- Secondary actions do not compete with craving CTA.
- User can understand the home screen in under 3 seconds.

## Epic 4 — Craving flow

### P0 — Craving start screen

Copy:

> “Tylko 60 sekund. Nie musisz decydować o całym dniu.”

Acceptance criteria:
- Calm tone.
- No long text.
- One primary CTA.

### P0 — Micro-action suggestion

App suggests one action at a time.

Example categories:
- breathing,
- water,
- movement,
- delay,
- change location,
- contact,
- hands replacement,
- short reflection.

Acceptance criteria:
- Each action can be done in 30–180 seconds.
- No equipment required.
- No medical claim.
- User can request another action.

### P0 — Action outcome

Options:
- Przeszło
- Jest słabszy
- Nadal mocny
- Użyłem nikotyny
- Pominę

Acceptance criteria:
- No shame copy.
- Outcome is stored locally.
- Outcome influences simple local summary later.

## Epic 5 — Trigger logging

### P0 — Trigger chips

Options:
- Stres
- Nuda
- Alkohol
- Po jedzeniu
- Rano
- Praca
- Jazda autem
- Emocje
- Towarzystwo
- Inne

Acceptance criteria:
- One tap required.
- Optional note is secondary.
- Full log can be completed in under 15 seconds.

### P1 — Craving intensity

Options:
- Niski
- Średni
- Wysoki

Acceptance criteria:
- Optional.
- No numeric precision required.

### P2 — Optional note

Acceptance criteria:
- Not required.
- Does not slow down default flow.

## Epic 6 — Slip / relapse recovery

### P0 — Slip entry

Button:

> “Miałem slip”

Acceptance criteria:
- Easy to access.
- Does not look like a failure button.
- No red/punitive UI.

### P0 — No-shame slip copy

Core copy:

> “To był slip, nie porażka. Zapiszmy tylko, co go uruchomiło.”

Acceptance criteria:
- Copy appears before logging.
- No hard reset language.
- No “failed streak” message.

### P0 — Slip trigger capture

Fields:
- trigger,
- context,
- emotion,
- optional note,
- next action.

Acceptance criteria:
- Trigger is required or skippable with “Nie wiem”.
- User receives one recovery action.
- App closes with “wróć od teraz” tone.

## Epic 7 — Daily check-in

### P1 — Lightweight daily check-in

Questions:
1. “Jak dziś z nikotyną?”
2. “Najsilniejszy trigger?”
3. “Co pomogło?”

Acceptance criteria:
- Under 30 seconds.
- Can skip.
- No guilt if missed.

## Epic 8 — Progress and trigger intelligence

### P0 — Top triggers summary

Show:
- top 3 triggers,
- count,
- latest occurrence,
- helpful micro-action if known.

Acceptance criteria:
- Derived from local data.
- No complex analytics.
- No medical interpretation.

### P1 — Cravings handled

Show:
- cravings logged,
- actions tried,
- actions marked helpful,
- slips logged.

Acceptance criteria:
- Progress means learning, not perfection.
- Avoid shame-based streak language.

### P2 — Trend view

Deferred unless trivial.

Acceptance criteria:
- Must not become a dashboard-heavy product.

## Epic 9 — Notifications

### P1 — Local reminder setup

User can choose reminder times.

Acceptance criteria:
- Local notifications only.
- No backend push.
- User controls reminders.
- Clear opt-in copy.

### P1 — Reminder copy set

Examples:
- “Możliwy moment ryzyka. Jedna mała akcja wystarczy.”
- “30 sekund check-inu? Bez oceniania.”
- “Jeśli był slip, wróć od teraz — nie od jutra.”

Acceptance criteria:
- No shame.
- No urgency manipulation.
- No health claims.

## Epic 10 — Privacy and safety

### P0 — Privacy explanation screen

Explain:
- data stored locally,
- no account in MVP,
- no cloud sync,
- no selling data,
- no medication advice,
- not a medical product.

Acceptance criteria:
- Plain language.
- Accessible from onboarding and settings.
- Consistent with `docs/Privacy_Safety.md`.

### P0 — Medical boundary copy

Required statement:

> “pauseo.app nie zastępuje porady lekarza, terapeuty ani farmaceuty. Jeśli rozważasz leki lub nikotynową terapię zastępczą, skonsultuj się ze specjalistą.”

Acceptance criteria:
- Present in privacy/safety area.
- Not shown as fear-based blocker during craving flow.

## Explicitly out of scope for v0.1

### OUT — Backend

No AWS, no API, no database server, no remote push.

### OUT — Account system

No login, no email, no OAuth.

### OUT — AI coach

No chatbot, no therapist persona, no LLM calls.

### OUT — Medication module

No NRT schedules, no bupropion/varenicline/cytisine recommendations, no dosing.

### OUT — Community

No groups, feed, comments, social sharing.

### OUT — Advanced analytics

No complex charts, predictive scores, dependence scoring, relapse risk score.

### OUT — Monetization

No paywall in v0.1 unless explicitly revisited.

## v0.1 release checklist

Before v0.1 is considered complete:

- [ ] Onboarding can be completed quickly.
- [ ] Craving flow works end-to-end.
- [ ] Trigger log works locally.
- [ ] Slip flow works without shame language.
- [ ] Progress shows learning, not punishment.
- [ ] Local notifications are optional and gentle.
- [ ] No backend exists.
- [ ] No medical advice exists.
- [ ] No medication/NRT dosing exists.
- [ ] Privacy copy is present.
- [ ] UX copy follows `docs/UX_Principles.md`.
- [ ] Claude Code changes are consistent with `CLAUDE.md`.