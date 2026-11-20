# QA Checklist v0.1 — pauseo.app

Manual QA checklist for the current MVP state, after Privacy & Safety.

This is a docs-only checklist. It does not describe new features. It verifies that the current implementation matches `docs/Current_State.md` and `docs/Privacy_Safety.md`.

Run through every section on a real device or simulator. Fill in Pass / Issues found under each section.

---

## 1. Home emergency screen

- [x] Home shows exactly three actions: primary "Mam craving teraz", secondary "Zdarzył mi się slip" (was "Miałem slip" until 2026-11-20), tertiary "Prywatność i dane".
- [x] No other buttons, cards, lists, streaks, or numbers are visible on Home.
- [x] Home does not read like a dashboard (no charts, no history, no stats).
- [x] Primary CTA opens the craving flow.
- [x] Secondary action opens the slip recovery flow.
- [x] Tertiary link opens PrivacySafetyView as a sheet.

Pass

---

## 2. Onboarding UI flow

- [x] ~~Onboarding shows 5 screens: welcome, nicotine type, goal mode, main trigger, notifications.~~ Superseded 2026-11-20 by section 16 (single-screen onboarding).
- [x] Each screen has one primary action to continue.
- [x] Onboarding can be completed start to finish without errors or dead ends.
- [x] Selections are not required to be filled in a way that blocks progress (no forced free-text).
- [x] Copy tone is calm, direct, non-judgmental — no childish or moralizing language.
- [x] Completing onboarding returns the user to Home.

Pass

---

## 3. Craving flow

- [x] Opens from Home primary CTA.
- [x] ~~Shows 4 screens: grounding, trigger selection, micro-action selection, completion.~~ Superseded 2026-11-20 by section 18 (trigger asked last).
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

- [x] After completing the micro-action step ("Zrobię to"), the invitation screen "Zostań ze mną jeszcze 3 minuty?" appears before the closing screen.
- [x] Declining the invitation ("Kończę na teraz") goes straight to the existing neutral closing screen — same copy as before this feature.
- [x] Accepting the invitation shows one instruction at a time with a visible countdown/progress bar, no list of techniques.
- [x] The full sequence runs for about 3 minutes and auto-advances without requiring taps between stages.
- [x] Backgrounding the app during the loop and returning keeps the countdown accurate (not paused/reset).
- [x] "Kończę na teraz" is visible and works at any point during the loop, exiting to the outcome question.
- [x] After a round (full 3 minutes or early exit), the outcome question "Co się teraz dzieje?" appears with exactly three options: "Nie zapaliłem/am", "Odłożyłem/am decyzję", "Zapaliłem/am".
- [x] The second-round offer ("Daję sobie jeszcze 3 minuty" / "Kończę na teraz") appears only when the first outcome selected was "Odłożyłem/am decyzję".
- [x] The second-round offer does not appear after "Nie zapaliłem/am" or "Zapaliłem/am".
- [x] Accepting the second-round offer repeats the same 3-minute guided sequence; after its outcome question, no further round is offered.
- [x] Every ending (declined invitation, or any outcome/round combination) shows the same neutral closing screen — no praise or shame language that varies by outcome.
- [x] No instruction or supportive text claims that breathing or any single action removes the craving.
- [x] Complete one full session (with a second round) and relaunch the app — confirm no crash and existing craving/slip events from before this feature are still readable.
- [x] Force-quit the app mid-loop (after the invitation was accepted) and relaunch — confirm no crash and no duplicate craving events were created for that session.
- [x] Full sequence works in airplane mode (no network calls).
- [x] Delete-all in PrivacySafetyView still clears craving events created via this flow.

Pass

---

## 14. Guided 2-minute craving loop with support cards

Verified on a physical device, including VoiceOver and Reduce Motion behaviour.

