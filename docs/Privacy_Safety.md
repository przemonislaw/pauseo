# Privacy and Safety — pauseo.app

## Privacy thesis

pauseo.app handles health-adjacent, emotionally sensitive behavior data.

Even if the MVP is not a medical product, the data may reveal:
- nicotine use,
- cravings,
- slips/relapse,
- stress patterns,
- emotional triggers,
- daily routines,
- social/alcohol-related contexts.

Therefore the MVP should be privacy-by-design.

## MVP privacy decision

v0.1 is local-first.

No backend.
No account.
No cloud sync.
No remote push.
No third-party analytics by default.
No selling data.
No advertising SDKs.
No tracking.

## Data minimization

Collect only what is required for the core loop:

- onboarding preferences,
- craving events,
- trigger categories,
- micro-action outcomes,
- slip events,
- daily check-ins,
- local notification preferences.

Do not collect in MVP:

- name,
- email,
- phone number,
- address,
- precise location,
- contacts,
- health records,
- medication usage,
- detailed medical history,
- payment data,
- social graph,
- advertising identifiers.

## Sensitive data categories

Treat the following as sensitive:

- nicotine use status,
- relapse/slip history,
- craving intensity,
- stress/emotion triggers,
- alcohol-related triggers,
- notes written during difficult moments.

## User control

The user should be able to:

- skip optional questions,
- use the app without an account,
- delete local data,
- turn off notifications,
- avoid free-text notes,
- read privacy/safety explanation,
- understand what is stored.

## Plain-language privacy copy

Use copy like:

> “Twoje dane z MVP są przechowywane lokalnie na urządzeniu. Nie tworzysz konta i nie wysyłamy Twoich cravingów na serwer.”

> “Zapisujesz tylko tyle, ile chcesz. Notatki są opcjonalne.”

> “Możesz wyłączyć przypomnienia i usunąć dane lokalne.”

## Medical safety boundary

pauseo.app is not a medical product.

It must not:
- diagnose nicotine dependence,
- assess medical risk,
- recommend medication,
- recommend NRT dosing,
- recommend bupropion, varenicline, cytisine, or any other medication for a specific user,
- tell a user to start, stop, increase, decrease, or combine medication,
- replace professional care,
- present itself as therapy,
- claim guaranteed quitting.

## Required medical disclaimer

Use this wording or a close equivalent:

> “pauseo.app wspiera budowanie nawyków i rozpoznawanie triggerów. Nie zastępuje porady lekarza, terapeuty ani farmaceuty. Jeśli rozważasz leki, nikotynową terapię zastępczą albo masz silne objawy odstawienia, skonsultuj się ze specjalistą.”

## Medication and NRT rules

Allowed:
- general statement that professional support and cessation medications can help some people,
- recommendation to speak with a qualified healthcare professional or pharmacist,
- link to reputable public health resources if reviewed.

Not allowed:
- “take X”
- “use this dose”
- “combine these products”
- “varenicline is best for you”
- “cytisine will work for you”
- “NRT schedule for your profile”
- “stop taking your medication”
- “avoid medication”

## Mental health and crisis safety

The MVP should avoid acting as a crisis product.

If user-generated text or future flows mention self-harm, severe distress, or crisis, the app should show safe referral language.

MVP safe copy:

> “Jeśli jesteś w bezpośrednim zagrożeniu albo możesz zrobić sobie krzywdę, skontaktuj się natychmiast z lokalnym numerem alarmowym lub zaufaną osobą. pauseo.app nie jest narzędziem kryzysowym.”

Do not build complex crisis detection in v0.1 unless explicitly scoped and reviewed.

## Claims policy

### Allowed claims

- “helps you track cravings”
- “helps you notice trigger patterns”
- “offers small replacement actions”
- “supports no-shame recovery after slips”
- “designed for low cognitive load”
- “local-first MVP”
- “behavioral support companion”

### Risky claims

Avoid unless legally and clinically reviewed:

- “evidence-based smoking cessation app”
- “clinically proven”
- “doctor recommended”
- “therapy-grade”
- “medical-grade”
- “AI-powered treatment”
- “personalized treatment plan”

### Forbidden claims

- “guaranteed to quit”
- “quit in X days”
- “cures addiction”
- “treats nicotine dependence”
- “better than medication”
- “replace therapy”
- “replace doctor”
- “safe for everyone”

## Relapse safety

Relapse/slip copy must not produce shame.

Avoid:
- failure states,
- “you lost,”
- “start again from zero,”
- harsh streak reset,
- moral judgment.

Use:
- “slip”
- “wracamy od teraz”
- “zapiszmy trigger”
- “to dane, nie porażka”
- “jedna decyzja nie kasuje wysiłku”

## Notification safety

Notifications must be:

- opt-in,
- sparse,
- user-controlled,
- calm,
- nonjudgmental.

Notifications must not:

- shame,
- create urgency,
- use fear,
- imply medical risk,
- mention sensitive information on lock screen too explicitly.

Safer notification examples:

> “Jedna mała akcja teraz?”

> “30 sekund check-inu, bez oceniania.”

> “Wróć do planu od teraz.”

Avoid:

> “Nie pal!”

> “Znowu zawalisz?”

> “Pamiętaj, że palenie Cię zabija.”

## Lock screen privacy

Because notifications may appear on a lock screen, avoid explicit sensitive wording where possible.

Prefer:
- “moment ryzyka”
- “mała akcja”
- “check-in”
- “wróć od teraz”

Be careful with:
- “palenie”
- “nikotyna”
- “relapse”
- “slip”
- “uzależnienie”

## Analytics decision

v0.1 should not include third-party analytics by default.

If analytics are later considered:
- document the decision,
- explain why local-only metrics are insufficient,
- avoid sensitive event names,
- avoid sending craving/slip text,
- update privacy copy,
- review App Store privacy labels.

## Future backend decision

A backend may be considered later only if it provides clear user value, such as:
- encrypted sync,
- backup,
- cross-device support,
- optional account,
- remote content updates.

Backend must not be added by default.

Before backend:
- create a new architecture decision,
- define data minimization,
- define encryption approach,
- define retention policy,
- define deletion flow,
- define legal/privacy implications,
- update App Store privacy disclosures.

## Safety acceptance checklist

Before release:

- [ ] No medical advice.
- [ ] No medication/NRT dosing.
- [ ] No diagnosis.
- [ ] No guaranteed quitting claims.
- [ ] No shame-based relapse copy.
- [ ] No backend in v0.1.
- [ ] No account in v0.1.
- [ ] No third-party analytics by default.
- [ ] Local data explanation exists.
- [ ] Delete local data option is planned or implemented.
- [ ] Notifications are optional.
- [ ] Lock screen copy is privacy-aware.