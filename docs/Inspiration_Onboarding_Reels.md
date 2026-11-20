# Inspiracje: 2 rolki o onboardingu → co bierzemy do Pauseo

> **Data:** 2026-11-20 · **Status:** materiał inspiracyjny, nie zatwierdzony zakres. Zmiany w kodzie wymagają pozycji w `docs/Backlog_v0.1.md` albo zgody foundera.
> **Źródło:** dokument „Onboarding – transkrypcje 2 rolek (inspiracje dla Pauseo)”: https://claude.ai/artifact/SpXG9h5oBeYCcwGQih7sEF (pełne transkrypcje EN/PL i opis ekranów).
> **Pierwszeństwo:** kanon produktu (`CLAUDE.md`, `docs/UX_Principles.md`, `docs/Privacy_Safety.md`, ADR-007, ADR-014, ADR-015) wygrywa z taktykami z rolek.

## 1. Rolki w skrócie

| Rolka | Teza | Mechanizm |
|---|---|---|
| **1 — @agenticmatt, „The car wash trick”** | Pasek postępu startujący od zera to błąd. Bliskość mety zwiększa wysiłek. | Goal gradient + endowed progress (Nunes & Drèze, 2006: karta 10 pól z 2 przybitymi vs 8 pustych → 34% vs 19% ukończeń) [FAKT: plansza w filmie; wynik badania DO WERYFIKACJI w oryginale]. 5 zasad: pasek przy procesie >1 ekranu, nie od zera, najszybszy krok pierwszy, pod koniec „ile zostało”, po sukcesie nie wracaj do pustego paska. |
| **2 — @app.launchpad, „Comment FLOW”** | Większość użytkowników zobaczy tylko onboarding, więc każdy ekran musi coś dać. | 4 zasady: pierwszy ekran sprzedaje efekt, daj zanim poprosisz, każde pytanie musi coś zmieniać, paywall po pierwszym sukcesie. Ćwiczenie: zrzut każdego ekranu i dopisek „co użytkownik dostał?”. Fragment o Buildercult.ai to reklama płatnego kursu, pomijamy. |

## 2. Audyt obecnego onboardingu Pauseo (ćwiczenie z rolki 2)

[FAKT: `Pauseo/Onboarding/OnboardingFlowView.swift`, odczyt 2026-11-20]

| # | Ekran | Co użytkownik dostaje? | Werdykt |
|---|---|---|---|
| 1 | „Support when a craving hits.” / „Pomoc na moment cravingu.” | obietnicę i zrozumienie, do czego jest appka | ✅ zostaje |
| 2 | Co używasz? (papierosy / vape / …) | **nic**: wybór trzymany tylko w `@State`, nie zapisywany ani nie używany | ❌ |
| 3 | Tryb (rzucam / ograniczam / …) | **nic**: jw. | ❌ |
| 4 | Główny trigger | **nic**: jw. | ❌ |
| 5 | „Reminders later.” | **nic**: dwa przyciski („Go to the app” i „Not now”) robią to samo | ❌ |

**Wniosek:** z 5 ekranów 1 daje wartość. Trzy pytania łamią wprost zasadę 3 z rolki 2 („pytanie, które niczego nie zmienia, marnuje czas”) oraz zasadę niskiego obciążenia poznawczego z kanonu. Dla osoby, która instaluje appkę w trakcie cravingu, to 4 ekrany między nią a pomocą.

## 3. Co bierzemy, co adaptujemy, czego nie bierzemy

| Pomysł z rolek | Werdykt | Jak w Pauseo | Uzasadnienie (kanon) |
|---|---|---|---|
| Każdy ekran musi coś dać; pytania muszą coś zmieniać | ✅ **bierzemy** | Onboarding v0.1 skrócony do 1 ekranu (obietnica + „bez konta, dane zostają w telefonie” + CTA) → Home. Pytania wrócą dopiero, gdy coś zmienią (np. trigger z onboardingu podpowiedziany w logu cravingu, typ nikotyny w copy). | low cognitive load, „one primary action”, Product_MVP: onboarding <90 s |
| Pierwszy ekran sprzedaje efekt | ✅ **adaptujemy** | Efekt jako doświadczenie, nie wynik zdrowotny: „Gdy przyjdzie ochota, masz plan na 2 minuty.” | claims policy: zakaz obietnic rzucenia i liczb typu „6 lat życia z powrotem” (Opal) |
| Daj, zanim poprosisz | ✅ **bierzemy** (już jest) | Brak konta, brak prośby o powiadomienia, brak zapraszania znajomych. To wyróżnik, warto go powiedzieć wprost na ekranie 1. | ADR-003, ADR-008, ADR-017 |
| „Daj wartość w dniu 1” | 🧪 **hipoteza v0.2** | Moment wartości w Pauseo to pierwszy craving, którego nie da się zaplanować. Pomysł: opcjonalne „Zobacz, jak to działa (30 s)” na końcu onboardingu, krótkie demo mikro-akcji, żeby w momencie cravingu użytkownik wiedział, co go czeka. | wiąże się z ryzykiem Z2 (czy ludzie otworzą appkę w momencie cravingu) |
| Pod koniec pokazuj „ile zostało” | ✅ **już jest** | 2-minutowa sekwencja pokazuje pozostały czas (`timeString(remaining)`) i pasek postępu [FAKT: `CravingFlowView.swift`]. Sekwencja cravingu ma prawdziwą metę, a goal gradient pasuje tu naturalnie. Ewentualny drobiazg na później: łagodne copy w ostatnich ~20 s („Prawie. Zostało kilka oddechów.”). | wspiera rdzeń pętli |
| Po sukcesie nie wracaj do pustego paska | ✅ **bierzemy jako zasadę** | To ADR-007 innymi słowami. Przyszły licznik „przetrwanych cravingów” nigdy się nie zeruje, slip go nie kasuje. | ADR-007, no shame |
| Pasek postępu w onboardingu i sztuczny postęp („Pobrano aplikację ✓ 1/6”) | ⛔ **nie bierzemy** | Przy onboardingu z 1 ekranu pasek jest zbędny. Sztucznie dany postęp to nudge, który przy kategorii uzależnień zbyt łatwo staje się manipulacją. | „never manipulative”; lepiej skrócić niż popychać |
| „Dzień 1 ✓” na Home po onboardingu | ⛔ **nie bierzemy** | Licznik dni to zalążek streaka, który zeruje się po slipie. Home zostaje ekranem awaryjnym. | ADR-007, Product_MVP („Home must not become a dashboard”) |
| Gamifikacja w stylu Duolingo / Starbucks (gwiazdki, poziomy) | ⛔ **nie bierzemy** | — | Product_MVP: bez ekonomii odznak |
| Paywall po pierwszym sukcesie | ↪️ **przenosimy na prośbę o ocenę** | Brak paywalla (ADR-015). Ta sama zasada „po pierwszym sukcesie” dotyczy prośby o ocenę w App Store: po wyniku „Nie zapaliłem/am”, nigdy po slipie, maksymalnie raz (brief 6.3). | ADR-015, no shame |
| Jedno zdarzenie analityczne na ekran, napraw największy spadek | ↪️ **adaptujemy jakościowo** | W v0.1 nie ma analityki (ADR-014). Zamiast tego founder robi zrzuty ekranów z dopiskiem „co dostał?” (ten dokument, sekcja 2), a w becie pytamy testerów, gdzie się zatrzymali. | ADR-014 |

## 4. Wykorzystanie w marketingu

- **Format wideo pod ADR-018:** obie rolki stosują swoją zasadę w samym filmie (pasek postępu wideo, licznik „users still here”). Dla Pauseo naturalny format to **wideo trwające tyle, co sekwencja: „Przeczekaj ze mną te 2 minuty”**, z widocznym odliczaniem na ekranie. Treść jest wtedy jednocześnie demem produktu, a pasek trzyma widza do końca [HIPOTEZA: retencja wideo].
- **Hook z audytu:** „Większość aplikacji do rzucania palenia zadaje 10 pytań, zanim pomoże. Pauseo ma jeden ekran.” Wolno to mówić ogólnie, bez nazw konkurentów (ADR-017) [DO WERYFIKACJI: policzyć ekrany onboardingu Smoke Free, QuitNow i Kwit przy audycie konkurencji].
- **Screenshot #1 w App Store:** Home z jednym przyciskiem plus podpis o braku konta. Spójne z zasadą „daj, zanim poprosisz”.

## 5. Zmiana przed premierą: **zatwierdzona i wdrożona 2026-11-20** (QA: `docs/QA_Checklist_v0.1.md` sekcja 17)

**Skrócenie onboardingu do 1 ekranu** (usunięcie ekranów 2–5, bez nowych danych i bez nowej logiki).
- Dlaczego przed 15.12: to usuwanie, nie budowanie, więc ryzyko jest małe. Usuwa 4 ekrany bez wartości z drogi do pomocy. Wpływa na pierwsze recenzje.
- Contract drift: `docs/Product_MVP.md` (sekcja Onboarding, ekrany 2–5) trzeba zaktualizować razem ze zmianą.
- Do sprawdzenia w kodzie: czy cokolwiek odczytuje `UserPreferences` z onboardingu (stan na 2026-11-20: nie).