- [x] After the micro-action step, the invitation screen reads "Zostań ze mną jeszcze 2 minuty?" (not 3 minutes).
- [x] Accepting the invitation starts a round that lasts about 120 seconds, not 180.
- [x] During the round, one short support card is shown at a time; a new card appears roughly every 10 seconds.
- [x] No card repeats within a single round.
- [x] Consecutive cards are not visibly all from the same category (spot-check a few transitions).
- [x] The countdown, progress bar, and "Kończę na teraz" remain visible and usable throughout the round.
- [x] No card claims that the craving will disappear or that a technique removes it.
- [x] No card contains medication, NRT, or medical-treatment guidance.
- [x] Background the app mid-round and return — the round does not restart, and the card shown matches the actual elapsed time (not the card that was showing when backgrounded).
- [x] Force-quit mid-round and relaunch — no crash, no duplicate `CravingEvent` created for that session.
- [x] Complete a round fully (2 minutes) and confirm the outcome question appears with the same three options as before.
- [x] Trigger a second round (choose "Odłożyłem/am decyzję") — button reads "Daję sobie jeszcze 2 minuty", and the card order/selection differs noticeably from round 1 where possible.
- [x] Enable **Reduce Motion** in device Accessibility settings — confirm card changes show no animated/sliding transition.
- [x] Enable **VoiceOver** and let a round run — confirm the app does not automatically announce each new card and does not force VoiceOver focus to move; confirm the currently visible card can still be read by manually swiping to it.
- [x] Full round works in airplane mode (no network calls).
- [x] Delete-all in PrivacySafetyView still clears craving events created via this flow.
- [x] Existing craving/slip events created before this change still load without error.
- [x] Dev-time only: temporarily rename or corrupt `support_cards.json`, rebuild, and confirm the app does not crash and still shows a small set of fallback cards, then restore the real file.

Tester: Abelard
Date: 14.11.2026
Build/commit tested: c0294a0 — docs: update product contract for 2-minute guided loop with support cards

Pass

---

## 15. PL/EN localization

Not a new feature — verifies that the existing flows from sections 1–14 render correctly in both Polish and English, that data compatibility is preserved, and that language fallback works. Run the full sequence below **once with the device language set to Polish, and once set to English.**

- [x] Complete the full onboarding flow (all 5 screens, every option in each selection step — superseded by section 16 for the single-screen onboarding) and confirm every title, option label, and button is in the active language with no missing keys and no mixed-language text.
- [x] Home shows exactly the three actions from section 1, all in the active language.
- [x] Complete the craving flow: grounding → trigger selection (all options) → micro-action selection (all options) → completion, confirming every screen is in the active language.
- [x] Decline the guided-loop invitation ("I'm done for now" / "Kończę na teraz") and confirm it goes straight to the same neutral closing screen as before, in the active language.
- [x] Accept the guided-loop invitation and let a full 120-second round run, confirming the countdown, progress bar, and "I'm done for now" control are in the active language.
- [x] Exit the guided loop early via "I'm done for now" and confirm the outcome question appears correctly.
- [x] Trigger all three outcomes in turn ("I didn't smoke" / "I've put off the decision" / "I smoked") across repeated runs, confirming each option reads correctly and the save values are unaffected (see data-compatibility checks below).
- [x] After choosing "I've put off the decision", confirm the second-round offer appears ("I'll take 2 more minutes" / "I'm done for now") — and not after the other two outcomes — and that it is offered at most once.
- [x] During guided-loop rounds, observe enough card rotations to see all 15 bundled support cards at least once across both language runs; confirm each card's text is fully translated, with no leftover Polish in the English run or vice versa.
- [x] Dev-time only: temporarily rename/corrupt `support_cards.json`, rebuild, and confirm all 5 fallback cards render correctly in the active language, then restore the real file.
- [x] Complete the slip recovery flow (shame-reduction → context selection, all options → recovery action, all options → completion), confirming every screen is in the active language.
- [x] Open Privacy & Safety from Home; confirm all section titles, body text (including the corrected "Where your data is" / "Gdzie są dane" copy), the medical disclaimer, and the delete button are in the active language.
- [x] Trigger "Delete all local data" and confirm both the alert title/message and both alert buttons (Delete/Cancel or Usuń/Anuluj) are in the active language; confirm both choosing to delete and choosing to cancel behave correctly.
- [x] Repeat the above on a small-screen device/simulator and with the largest Dynamic Type accessibility size — confirm no text is clipped or truncated in either language.
- [x] Enable VoiceOver and navigate through onboarding, the craving flow, and Privacy & Safety — confirm every label is read in the active language, the guided-loop timer is announced correctly, and a new support card is not force-announced on every rotation (same behavior as section 14).
- [x] Enable Reduce Motion and confirm card-text changes during the guided loop still show no animated transition in either language.
- [x] Put the device in airplane mode and confirm the full app (onboarding through delete-data) still works with no network calls, in both languages.
- [x] Background the app mid-guided-loop and return; confirm the round does not restart and the language does not change.
- [x] Force-quit the app and relaunch in each language; confirm no crash and no duplicate `CravingEvent`.
- [x] **Data-compatibility check:** with the device language set to English, complete one craving flow and one slip flow; relaunch with the device language set back to Polish and confirm no crash. (The underlying stored `trigger`/`action`/`context`/`recoveryAction` values are Polish regardless of display language by design — this step only confirms the app does not crash or corrupt data across a language switch, not that stored values change.)
- [x] **Existing-data check:** confirm craving/slip events created before this localization change (if any are still present on the test device) still load without error after switching the device language.
- [x] Switch device language Polish → English → Polish (via Settings → Pauseo → Language, or device-wide Settings → General → Language & Region) without reinstalling, relaunching the app after each switch, and confirm the UI fully matches the new language each time with nothing stuck in the previous language.
- [x] Set the device to a third, unsupported language (e.g. German) and confirm the app falls back to English with no missing keys and no crash.
- [x] Spot-check for missing keys or mixed languages: no raw catalog key, no untranslated literal, and no screen mixing Polish and English in the same run.

