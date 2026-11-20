# Inspiracje: 3 rolki o onboardingu i konwersji → co bierzemy do Pauseo

> **Data:** 2026-11-20 · **Status:** materiał inspiracyjny, nie zatwierdzony zakres. Zmiany w kodzie wymagają pozycji w `docs/Backlog_v0.1.md` albo zgody foundera.
> **Źródło:** rolki 1–2: dokument „Onboarding – transkrypcje 2 rolek (inspiracje dla Pauseo)”: https://claude.ai/artifact/SpXG9h5oBeYCcwGQih7sEF (pełne transkrypcje EN/PL i opis ekranów). Rolka 3: transkrypcja w sekcji 6 tego pliku.
> **Pierwszeństwo:** kanon produktu (`CLAUDE.md`, `docs/UX_Principles.md`, `docs/Privacy_Safety.md`, ADR-007, ADR-014, ADR-015) wygrywa z taktykami z rolek.

## 1. Rolki w skrócie

| Rolka | Teza | Mechanizm |
|---|---|---|
| **1 — @agenticmatt, „The car wash trick”** | Pasek postępu startujący od zera to błąd. Bliskość mety zwiększa wysiłek. | Goal gradient + endowed progress (Nunes & Drèze, 2006: karta 10 pól z 2 przybitymi vs 8 pustych → 34% vs 19% ukończeń) [FAKT: plansza w filmie; wynik badania DO WERYFIKACJI w oryginale]. 5 zasad: pasek przy procesie >1 ekranu, nie od zera, najszybszy krok pierwszy, pod koniec „ile zostało”, po sukcesie nie wracaj do pustego paska. |
| **2 — @app.launchpad, „Comment FLOW”** | Większość użytkowników zobaczy tylko onboarding, więc każdy ekran musi coś dać. | 4 zasady: pierwszy ekran sprzedaje efekt, daj zanim poprosisz, każde pytanie musi coś zmieniać, paywall po pierwszym sukcesie. Ćwiczenie: zrzut każdego ekranu i dopisek „co użytkownik dostał?”. Fragment o Buildercult.ai to reklama płatnego kursu, pomijamy. |
| **3 — @edward.builds, „simplify your conversion pages”** | Na ekranach konwersji (rejestracja, paywall) wygrywa wersja prostsza i konkretniejsza, nie „ładna” ani „urocza”. | Pokazane testy A/B: Ring (prosty ekran rejestracji wygrał z ładnym), Audible („1 miesiąc” zamiast „30 dni”), Headway (konkretne „#1 most downloaded book summary app” zamiast „Let's start your fun and easy growth!”), „Premium” vs „Boss up, go premium” (wygrało „Premium”). Zasada: każdy ekran mówi prosto, co to jest i co użytkownik na tym zyska [HIPOTEZA: autor nie podaje liczb, próby ani źródeł testów, tylko „won by far”]. |

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
| Uprość stronę konwersji (rolka 3) | ✅ **bierzemy** (pauseo.app, App Store) | Strona pauseo.app i listing: problem → 2-minutowe demo → jedno CTA, bez ozdobników. Każdy ekran odpowiada na dwa pytania: „co to jest?” i „co z tego mam?”. | brief: kanał własny (pauseo.app + lista oczekujących), ADR-017, low cognitive load |
| Konkret zamiast „uroczego” copy (rolka 3: „fun and easy growth”, „Boss up”) | ✅ **bierzemy** | Copy opisuje doświadczenie: „2 minuty, które pomagają przeczekać głód”. Ton dorosły, bez „fajnie i łatwo”, bez żargonu motywacyjnego. | CLAUDE.md (ton: adult, concise, never childish), claims policy (brief) |
| Testuj drobne sformułowania (rolka 3: „miesiąc” vs „30 dni”) | ↪️ **adaptujemy jakościowo, A/B później** | Najpierw słownik użytkownika z bety: „craving” czy „głód / ssanie / chęć zapalenia” (5–10 wywiadów). Product Page Optimization A/B dopiero, jeśli ruch wystarczy. | brief: pozycja „do sprawdzenia w becie” i monitoring ASO; ADR-014 (bez analityki w v0.1) |
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

## 6. Rolka 3: transkrypcja (@edward.builds, 57 s)

Transkrypcja automatyczna (Whisper small), początek poprawiony według napisów w filmie. Na ekranie: porównania „Design A / Design B” (Ring), „Control / Experiment” (Audible, Headway), ekrany paywalla „Premium” vs „Boss Up, Go Premium”.

**Oryginał (EN)**

- **0:00** If you want to make more money, please simplify your conversion pages as much as possible.
- **0:05** This is a create account screen from Ring. Here's a nice looking one. Here's a very simple one. These designs were A/B tested against one another. This one won by far.
- **0:14** Here's a test from Audible. The only difference here is 30 days versus one month. One month is easier on the mind. This one won.
- **0:21** The main thing changed here, the big text. "Let's start your fun and easy growth." That doesn't mean anything. "Number one most downloaded book summary app." It should be obvious by now this screen won by far.
- **0:35** A lot of brands experiment with cute copy. "Premium" versus "Boss up, go premium." This one won by a lot.
- **0:40** The trick is to make your conversion pages so simple, so straightforward that even the laziest minds can understand what this is, why they will benefit. You would be surprised the amount of brands that don't do those two critical things. If you want to make more money…

**Tłumaczenie (PL)**

- **0:00** Jeśli chcesz zarabiać więcej, maksymalnie uprość strony konwersji.
- **0:05** To ekran zakładania konta z Ring. Jeden ładny, drugi bardzo prosty. Testowano je A/B i ten prosty wygrał z dużą przewagą.
- **0:14** Test z Audible. Jedyna różnica to „30 dni” kontra „miesiąc”. Miesiąc jest łatwiejszy dla głowy. Wygrał.
- **0:21** Tu zmieniono głównie duży tekst. „Zacznij swój fajny i łatwy rozwój” nic nie znaczy. „Aplikacja z podsumowaniami książek nr 1 pod względem pobrań” wygrała zdecydowanie.
- **0:35** Wiele marek eksperymentuje z „uroczymi” tekstami. „Premium” kontra „Boss up, go premium”. Wygrało to pierwsze, i to wyraźnie.
- **0:40** Sztuka polega na tym, żeby strony konwersji były tak proste i jednoznaczne, że nawet najbardziej leniwy umysł zrozumie, co to jest i co na tym zyska. Zdziwiłbyś się, ile marek nie robi tych dwóch rzeczy.
