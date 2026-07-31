# QA Checklist v0.1 — pauseo.app

Manual QA checklist for the current MVP state, after Privacy & Safety.

This is a docs-only checklist. It does not describe new features. It verifies that the current implementation matches `docs/Current_State.md` and `docs/Privacy_Safety.md`.

Run through every section on a real device or simulator. Fill in Pass / Issues found under each section.

---

## 1. Home emergency screen

- [ ] Home shows exactly three actions: primary "Mam craving teraz", secondary "Miałem slip", tertiary "Prywatność i dane".
- [ ] No other buttons, cards, lists, streaks, or numbers are visible on Home.
- [ ] Home does not read like a dashboard (no charts, no history, no stats).
- [ ] Primary CTA opens the craving flow.
- [ ] Secondary action opens the slip recovery flow.
- [ ] Tertiary link opens PrivacySafetyView as a sheet.

Pass / Issues found:

---

## 2. Onboarding UI flow

- [ ] Onboarding shows 5 screens: welcome, nicotine type, goal mode, main trigger, notifications.
- [ ] Each screen has one primary action to continue.
- [ ] Onboarding can be completed start to finish without errors or dead ends.
- [ ] Selections are not required to be filled in a way that blocks progress (no forced free-text).
- [ ] Copy tone is calm, direct, non-judgmental — no childish or moralizing language.
- [ ] Completing onboarding returns the user to Home.

Pass / Issues found:

---

## 3. Craving flow

- [ ] Opens from Home primary CTA.
- [ ] Shows 4 screens: grounding, trigger selection, micro-action selection, completion.
- [ ] Flow can be completed start to finish.
- [ ] Flow can be exited/cancelled without crashing.
- [ ] Completion screen tone matches supportive, non-judgmental style (no praise pressure, no gamified reward language).
- [ ] Completing the flow creates a stored craving event (verify via section 5).

Pass / Issues found:

---

## 4. Slip recovery flow

- [ ] Opens from Home secondary action.
- [ ] Shows 4 screens: shame-reduction, context selection, recovery action, completion.
- [ ] Flow can be completed start to finish.
- [ ] Flow can be exited/cancelled without crashing.
- [ ] No screen uses failure language ("lost", "failed", "start over from zero", streak reset).
- [ ] Completing the flow creates a stored slip event (verify via section 5).

Pass / Issues found:

---

## 5. Local persistence for craving/slip events

- [ ] Complete one craving flow and one slip flow.
- [ ] Force-quit the app and relaunch.
- [ ] Confirm the app does not crash and no data-loss error appears.
- [ ] Confirm events are not displayed anywhere as history, list, chart, or statistic (none should exist yet).
- [ ] No network call is made when a craving or slip event is saved (airplane mode: flow still completes and saves).

Pass / Issues found:

---

## 6. PrivacySafetyView

- [ ] Opens as a sheet from Home tertiary link "Prywatność i dane".
- [ ] Sheet can be dismissed and returns cleanly to Home.
- [ ] Explains what is stored locally (craving events, slip events).
- [ ] States there is no account and no backend.
- [ ] Contains a way to delete all local data.
- [ ] Contains the medical disclaimer (verify exact wording in section 8).
- [ ] Does not show statistics, event history, trigger insights, charts, or dashboard content.

Pass / Issues found:

---

## 7. Delete all local data flow

- [ ] Trigger delete action from PrivacySafetyView.
- [ ] Confirm craving and slip events are cleared (no longer counted/present after relaunch).
- [ ] Force-quit and relaunch app after deletion — confirm no old events reappear.
- [ ] App remains usable after deletion (no crash, no broken state).

Pass / Issues found:

---

## 8. Medical disclaimer presence

- [ ] Disclaimer text is present in PrivacySafetyView.
- [ ] Wording matches or is a close equivalent of the required disclaimer in `docs/Privacy_Safety.md`:
  > "pauseo.app wspiera budowanie nawyków i rozpoznawanie triggerów. Nie zastępuje porady lekarza, terapeuty ani farmaceuty. Jeśli rozważasz leki, nikotynową terapię zastępczą albo masz silne objawy odstawienia, skonsultuj się ze specjalistą."
- [ ] No dosage, medication comparison, NRT schedule, or diagnosis language appears anywhere in the app.

Pass / Issues found:

---

## 9. No backend / no analytics / no AI / no HealthKit / no auth

- [ ] Full app usage (onboarding, craving flow, slip flow, delete data) works in airplane mode.
- [ ] No login, signup, or account screen exists anywhere.
- [ ] No HealthKit permission prompt appears at any point.
- [ ] No AI/chat/coach interface exists anywhere.
- [ ] No third-party analytics SDK initialization or network calls observed (check device network activity if possible).

Pass / Issues found:

---

## 10. No dashboard / statistics / trigger insights accidentally introduced

- [ ] Home contains no charts, counts, streaks, or history.
- [ ] PrivacySafetyView contains no charts, counts, streaks, or history.
- [ ] No screen in the app displays aggregated craving/slip data, trends, or trigger pattern summaries.
- [ ] No "Progress" or "Insights" screen is reachable from any current flow.

Pass / Issues found:

---

## 11. Low cognitive load review

- [ ] Each screen across all flows has one clear primary action.
- [ ] Copy on each screen is short (no long paragraphs, no dense text blocks).
- [ ] Default selections/choices are available where relevant — user is not forced to fill many fields.
- [ ] No screen requires more than a few taps to complete its purpose.
- [ ] No excessive animation, gamification, or decorative complexity.

Pass / Issues found:

---

## 12. Shame-free relapse/slip copy review

- [ ] Read every string shown in the slip recovery flow end to end.
- [ ] Confirm none of the forbidden phrases (or close equivalents) appear: "straciłeś serię", "zawiodłeś", "musisz być silniejszy", "zacznij od nowa", "you lost", "you failed".
- [ ] Confirm supportive phrasing is used instead (e.g. "to był slip, nie porażka", "zapiszmy trigger", "wracamy od teraz").
- [ ] No moral judgment, guilt framing, or pressure language appears anywhere in the slip flow or PrivacySafetyView.

Pass / Issues found:

---

## Sign-off

- [ ] All sections above reviewed.
- [ ] Any issues found are logged separately (not silently fixed during QA).
- [ ] No new feature scope was introduced while testing.

Tester:
Date:
Build/commit tested:
