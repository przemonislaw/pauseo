# QA Checklist v0.1 — pauseo.app

Manual QA checklist for the current MVP state, after Privacy & Safety.

This is a docs-only checklist. It does not describe new features. It verifies that the current implementation matches `docs/Current_State.md` and `docs/Privacy_Safety.md`.

Run through every section on a real device or simulator. Fill in Pass / Issues found under each section.

---

## 1. Home emergency screen

- [x] Home shows exactly three actions: primary "Mam craving teraz", secondary "Miałem slip", tertiary "Prywatność i dane".
- [x] No other buttons, cards, lists, streaks, or numbers are visible on Home.
- [x] Home does not read like a dashboard (no charts, no history, no stats).
- [x] Primary CTA opens the craving flow.
- [x] Secondary action opens the slip recovery flow.
- [x] Tertiary link opens PrivacySafetyView as a sheet.

Pass

---

## 2. Onboarding UI flow

- [x] Onboarding shows 5 screens: welcome, nicotine type, goal mode, main trigger, notifications.
- [x] Each screen has one primary action to continue.
- [x] Onboarding can be completed start to finish without errors or dead ends.
- [x] Selections are not required to be filled in a way that blocks progress (no forced free-text).
- [x] Copy tone is calm, direct, non-judgmental — no childish or moralizing language.
- [x] Completing onboarding returns the user to Home.

Pass

---

## 3. Craving flow

- [x] Opens from Home primary CTA.
- [x] Shows 4 screens: grounding, trigger selection, micro-action selection, completion.
- [x] Flow can be completed start to finish.
- [x] Flow can be exited/cancelled without crashing.
- [x] Completion screen tone matches supportive, non-judgmental style (no praise pressure, no gamified reward language).
- [x] Completing the flow creates a stored craving event (verify via section 5).

Pass 

---

## 4. Slip recovery flow

- [x] Opens from Home secondary action.
- [x] Shows 4 screens: shame-reduction, context selection, recovery action, completion.
- [x] Flow can be completed start to finish.
- [x] Flow can be exited/cancelled without crashing.
- [x] No screen uses failure language ("lost", "failed", "start over from zero", streak reset).
- [x] Completing the flow creates a stored slip event (verify via section 5).

Pass 

---

## 5. Local persistence for craving/slip events

- [x] Complete one craving flow and one slip flow.
- [x] Force-quit the app and relaunch.
- [x] Confirm the app does not crash and no data-loss error appears.
- [x] Confirm events are not displayed anywhere as history, list, chart, or statistic (none should exist yet).
- [x] No network call is made when a craving or slip event is saved (airplane mode: flow still completes and saves).

Pass 

---

## 6. PrivacySafetyView

- [x] Opens as a sheet from Home tertiary link "Prywatność i dane".
- [x] Sheet can be dismissed and returns cleanly to Home.
- [x] Explains what is stored locally (craving events, slip events).
- [x] States there is no account and no backend.
- [x] Contains a way to delete all local data.
- [x] Contains the medical disclaimer (verify exact wording in section 8).
- [x] Does not show statistics, event history, trigger insights, charts, or dashboard content.

Pass

---

## 7. Delete all local data flow

- [x] Trigger delete action from PrivacySafetyView.
- [x] Confirm craving and slip events are cleared (no longer counted/present after relaunch).
- [x] Force-quit and relaunch app after deletion — confirm no old events reappear.
- [x] App remains usable after deletion (no crash, no broken state).

Pass

---

## 8. Medical disclaimer presence

- [x] Disclaimer text is present in PrivacySafetyView.
- [x] Wording matches or is a close equivalent of the required disclaimer in `docs/Privacy_Safety.md`:
  > "pauseo.app wspiera budowanie nawyków i rozpoznawanie triggerów. Nie zastępuje porady lekarza, terapeuty ani farmaceuty. Jeśli rozważasz leki, nikotynową terapię zastępczą albo masz silne objawy odstawienia, skonsultuj się ze specjalistą."
- [x] No dosage, medication comparison, NRT schedule, or diagnosis language appears anywhere in the app.

Pass

---

## 9. No backend / no analytics / no AI / no HealthKit / no auth

- [x] Full app usage (onboarding, craving flow, slip flow, delete data) works in airplane mode.
- [x] No login, signup, or account screen exists anywhere.
- [x] No HealthKit permission prompt appears at any point.
- [x] No AI/chat/coach interface exists anywhere.
- [x] No third-party analytics SDK initialization or network calls observed (check device network activity if possible).

Pass 

---

## 10. No dashboard / statistics / trigger insights accidentally introduced

- [x] Home contains no charts, counts, streaks, or history.
- [x] PrivacySafetyView contains no charts, counts, streaks, or history.
- [x] No screen in the app displays aggregated craving/slip data, trends, or trigger pattern summaries.
- [x] No "Progress" or "Insights" screen is reachable from any current flow.

Pass 

---

## 11. Low cognitive load review

- [x] Each screen across all flows has one clear primary action.
- [x] Copy on each screen is short (no long paragraphs, no dense text blocks).
- [x] Default selections/choices are available where relevant — user is not forced to fill many fields.
- [x] No screen requires more than a few taps to complete its purpose.
- [x] No excessive animation, gamification, or decorative complexity.

Pass

---

## 12. Shame-free relapse/slip copy review

- [x] Read every string shown in the slip recovery flow end to end.
- [x] Confirm none of the forbidden phrases (or close equivalents) appear: "straciłeś serię", "zawiodłeś", "musisz być silniejszy", "zacznij od nowa", "you lost", "you failed".
- [x] Confirm supportive phrasing is used instead (e.g. "to był slip, nie porażka", "zapiszmy trigger", "wracamy od teraz").
- [x] No moral judgment, guilt framing, or pressure language appears anywhere in the slip flow or PrivacySafetyView.

Pass

---

## 13. Guided 3-minute craving loop

- [ ] After completing the micro-action step ("Zrobię to"), the invitation screen "Zostań ze mną jeszcze 3 minuty?" appears before the closing screen.
- [ ] Declining the invitation ("Kończę na teraz") goes straight to the existing neutral closing screen — same copy as before this feature.
- [ ] Accepting the invitation shows one instruction at a time with a visible countdown/progress bar, no list of techniques.
- [ ] The full sequence runs for about 3 minutes and auto-advances without requiring taps between stages.
- [ ] Backgrounding the app during the loop and returning keeps the countdown accurate (not paused/reset).
- [ ] "Kończę na teraz" is visible and works at any point during the loop, exiting to the outcome question.
- [ ] After a round (full 3 minutes or early exit), the outcome question "Co się teraz dzieje?" appears with exactly three options: "Nie zapaliłem/am", "Odłożyłem/am decyzję", "Zapaliłem/am".
- [ ] The second-round offer ("Daję sobie jeszcze 3 minuty" / "Kończę na teraz") appears only when the first outcome selected was "Odłożyłem/am decyzję".
- [ ] The second-round offer does not appear after "Nie zapaliłem/am" or "Zapaliłem/am".
- [ ] Accepting the second-round offer repeats the same 3-minute guided sequence; after its outcome question, no further round is offered.
- [ ] Every ending (declined invitation, or any outcome/round combination) shows the same neutral closing screen — no praise or shame language that varies by outcome.
- [ ] No instruction or supportive text claims that breathing or any single action removes the craving.
- [ ] Complete one full session (with a second round) and relaunch the app — confirm no crash and existing craving/slip events from before this feature are still readable.
- [ ] Force-quit the app mid-loop (after the invitation was accepted) and relaunch — confirm no crash and no duplicate craving events were created for that session.
- [ ] Full sequence works in airplane mode (no network calls).
- [ ] Delete-all in PrivacySafetyView still clears craving events created via this flow.

Pass / Issues found:

---

## Sign-off

- [x] All sections above reviewed.
- [x] Any issues found are logged separately (not silently fixed during QA).
- [x] No new feature scope was introduced while testing.

Tester: Przemek
Date: 31.07.2026
Build/commit tested: 
