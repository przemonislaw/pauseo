# CLAUDE.md

You are working on `pauseo.app`.

This file is the operating contract for Claude Code. Before proposing code, architecture, files, screens, or implementation changes, read this file and the documents in `/docs`.

## Language

Respond in Polish by default, unless explicitly asked otherwise.

## Product identity

pauseo.app is an iOS application for people quitting or reducing smoking, vaping, or nicotine use.

The product niche is:

> craving intelligence + micro-habit replacement

The product should help users during the exact moment of craving, after a slip/relapse, and when learning recurring trigger patterns.

## Source of truth

Use the following files as the source of truth:

1. `README.md`
2. `docs/Product_MVP.md`
3. `docs/Evidence_Base.md`
4. `docs/UX_Principles.md`
5. `docs/Backlog_v0.1.md`
6. `docs/Current_State.md`
7. `docs/Privacy_Safety.md`
8. `docs/Architecture_Decisions.md`
9. `docs/Claude_Workflow.md`
 

If implementation ideas conflict with these files, do not silently proceed. Explain the conflict and propose a documentation update first.

## Current stage

The project is in MVP discovery and documentation-first setup.

Do not create application code unless the user explicitly asks for implementation.

Do not design backend infrastructure unless explicitly requested.

Do not introduce AWS at this stage.

## Product constraints

Always preserve these constraints:

- iOS-first.
- Low cognitive load.
- Local-first MVP.
- Privacy-by-design.
- No shame after relapse.
- Trigger intelligence.
- Micro-habit replacement.
- No medical advice.
- No medication/NRT dosing.
- No backend in MVP.
- No account creation in MVP.
- No social/community features in MVP.
- No AI therapist in MVP.

## Medical and safety boundaries

Do not generate:
- dosage recommendations,
- medication comparisons for a specific user,
- NRT schedules,
- diagnosis,
- treatment plans,
- claims that the app will make someone quit,
- claims that the app is clinically proven unless supported by actual evidence and approved wording,
- mental health crisis handling beyond safe referral language.

Allowed:
- general education,
- behavioral support,
- craving coping prompts,
- trigger reflection,
- no-shame relapse recovery,
- encouragement to consult a qualified healthcare professional for medication or health concerns.

## MVP philosophy

Use an MVP-first approach.

Prefer:
- one-screen flows,
- one primary action,
- short copy,
- default choices,
- local storage,
- simple data model,
- manual tracking,
- small interventions,
- clear acceptance criteria.

Avoid:
- large dashboards,
- complex onboarding,
- long content,
- excessive gamification,
- notification spam,
- analytics-heavy UI,
- backend-first thinking,
- architecture overdesign.

## UX tone

The product tone should be:

- calm,
- direct,
- non-judgmental,
- adult,
- supportive,
- concise,
- never childish,
- never moralizing,
- never manipulative.

Example tone:

> “To był slip, nie porażka. Zapiszmy tylko, co go uruchomiło.”

Not acceptable:

> “Straciłeś serię.”
> “Zawiodłeś.”
> “Musisz być silniejszy.”
> “Zacznij od nowa.”

## Claude Code working rules

When asked to implement:

1. First summarize the relevant source-of-truth constraints.
2. Identify the smallest safe change.
3. Avoid inventing new product scope.
4. Prefer full-file replacements over scattered snippets when the user asks for code.
5. Explain any contract drift.
6. Provide a test plan.
7. Do not create hidden complexity.

Use this structure for implementation analysis:

```text
CURRENT STATE
CONTRACT DRIFT
TARGET STATE
SMALLEST SAFE CHANGE
FILES TO CHANGE
ACCEPTANCE CRITERIA
TEST PLAN
RISKS / DEFERRED
```