Tester: Abelard
Date: 14.11.2026
Build/commit tested: Phase 1 PL/EN localization (pre-commit working tree, based on 38b7de0)

Pass

---

## 16. Visual system — physical-device check

Verifies the applied visual design (`docs/Current_State.md` → Visual system) on a real iPhone, in Polish and English, light and dark mode.

- [x] Onboarding "What do you use?" / "Z czego korzystasz?" — option selection, checkmark visible, readable at large Dynamic Type.
- [x] Craving flow trigger and micro-action selection, slip flow context and recovery action selection — checkmarks clear in light and dark mode.
- [x] Home, outcome question and Privacy & Safety — contrast, buttons visible, no clipped text.

Tester: Przemek
Date: reported 20.11.2026
Build/commit tested: 5da9179 (design pass) and later

Pass

---

## 17. Single-screen onboarding

Verifies the 2026-11-20 change: onboarding cut from 5 screens to 1.

- [ ] Fresh install (or delete app first): exactly one onboarding screen is shown — title, body, privacy line, one button.
- [ ] No Back button, no progress indicator, no selection screens, no reminders screen.
- [ ] Privacy line reads "Bez konta. Twoje dane zostają w telefonie." (PL) / "No account. Your data stays on your phone." (EN).
- [ ] Tapping "Zacznij spokojnie" / "Let's begin" opens Home immediately; Home shows the three actions from section 1.
- [ ] Relaunch after completing onboarding: app opens directly on Home (onboarding not shown again).
- [ ] Existing install that already completed onboarding: opens on Home, no change.
- [ ] Largest Dynamic Type and small-screen device: no clipped text, button reachable.
- [ ] VoiceOver reads title, body, privacy line and button in the active language.
- [ ] Light and dark mode: privacy line readable (secondary text contrast).

Tester:
Date:
Build/commit tested:

---

## 18. Craving flow order: help first, trigger last

Verifies the 2026-11-20 change. Run in PL and EN, light and dark mode.

