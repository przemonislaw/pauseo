# Prompt: grafika w momencie cravingu (wątek A) i badanie potrzeb (wątek B)

> Wersja z 2026-11-26. Wątek A wykonany w sesji 26.11 (wynik w rozmowie, decyzja po stronie foundera). Do wklejenia na start nowego wątku, jeśli kontynuujemy w świeżym kontekście. Nie zastępuje `docs/Next_Session_Prompt.md` (stan projektu i lista zadań).

```text
KONTEKST (26.11.2026, dzień 5 od uploadu 1.0.0 (1)): Pauseo v1.0.0. Zamrożenie UI 06.12
(listing i zrzuty z TestFlight 08–10.12), wysyłka do App Review ~15.12.
Najpierw: git pull --rebase (jest commit 54068db z filmem 4), potem przeczytaj
docs/Inspiration_Onboarding_Reels.md (sekcja 7 w całości), ADR-004, ADR-007, ADR-015,
ADR-017, docs/UX_Principles.md, docs/Privacy_Safety.md (claims policy), CLAUDE.md.
Odpowiadaj po polsku. Zasada pracy: plan → zgoda → zmiany → git diff → commit.

CEL: ocenić, czy do v1.0 (przed zamrożeniem 06.12) wchodzi jeden mały element „żywej”
grafiki wzmacniający moment cravingu, oraz oprzeć priorytety o zweryfikowane potrzeby
użytkowników. NIE zmieniamy strategii (ADR-017: moment, slip to dane, bez konta).

WĄTEK A (decyzja o grafice, rób najpierw, max 1 odpowiedź):
1. Z filmu 4 i sekcji 7.3 wybierz, co nadaje się do Pauseo (już oznaczone: zasada
   „rusza się tylko w odpowiedzi na użytkownika”, miękkie domknięcie sukcesu).
2. Oceń 3 opcje animowanej grafiki, każdą wg bramki poniżej:
   (a) reskin istniejącego koła oddechu w BreathingStep (np. kształt „oddechu”, bez
       twierdzeń o płucach),
   (b) „płuco, które się oczyszcza” / „życie wydłużone o X minut”,
   (c) ikonki zaciągnięć lub czasu palenia.
3. BRAMKA „wchodzi do v1.0” (wszystkie naraz): pomaga w sekundach cravingu; zero nowych
   danych i pól w EventStore; zero twierdzeń zdrowotnych i fear appeals (claims policy,
   brief); ton dorosły (CLAUDE.md); Reduce Motion działa; wykonalne w ≤4 h + QA;
   usuwalne jednym commitem; nie przesuwa zamrożenia UI.
4. Wynik: tabela opcja | spełnia/nie spełnia każdy warunek | estymata h | ryzyko.
   Rekomendacja jedna. Format CURRENT STATE → … → RISKS z CLAUDE.md.
5. Liczby z mojej pamięci (20 min życia na papieros, 3–6 min palenia, 10–14 zaciągnięć)
   traktuj jako [DO WERYFIKACJI]; nie używaj ich w UI ani marketingu. Sprawdź źródła
   (PubMed, WHO, NHS) i powiedz, czy w ogóle wolno ich użyć w treściach edukacyjnych na
   pauseo.app, z podanym źródłem.

WĄTEK B (badanie potrzeb, osobna odpowiedź, bez kodu):
Źródła: recenzje 1–3★ w App Store PL i EN dla 5–8 aplikacji do rzucania (publiczne),
Google Trends i podpowiedzi wyszukiwarki dla fraz PL, rzetelne publikacje (craving,
urge surfing, slip/lapse). Każdy wniosek oznacz [FAKT z URL] / [HIPOTEZA]; podaj datę
i zakres próby. Wynik: tabela potrzeba | dowód (URL) | pewność | co to znaczy dla Pauseo
(copy, listing, kolejność ekranów) | czy wymaga zmiany w aplikacji (domyślnie: nie).
Szukamy luki do wzmocnienia istniejącego pozycjonowania, nie nowej funkcji.

ZASADY: żadnych nowych funkcji bez mojej zgody; nie commituj szumu z Localizable.xcstrings;
konflikt z kanonem zgłoś i zaproponuj alternatywę; po wdrożeniu build 2 = podbić
CURRENT_PROJECT_VERSION i powtórzyć QA 15/17/20. ASC (pozycja 1) startuje równolegle i
nie czeka na wynik tych wątków.
```
