# Claude Workflow — pauseo.app

## Purpose

This document defines how to work with Claude Code on pauseo.app.

Claude Code is an execution partner, not the source of product truth.

The source of truth is:
- `README.md`
- `CLAUDE.md`
- files in `/docs`

## Working principle

Do not ask Claude Code to “build the app” broadly.

Use scoped prompts with:
- current state,
- source files,
- desired outcome,
- constraints,
- acceptance criteria,
- files allowed to change,
- what not to do.

## Standard workflow

### Step 1 — Read the docs

Before implementation, Claude Code should read:

1. `CLAUDE.md`
2. `docs/Product_MVP.md`
3. `docs/UX_Principles.md`
4. `docs/Backlog_v0.1.md`
5. `docs/Privacy_Safety.md`
6. `docs/Architecture_Decisions.md`

### Step 2 — Pick one backlog item

Work on one P0 item at a time.

Good:
- “Implement onboarding screens from Backlog v0.1.”
- “Implement craving flow only.”
- “Implement local trigger log only.”

Bad:
- “Build the whole app.”
- “Make it production ready.”
- “Add backend and AI coach.”
- “Create the full architecture.”

### Step 3 — Ask Claude for a plan before code

Prompt:

```text
Read CLAUDE.md and /docs.
We are implementing only this backlog item:

[PASTE ITEM]

Before writing code, return:
CURRENT STATE
RELEVANT DOC CONSTRAINTS
TARGET STATE
FILES YOU EXPECT TO CHANGE
RISKS
ACCEPTANCE CRITERIA

Do not write code yet.
```

### Step 4 — Apply the change

Only after the plan is approved:

- Make the smallest change that satisfies the backlog item.
- Do not touch flows unrelated to the item.
- Do not add backend, auth, analytics, AI, HealthKit, monetization, medication/NRT guidance, or notification implementation unless explicitly requested.
- Do not invent scope not present in the backlog item.

## Commit discipline

One backlog item per commit.

Rules:
- Each commit maps to exactly one backlog item or one documentation change.
- Do not bundle unrelated screens, flows, or fixes in the same commit.
- Commit message should reference the backlog item.
- Do not commit speculative code or "while I'm here" changes.

Prohibited without explicit request:
- backend, AWS, API calls,
- authentication, accounts, login,
- third-party analytics or tracking SDKs,
- AI, LLM, or chatbot integration,
- HealthKit or wearable integrations,
- monetization, paywall, in-app purchase,
- medication or NRT guidance,
- remote push notification infrastructure.