- [ ] "I'm having a craving" → "Pause for a moment" → "Help me now" opens the **micro-action** screen (not the trigger question).
- [ ] Back on the micro-action screen returns to "Pause for a moment"; no Back button after that.
- [ ] Path A — decline the 2-minute loop ("I'm done for now"): trigger question appears, then completion.
- [ ] Path B — full 2-minute loop → outcome "I didn't smoke": trigger question, then completion.
- [ ] Path C — exit loop early → outcome "I smoked": trigger question, then completion (copy stays neutral).
- [ ] Path D — outcome "I've put off the decision" → second round offered → after it, outcome → trigger question → completion. Trigger question appears exactly once per flow.
- [ ] Choose "Go outside for 2 minutes" or "Message someone": invitation reads "Go ahead, do it now. I'll be here." / "Śmiało, zrób to teraz. Będę tutaj." with the "When you're back…" body; switch to another app and back — the screen is still there.
- [ ] Choose "Drink water", "Take 5 calm breaths", "Keep your hands busy", or no action: invitation still reads "Stay with me for 2 more minutes?".
- [ ] Micro-action list shows "Napisz komuś: „co u Ciebie?”" / "Text someone: “how are you?”" on one or two lines without clipping (largest Dynamic Type too); the slip flow still shows "Napisz do kogoś" / "Message someone".
- [ ] Trigger can be skipped: "Next" with nothing selected goes to completion.
- [ ] Unselected trigger and action chips are visible in dark mode (fix 57b75db).
- [ ] Swipe the sheet away on the trigger question: no crash; relaunch, no duplicate event.

Tester:
Date:
Build/commit tested:

---

## 19. Copy pass and guided breathing

Verifies the 2026-11-20 copy changes and the guided breathing step. PL and EN, light and dark mode.

- [ ] Home secondary button reads "Zdarzył mi się slip" (PL) / "I've had a slip" (EN).
- [ ] Craving micro-actions show the new concrete labels (water in small sips, change rooms, 5 breaths 4/6, pen or mug, "co u Ciebie?"); no "Odłóż decyzję o 5 minut" option.
- [x] Choose "5 oddechów…": breathing screen opens; circle grows for 4 s ("Wdech"), shrinks for 6 s ("Wydech"); seconds count down; counter reads "Zostało 5 oddechów" → "Zostały 4/3/2 oddechy" → "Ostatni oddech" (EN "5 breaths left" … "Last breath").
- [x] After ~50 s the invitation "Stay with me for 2 more minutes?" appears automatically.
- [ ] "Pomiń oddychanie" / "Skip breathing" goes straight to the invitation.
- [ ] Background the app mid-breathing and return: the exercise continues from real elapsed time (no restart).
- [ ] Reduce Motion on: circle does not scale; text and counter still change.
- [ ] VoiceOver: "Breathe in/out" and the counter are read; the circle is not focusable.
- [ ] Trigger question (craving) has the subtitle "Przyda się następnym razem. Możesz pominąć." / "Helps next time. You can skip this."; the slip flow keeps "Możesz pominąć."
- [ ] Trigger question reads "Co uruchomiło craving?"; options include "Kawa" / "Coffee".
- [ ] Completion reads "To wystarczy na teraz." with "Jedna mała akcja się liczy. Jeśli ochota wróci, po prostu tu wróć."; button "Wróć na start" (PL).
- [ ] Slip flow: "Co działo się tuż przed?" with "Kawa" option; recovery actions show "Schowaj nikotynę w innym pokoju" and "Następna godzina bez nikotyny" (EN "Next hour nicotine-free", no "Start again"); slip still shows "Napisz do kogoś".
- [ ] Largest Dynamic Type: longer action labels wrap without clipping.

Note: guided breathing opening and auto-continue confirmed working on device by Przemek (20.11.2026); remaining items still to run.

Tester:
Date:
Build/commit tested:

---

## Sign-off

- [x] All sections above reviewed.
- [x] Any issues found are logged separately (not silently fixed during QA).
- [x] No new feature scope was introduced while testing.

Tester: Przemek
Date: 31.07.2026
Build/commit tested: 
