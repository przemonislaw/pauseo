# PAUSEO — Growth Brief (lekcje z WowCow → strategia wzrostu Pauseo)

> **Wersja:** 1.0 · **Data:** 2026-11-20 · **Autor:** solo-founder + Claude (rola: Head of Growth / strateg)
> **Odbiorca:** agent AI w projekcie pauseo.app, który ma ten dokument challengować i rozpisać z founderem plan promocji oraz zaangażowania.
> **Status dokumentu:** samowystarczalny. Nie zakłada dostępu do rozmów, z których powstał.

---

## Jak czytać ten dokument (instrukcja dla agenta)

1. Każde twierdzenie ma etykietę:
   - **[FAKT: źródło]**: zweryfikowane w danych lub plikach,
   - **[SZACUNEK]**: wyliczenie z założeniem (założenie podane),
   - **[HIPOTEZA]**: do przetestowania,
   - **[REKOMENDACJA · pewność: wysoka/średnia/niska]**,
   - **[DO WERYFIKACJI]**: wiedza zewnętrzna (polityki platform, benchmarki, daty), którą trzeba sprawdzić przed decyzją.
2. Liczby z App Store Connect (ASC) dzielą się na dwie grupy. To krytyczne i w WowCow raz zostało pomylone:
   - **Kompletne** (wszyscy użytkownicy): Impressions, Product Page Views, First-Time Downloads, Total Downloads.
   - **Opt-in only** (~25–30% użytkowników, którzy zgodzili się udostępniać dane): Installations, Sessions, Active Devices, Active Last 30 Days, Deletions, Retention.
   - Tylko drugą grupę wolno skalować mnożnikiem (×3–4). Pobrań się nie mnoży.
3. Twoja rola: **challenge, nie przytakiwanie.** Sekcja 10 zawiera otwarte pytania, które trzeba zamknąć z founderem przed planem wykonawczym.
4. Twarde ograniczenia produktu Pauseo (sekcja 5.2) mają pierwszeństwo przed taktykami growth. Jeśli taktyka je łamie, zaproponuj alternatywę albo jawnie poproś o zmianę ADR.

---

## 0. TL;DR

1. **WowCow po ~14 miesiącach od startu ma 83 urządzenia w backendzie, z czego ~22 otworzyły appkę w ostatnich 30 dniach.** [FAKT: metrics.py 2026-11-20] Marketing nie zbudował dystrybucji. Rośnie tylko App Store Search.
2. **Od ostatniego raportu (2026-06-28): +26 pobrań, +28 urządzeń, ale zaangażowanie spadło.** D30 opens 49% → 34%, open rate 34% → 26%, „ghosty” 9 → 27. Nowi użytkownicy przychodzą, ale nie zostają. [FAKT: ASC CSV + metrics.py]
3. **Jedyny kanał, który zadziałał, to ASO (App Store Search).** Po aktualizacji słów kluczowych v1.6.2 (koniec czerwca) liczba wyświetleń na dzień wzrosła ~1,9×, a pobrania na miesiąc ~3,8× (paź–lis vs. H1). [FAKT: ASC CSV] Instagram **nie** jest przyczyną skoku w październiku, bo automat nie publikował od maja (pkt 5). Najbardziej prawdopodobne jest dojrzewanie rankingu ASO po v1.6.2 [HIPOTEZA · do potwierdzenia w ASC → Sources za październik, pytanie Q1].
4. **Płatne kampanie: ~148 USD wydane, 0 instalacji.** Przyczyny strukturalne: zły cel kampanii (Traffic), budżet poniżej progu uczenia, jedna kreacja, dwustopniowy lejek, start przed product–market fit. [FAKT: memory WowCow]
5. **Automatyzacja Instagrama: dużo inżynierii, zero dystrybucji, a od 8 maja 2026 nie działała wcale.** W kwietniu i maju średnio 9 wyświetleń na post, 0 kliknięć, 0 nowych followersów. Ostatni udany post (Reel) poszedł **7 maja 2026**. Od 8 maja każde uruchomienie Lambdy (3×/dzień z retry) kończy się `AccessDeniedException` na DynamoDB i nikt tego nie zauważył przez ~6,5 miesiąca. [FAKT: CloudWatch Logs `/aws/lambda/wowcow-social-post`, odczyt 2026-11-20] Automatyzowanie kanału bez widowni daje zero, a automatyzacja bez monitoringu po cichu umiera.
6. **Główny błąd WowCow: najpierw produkt i infrastruktura, potem szukanie widowni.** Nie było walidacji popytu przed buildem, listy mailowej, mechaniki poleceń ani spójnego rynku (app EN, reklamy PL, strona EN+PL).
7. **Pauseo jest przed publiczną premierą** (przygotowanie do Internal TestFlight). [FAKT: docs/Current_State.md] To najlepszy moment na marketing, bo można zrobić wszystko, czego WowCow nie zrobił: walidację, listę oczekujących, beta-testerów i gotowe ASO w dniu premiery.
8. **Okno czasowe: 1 stycznia 2027 (postanowienia noworoczne) wypada za ~6 tygodni.** To największy sezonowy szczyt w kategorii rzucania palenia. [DO WERYFIKACJI: Apple Search Ads / Google Trends „rzucić palenie”] W Polsce drugim oknem jest **Wielki Post (od 10.02.2027)**, trzecim **Światowy Dzień bez Tytoniu (31.05)**.
9. **Pauseo ma lepszy „hook” marketingowy niż WowCow:** jasny ból (craving teraz), jasny moment użycia (2 minuty) i różnicę wobec liczników dni i odznak. Treść marketingowa może być demonstracją produktu.
10. **Konflikt do rozstrzygnięcia:** zasada „No analytics” w Pauseo uniemożliwia mierzenie aktywacji i retencji poza ~25–30% danych opt-in w ASC. Bez decyzji (ADR) powtórzy się sytuacja z WowCow („retencja niemierzalna przy tej skali”).
11. **Zakaz płatnych kampanii** do spełnienia bramki: ≥200 instalacji organicznych, mierzalna retencja D7 i kreacja z hook rate ≥25% sprawdzona organicznie.

**5 najważniejszych rekomendacji:**

| # | Rekomendacja | Pewność |
|---|---|---|
| R1 | Zdecyduj o dacie premiery: publiczny App Store **przed 27.12.2026** (okno noworoczne) albo świadomie celuj w Wielki Post. Nie wypuszczaj „po cichu” bez przygotowanego ASO. | wysoka |
| R2 | Zbuduj ASO od pierwszego dnia: tytuł i podtytuł pod frazy PL („rzucić palenie”, „głód nikotynowy”, „e-papieros”), screenshot #1 pokazujący moment cravingu. W WowCow to był jedyny działający kanał. | wysoka |
| R3 | Rozstrzygnij ADR „pomiar zgodny z prywatnością” przed premierą (sekcja 5.3). | wysoka |
| R4 | Uruchom kanał własny przed premierą: strona pauseo.app z zapisem na listę i zewnętrzna beta TestFlight (cel 50–100 osób palących lub wapujących). | wysoka |
| R5 | Treści organiczne jako demo produktu („co zrobić w 2 minuty, gdy chcesz zapalić”), nagrywane ręcznie, z twarzą lub historią foundera. Bez automatyzacji przed udowodnieniem, że format działa. | średnia |

---

## 1. Metadane

| Pole | Wartość |
|---|---|
| Okres danych ASC | 2026-01-01 → 2026-11-18 |
| „Ostatni raport” | 2026-06-28 (metrics.py + analiza Meta Ads + ASO v1.6.2) |
| Okno „od ostatniego raportu” | 2026-06-29 → 2026-11-18 (ASC) / 2026-11-20 (backend) |
| Źródła danych | ASC CSV eksport (9 plików: impressions, product_page_views ×2, first_time_downloads, total_downloads, installations, sessions, active_devices, active_last_30_days); `WowCowTest/lambdas/metrics.py` (DynamoDB DevicesTable, uruchomione 2026-11-20) |
| Źródła wiedzy | `WowCowTest/WowCowMarketing/CLAUDE.md`, `README.md`, `memory/project_m0_progress.md`; `WowCowTest/CLAUDE.md`; pliki memory projektu WowCowTest (meta ads, ASO, metryki, strategia, UGC, push, reddit); `WowCowTest/docs/scalingtheapp.txt`; repo Pauseo `docs/*.md` |
| Brakujące dane | Pauseo: brak danych (przed premierą). WowCow: brak IG insights po maju 2026, brak ASC Sources (rozbicie kanałów) po czerwcu, brak deletions/retencji, brak danych o tym, co founder zrobił w październiku 2026 |

---

## 2. Dane — WowCow

### 2.1 Stan bieżący z backendu (pełna populacja, nie opt-in)

[FAKT: metrics.py, 2026-11-20] vs. [FAKT: memory project_metrics_state.md, 2026-06-28]

| Metryka | 2026-05 | 2026-06-28 | **2026-11-20** | Trend |
|---|---|---|---|---|
| Urządzenia produkcyjne | 42 | 55 | **83** | +28 od raportu |
| Urządzenia z openCount | 22 | 37 | **65** | |
| Otworzyło app w 7 dni | — | 6 / 37 (16%) | **11 / 65 (17%)** | stabilnie |
| Otworzyło app w 30 dni („MAU”) | 13 / 22 (59%) | 18 / 37 (49%) | **22 / 65 (34%)** | ⚠️ spada procentowo |
| Push dostarczony w 30 dni | — | 46 / 55 (84%) | **56 / 83 (67%)** | ⚠️ spada |
| Avg open rate (open/push) | 32% | 34% | **26%** | ⚠️ −8 pp |
| openCount ≥ 5 | 7 | 12 | **22** | rdzeń rośnie |
| Ghosty (>30 dni bez aktywności) | 7 | 9 | **27** | ⚠️ ×3 |
| Urządzenia z 60+ pushami | ~18 | 34 | **46** | |

**Odpowiedź na pytanie „ile osób obecnie korzysta”:**
- **~22 osoby** otworzyły aplikację w ostatnich 30 dniach, **~11** w ostatnich 7 dniach. [FAKT]
- **56 urządzeń** dostaje push (pasywny odbiór treści, np. z ekranu blokady albo widżetu; nie każde to aktywny użytkownik). [FAKT]
- ASC „Active Last 30 Days” (opt-in) = 7 na 2026-11-18 → przy 22 z backendu udział opt-in wynosi ~1/3. [SZACUNEK, zgodne z 25–30%]

**Interpretacja:** absolutna liczba aktywnych lekko rośnie (18 → 22), ale nowe kohorty aktywują się słabo: 15 urządzeń ma 0 pushy, ghostów przybyło 18. **Problem przesunął się z „brak pozyskania” na „brak aktywacji i retencji nowych użytkowników”.** [HIPOTEZA: nowi użytkownicy z App Store Search mają niższą intencję niż wcześni użytkownicy, np. znajomi]

### 2.2 App Store Connect — miesięcznie (2026)

[FAKT: ASC CSV]. Kolumny 1–4 są kompletne, kolumna 5 to opt-in.

| Miesiąc | Impressions | Product Page Views | First-Time Downloads | Total Downloads | Sessions (opt-in) |
|---|---|---|---|---|---|
| Sty | 92 | 8 | 0 | 1 | 2 |
| Lut | 102 | 9 | 3 | 3 | 11 |
| Mar | 92 | 9 | 2 | 4 | 16 |
| Kwi | 107 | 19 | 3 | 7 | 85 |
| Maj | 78 | 14 | 5 | 5 | 39 |
| Cze | 88 | 19 | 7 | 7 | 48 |
| Lip | 45 | 1 | 0 | 0 | 13 |
| Sie | 104 | 11 | 2 | 2 | 8 |
| Wrz | 128 | 6 | 4 | 4 | 38 |
| Paź | **175** | 16 | **12** | **12** | 33 |
| Lis (1–18) | 110 | **24** | 8 | 8 | 9 |
| **Suma** | **1121** | **136** | **46** | **53** | **302** |

Installations (opt-in) w całym okresie: 16. Active Last 30 Days (opt-in): szczyt 10 (17.04–07.05), dołek 1 (luty–marzec, 18–20.08), obecnie 7.

### 2.3 Od ostatniego raportu: 2026-06-29 → 2026-11-18

| Metryka | H1 (01.01–28.06, 179 dni) | Od raportu (29.06–18.11, 143 dni) | Zmiana |
|---|---|---|---|
| Impressions | 556 (3,1/dzień) | 565 (4,0/dzień) | +28% / dzień |
| — w tym paź–lis | — | 285 w 49 dni (**5,8/dzień**) | **+87% vs H1** |
| Product Page Views | 78 | 58 | |
| First-Time Downloads | 20 (3,3/mies.) | **26** (5,5/mies.) | |
| — w tym paź–lis | — | 20 w 49 dni (**~12/mies.**) | **~3,7× vs H1** |
| Konwersja impression → download | 3,6% | 4,6% | |
| Konwersja page view → download | 26% | 45% | |
| Installations opt-in | 10 | 6 | 23% pobrań, zgodne z opt-in |

**Wnioski:**
- **Listing konwertuje dobrze, problemem jest odkrywalność.** ~4–6 wyświetleń dziennie w App Store to bardzo mało. Kolejne zmiany tekstów niewiele dadzą, potrzeba więcej wyświetleń: ranking na lepsze frazy i ruch zewnętrzny. [REKOMENDACJA · pewność: wysoka]
- **Lipiec był pusty** (45 wyświetleń, 1 page view, 0 pobrań). [HIPOTEZA: okres review/indeksacji v1.6.2 albo przejściowy spadek rankingu po zmianie słów kluczowych]
- **Październik to skok** (12 pobrań, 175 wyświetleń, w tym 20 wyświetleń 24.10). Founder nie zna przyczyny i podejrzewał automatyczne rolki na IG. **Logi to wykluczają:** Lambda nie opublikowała nic od 2026-05-07. Pozostałe hipotezy:
  - (a) ranking ASO po v1.6.2 dojrzał z opóźnieniem (wzrost impressions od sierpnia, równy z page views) [HIPOTEZA · najbardziej prawdopodobna],
  - (b) wzmianka zewnętrzna lub polecenie (wtedy w ASC widać Web Referrer / App Referrer),
  - (c) sezonowość lub wyróżnienie w Browse.

  **Jak rozstrzygnąć (5 min):** ASC → Analytics → Acquisition → Sources, okres 01.10–31.10 vs. 01.07–30.09. Jeśli dominuje App Store Search, to potwierdzenie (a).

### 2.4 Korekty błędów w danych historycznych

- **Mnożenie pobrań ×3–5 było błędem.** Memory z maja 2026 traktowało Total Downloads jako opt-in i szacowało „realne” 25–40 pobrań. CSV pokazuje 7 pobrań w okresie 01.04–11.05, czyli tyle, ile wynosiła liczba „opt-in”. Pobrania w ASC są kompletne. [FAKT: CSV vs memory]
- **„Spike 26 czerwca: 15 first-time downloads” to najpewniej błędny odczyt.** CSV pokazuje 1 pobranie 26.06 i 7 w całym czerwcu. Prawdopodobnie odczytano sumę z okresu (widok „ostatnie 30 dni”) jako wartość dzienną. [FAKT: CSV; HIPOTEZA co do przyczyny]
- **Lekcja dla Pauseo:** każdy raport musi podawać okres, typ metryki (kompletna / opt-in) i eksport źródłowy. Zrzut ekranu z dashboardu nie wystarczy.

---

## 3. Inwentaryzacja działań marketingowych WowCow

Okres: ~wrzesień 2025 (premiera iOS) → listopad 2026. Kontekst produktu: jedna ciekawostka dziennie przez push, streak, quiz tygodniowy, widżet, karta do udostępniania. Pivot na „Body & Mind” w kwietniu 2026.

| # | Działanie | Kanał | Kiedy | Koszt (pieniądze / czas) | Wynik | Status |
|---|---|---|---|---|---|---|
| 1 | Automatyczne posty IG (Lambda + Pillow + EventBridge), 5 ręcznych postów M0, potem codziennie, później co 3 dni | Instagram | 03.2026 → **07.05.2026** | 0 USD / **bardzo dużo** (Lambda 60 MB, deploy przez S3, odnawianie tokenów co 60 dni) | 194 wyświetlenia / 21 postów = **9 na post, 0 kliknięć, 0 followersów** (kwi–maj) | ⚠️ **zepsute od 08.05.2026**: każde uruchomienie = `AccessDeniedException` (DynamoDB GetItem), 0 postów przez ~6,5 mies., niezauważone [FAKT: CloudWatch] |
| 2 | Reels co poniedziałek (MP4 generowane automatycznie, word-by-word reveal) | Instagram | 07.05.2026 (1 Reel) | 0 USD / dużo | opublikowany **jeden** Reel (07.05), potem awaria jak wyżej | martwe od 08.05.2026 |
| 3 | Integracja TikTok Content Posting API | TikTok | 04.2026 | 0 USD / dużo (2 review, demo video, domena) | **2× odrzucone**, rezygnacja | porzucone |
| 4 | Landing wowcow.app (Next.js, Vercel, SEO, JSON-LD, OG, sitemap) | Web/SEO | 03–04.2026 | 0 USD / średnio | Web Referrer 4 z 12 pobrań (maj–cze) | aktywne |
| 5 | Wersja PL strony + detekcja języka | Web | 05.2026 | 0 / średnio | dopasowanie do reklamy PL; brak zmierzonego efektu | aktywne |
| 6 | Meta Pixel + Consent Mode + UTM / ASC Campaign Link | Pomiar | 05.2026 | 0 / średnio | pomiar Traffic działał; dla AAC bezużyteczny | aktywne |
| 7 | Outcome framing copy („One fact about your body. Every morning.”) | Copy | 04.2026 | 0 / mało | brak izolowanego pomiaru | wdrożone (bez zmiany bio IG) |
| 8 | Meta Ads v1: Traffic → wowcow.app, 2 USD/dzień, PL | Paid | 08–16.05.2026 | **~14 USD** | 144 kliknięcia, CTR 5,38%, hook 35%, **0 instalacji**; Advantage+ przesunął do 65+ | zatrzymane |
| 9 | Meta Ads v2: App Install (AAC), plan 10 USD/dzień | Paid | 16.05–28.06.2026 | **~134 USD** | realnie 3,11 USD/dzień, 6731 wyświetleń, hook 10%, avg watch 1 s, **0 instalacji** | zatrzymane, decyzja trwała |
| 10 | ASO v1.6.2: słowa kluczowe Body&Mind, nowy opis EN+PL, podtytuł „Daily Body & Mind Science” | App Store | złożone 28.06.2026 | 0 / mało | **jedyny kanał ze wzrostem** (sekcja 2.3) | aktywne |
| 11 | Teaser push zamiast pełnego faktu (information gap) | Retencja | 05.2026 | 0 / mało | open rate 32–34% (maj–cze) → 26% (lis) | aktywne |
| 12 | Review prompt po 5 otwarciach | Retencja / ASO | — | 0 | brak danych o liczbie ocen | aktywne |
| 13 | Karta do udostępniania 1080×1080 (mechanika „Wordle”) | Viral | v1.5 | 0 / średnio | brak pomiaru udostępnień | aktywne, niemierzone |
| 14 | Reddit seeding (M8) | Community | planowane | — | nie wystartowało; founder uznał nowe konto za spam | porzucone |
| 15 | Product Hunt (M9) | Launch | czekało na Pro | — | nie wystartowało | odłożone |
| 16 | Dynamiczne strony faktów + „Challenge znajomego” (M7 / Zad. 14) | Viral loop | backlog | — | niezbudowane | odłożone |
| 17 | Lista mailowa przed Pro, UGC Reel (HackUGC), audyt ASO u konkurencji | Owned / Content | TODO od 05.2026 | — | niezrobione | odłożone |
| 18 | WowCow Pro (paywall) | Monetyzacja | bramka 200+ instalacji | — | niezbudowane | odłożone |

**Bilans:** ~148 USD i bardzo dużo godzin inżynierii. Dało to ~46 pobrań w 2026, z czego praktycznie wszystkie są organiczne (App Store Search + web). Płatne kampanie: 0 instalacji. [FAKT]

---

## 4. Retrospektywa: co poszło nie tak, co działało, co przenosimy

### 4.1 Błędy (przyczyna → mechanizm → zabezpieczenie w Pauseo)

| # | Błąd | Przyczyna źródłowa | Zabezpieczenie dla Pauseo |
|---|---|---|---|
| B1 | **Produkt przed widownią.** Zbudowano app, backend i automatyzacje, zanim ktokolwiek czekał na produkt. | Founder-inżynier robi to, co umie najlepiej. Kodowanie dawało poczucie postępu. | **Zasada „audience before automation”:** zero automatyzacji kanału, dopóki ręcznie nie zdobędzie on N reakcji (np. 1000 wyświetleń na post albo 50 zapisów). Lista oczekujących i beta przed premierą. |
| B2 | **Słaba, zmieniana propozycja wartości.** „Fun facts” → pivot „Body & Mind” po ~7 miesiącach. | Brak walidacji problemu. „Ciekawostka dnia” to nice-to-have bez bólu. | Pauseo ma realny ból. Trzeba go jednak **przetestować w języku użytkownika** (jak ludzie mówią o cravingu, slipie, e-papierosie) przed napisaniem ASO i treści. |
| B3 | **ASO niezsynchronizowane z pivotem przez ~3 miesiące** (kwi → koniec cze). | ASO traktowane jako jednorazowe zadanie, nie jako produkt. | Listing (tytuł, podtytuł, słowa kluczowe, screenshot #1) to **artefakt wersjonowany razem z produktem**. Każda zmiana pozycjonowania od razu aktualizuje ASC. |
| B4 | **Płatne kampanie przed PMF i poniżej progu uczenia.** | Presja „trzeba coś zrobić z wzrostem” i optymizm co do małego budżetu. | Twarda bramka paid (sekcja 8). Budżet <300 USD/mies. przy App Install nie wychodzi z fazy uczenia. |
| B5 | **Zły cel kampanii i dwustopniowy lejek** (Traffic → strona → App Store). | Brak checklisty przed kampanią. | Checklista Meta dla iOS (sekcja 6.4) przed jakimkolwiek wydatkiem. |
| B6 | **Automatyzacja kanału bez widowni** (IG: 9 wyświetleń na post). | Automatyzacja daje regularność, ale nie zasięg. Algorytm IG nagradza retencję wideo i interakcje, a nie regularność statycznych grafik. | Kanał najpierw ręcznie, formaty natywne (krótkie wideo z twarzą i hookiem w 1 s), automatyzacja dopiero w fazie skalowania. |
| B7 | **Rozproszenie: wiele kanałów naraz, mało dokończonych** (IG, TikTok, Reddit, PH, email, UGC, strona PL). | Brak jednej metryki celu na kwartał i brak limitu WIP. | **Maks. 1 kanał akwizycji + 1 eksperyment na raz.** Eksperyment musi mieć metrykę, termin i kryterium porzucenia. |
| B8 | **Nieokreślony rynek:** app EN-first, reklamy PL, strona EN+PL, link App Store /pl. | Decyzja nie została podjęta jawnie. | Pauseo: **PL jako rynek startowy** (primary language w ASC = polski, 15 kart wsparcia po polsku). EN dopiero po walidacji PL. Spójnie we wszystkich kanałach. |
| B9 | **Metryka decyzyjna niemierzalna przy tej skali** (D30 retention w ASC = „Not Enough Data”). Framework decyzyjny oparty na danych, których nie było. | Brak planu pomiaru przed premierą. | ADR pomiaru (sekcja 5.3) przed premierą. Metryki decyzyjne muszą być mierzalne przy 50–200 użytkownikach. |
| B10 | **Błędy w odczycie danych** (mnożenie pobrań, „spike” 15 pobrań). | Odczyty ze zrzutów dashboardu, bez rozróżnienia opt-in i bez eksportu. | Raport = eksport CSV + okres + typ metryki. Szablon raportu w sekcji 9.3. |
| B11 | **Brak kanału własnego** (email, lista oczekujących). Każdy launch od zera. | Odkładane jako „TODO”. | Zapis na listę na pauseo.app **przed** premierą. |
| B12 | **Brak pętli wzrostu.** Udostępnianie istnieje, ale bez pomiaru i bez zachęty po stronie odbiorcy. | Pętla poleceń w backlogu od miesięcy. | Pętla w Pauseo musi być zgodna z tematem wstydu i prywatności (sekcja 6.3). Projektować ją od v1.x, nie „kiedyś”. |
| B14 | **Cicha awaria automatu przez ~6,5 miesiąca.** Lambda IG failuje od 08.05.2026, a w czerwcu planowano „IG Content Strategy” i zakładano, że rolki lecą. | Alarm CloudWatch istniał (mail), ale nikt nie reagował. Brak cotygodniowego sprawdzenia „czy kanał w ogóle publikuje”. Zmiana kodu (lock / kadencja w DynamoDB) bez dopisania uprawnień IAM i bez testu po deployu. | Każdy automat ma **heartbeat widoczny w raporcie tygodniowym** (np. „ostatni post: data”). Test end-to-end po każdym deployu. Lepiej mniej automatów: Pauseo i tak jest bez backendu. |
| B13 | **Retencja nowych kohort spada** (MAU 49% → 34%, ghosty ×3). | Nowi użytkownicy z wyszukiwarki mają inny profil. Onboarding nie prowadzi do szybkiego „aha”. | Zdefiniuj **moment aktywacji** w Pauseo (sekcja 7.1) i mierz go od pierwszego dnia. |

### 4.2 Co działało (przenosimy)

| Co | Dowód | Jak przenieść do Pauseo |
|---|---|---|
| **ASO / App Store Search** jako główny kanał przy zerowym budżecie | 7/12 pobrań (maj–cze); wzrost impressions i pobrań po v1.6.2 | ASO jako priorytet nr 1 od premiery. Frazy PL o wysokiej intencji. |
| **Decyzje z kryterium stop** (zatrzymanie Meta Ads, „nie wznawiać do 200+ instalacji”) | uratowało dalsze wydatki | Każdy eksperyment ma kill criteria z góry. |
| **Teaser push** (information gap) | open rate 32–34% przy rozsądnej skali | W Pauseo push nie służy treści, tylko **interwencji w ryzykownym momencie** (sekcja 7.3). |
| **Źródła przy treściach** (NIH, Harvard) jako wiarygodność | spójne z personą sceptyczną wobec „fun facts” | Karty wsparcia Pauseo już mają `sourceLabel/sourceURL` (WHO/NHS/NCI). Wykorzystać w marketingu: „każde twierdzenie ma źródło”. |
| **Pozycjonowanie privacy/no-BS** (bez konta, bez reklam) | brak twardego dowodu konwersji | W Pauseo to **dużo silniejszy argument** (dane o nałogu są wrażliwe). „Twoje dane nie wychodzą z telefonu” jako główny komunikat. |
| **Checklisty i memory** (np. feedback_meta_ads_ios.md) | uniknięcie powtórki błędów | Ten dokument jest kontynuacją tej praktyki. |

### 4.3 Czego się nie dowiedzieliśmy (bo nie mierzyliśmy)

- Czy Reels IG przyniosły jakiekolwiek pobrania. Po maju pytanie jest bezprzedmiotowe, bo nic nie było publikowane. Wcześniej brak sygnału (0 kliknięć).
- Ile udostępnień wygenerowała karta 1080×1080 i czy któreś dało instalację.
- Jaki był rzeczywisty D7/D30 kohort (za mała skala opt-in).
- Co spowodowało skok w październiku 2026 (IG wykluczony; do sprawdzenia ASC Sources).
- Dlaczego nowe urządzenia nie aktywują się (brak lejka onboardingu).

---

## 5. Stan wyjściowy Pauseo

### 5.1 Produkt (stan na 2026-11-16)

[FAKT: repo Pauseo, docs/Current_State.md, docs/Product_MVP.md, memory projektu]

- **Co to jest:** iOS (SwiftUI, iOS 17+) wsparcie przy rzucaniu lub ograniczaniu palenia, wapowania i nikotyny. Nisza: **„craving intelligence + micro-habit replacement”**, czyli pomoc w samym momencie głodu nikotynowego. Nie jest to licznik dni ani aplikacja medyczna.
- **Pętla produktowa:** craving → jedna mikro-akcja → (opcjonalnie) 2-minutowa prowadzona sekwencja z rotującymi kartami wsparcia → pytanie o wynik („Nie zapaliłem/am” / „Odłożyłem/am decyzję” / „Zapaliłem/am”) → neutralne zakończenie. Osobna ścieżka „Miałem slip”: powrót bez zawstydzania.
- **Home = ekran awaryjny**, nie dashboard: „Mam craving teraz”, „Miałem slip”, „Prywatność i dane”.
- **Lokalizacja:** pełne PL + EN (String Catalog). Karty wsparcia: 15, **przetłumaczone na EN w String Catalogu** [FAKT: kod, 2026-11-20; wcześniejsza wersja briefu błędnie podawała „tylko po polsku”]. QA PL/EN na urządzeniu przeszło 14.11.2026.
- **Onboarding:** 1 ekran (od 2026-11-20), bez pytań konfiguracyjnych.
- **Dane:** tylko lokalnie (UserDefaults), usuwalne przez użytkownika. Bez backendu i bez konta.
- **Odroczone:** Progress, Daily Check-in, trigger intelligence UI.
- **Wydanie:** przygotowanie do pierwszego **Internal TestFlight**. App ID `app.pauseo`, rekord w ASC („Pauseo”, język główny polski). Publiczny listing (opis, słowa kluczowe, screenshoty) **jeszcze nieprzygotowany**.
- **Marketing:** zero. Brak strony, social media, listy i bety zewnętrznej. [FAKT wg foundera] **Domena pauseo.app jest kupiona** [FAKT wg foundera, 2026-11-20]. Founder potwierdził, że **publiczna premiera przed 27.12.2026 jest realna**.

### 5.2 Twarde ograniczenia produktu (kanon, nie łamać bez ADR)

- No backend, no auth, **no analytics**, no AI coach, no HealthKit.
- **No medical advice, no NRT / dawkowania leków.**
- Relapse recovery bez wstydu. Niskie obciążenie poznawcze.
- Każdy feature musi odpowiadać na pytanie: „Czy to pomaga przetrwać następny craving albo zrozumieć triggery mniejszym wysiłkiem?”

**Implikacje dla marketingu:**
- Copy nie może obiecywać efektów medycznych („rzucisz w 7 dni”, „skuteczność X%”) bez badań. Dozwolone są obietnice doświadczenia: „2 minuty, które pomagają przeczekać głód”.
- Mechaniki zaangażowania oparte na wstydzie (utrata streaka, „zawiodłeś”) są **zakazane**. Kłóci się to z klasyczną gamifikacją konkurencji i jest to zarazem **wyróżnik**.

### 5.3 Decyzja do podjęcia przed premierą: pomiar vs. „No analytics”

**Problem:** bez pomiaru nie da się ocenić żadnego działania marketingowego ani retencji. WowCow pokazał, że ASC opt-in przy <200 instalacjach daje „Not Enough Data”.

| Opcja | Co daje | Koszt prywatności / kanonu | Rekomendacja |
|---|---|---|---|
| A. Tylko ASC (status quo) | pobrania, konwersja listingu, źródła; usage tylko ~25–30% | zero; etykieta „Data Not Collected” | minimum, niewystarczające |
| B. Analityka privacy-first, anonimowa, zagregowana (np. TelemetryDeck: bez PII, EU) [DO WERYFIKACJI: aktualna etykieta prywatności i zgodność z RODO] | aktywacja, D1/D7/D30, użycie cravingu | zmiana kanonu (ADR); etykieta prywatności się zmienia | **rekomendowana do rozważenia**, tylko eventy produktowe, bez treści |
| C. Dobrowolny, jawny „wyślij anonimowe podsumowanie” w Privacy screen | zgoda wprost, spójne z wartościami | mała próbka | dobre uzupełnienie A |
| D. Jakościowo: wywiady z betą, TestFlight feedback, krótka ankieta w appce (lokalna, opcjonalna) | „dlaczego”, język użytkownika do ASO | zero | **obowiązkowe w fazie bety** niezależnie od A/B/C |

[REKOMENDACJA · pewność: wysoka] Podjąć decyzję jawnie (ADR). Domyślnie: **A + D natychmiast**, B lub C rozstrzygnięte przed publiczną premierą. Jeśli founder utrzyma „no analytics”, to musi zaakceptować, że metryki decyzyjne będą oparte na ASC i badaniach jakościowych, a progi z sekcji 8 trzeba przeliczyć na metryki ASC.

### 5.4 Konkurencja (do pogłębienia przez agenta)

[DO WERYFIKACJI: aktualne aplikacje, oceny, ceny, pozycje w App Store PL dla fraz „rzucić palenie”, „rzucanie palenia”, „e-papieros”, „nikotyna”]

| Typ | Przykłady | Ich model | Gdzie Pauseo wygrywa | Gdzie przegrywa |
|---|---|---|---|---|
| Liczniki + odznaki + oszczędności | Smoke Free, QuitNow!, Kwit, Flamy, EasyQuit | dni bez palenia, zaoszczędzone pieniądze, oś regeneracji zdrowia, odznaki, często subskrypcja | pomoc **w momencie** cravingu, brak wstydu po slipie, prywatność | brak motywatorów „postępu”, mniej funkcji, zero recenzji na starcie |
| Programy / metody | QuitSure, Allen Carr (app) | kurs, zmiana myślenia | niski próg wejścia, 2 minuty zamiast programu | brak „metody” jako obietnicy |
| Medyczne / CBT | Quit Genius i podobne | terapia, NRT, B2B | brak barier, darmowy, bez porad medycznych | brak autorytetu klinicznego |
| Publiczne wsparcie PL | Telefoniczna Poradnia Pomocy Palącym (NFZ) [DO WERYFIKACJI: aktualny numer i zakres] | rozmowa z konsultantem | dostępność 24/7, anonimowość | — to partner, nie wróg (sekcja 6.2) |

**Zadanie dla agenta:** zrobić audyt top 10 aplikacji w App Store PL (tytuły, podtytuły, screenshot #1, oceny, **najczęstsze skargi w recenzjach 1–3★**). Skargi konkurencji to gotowe hasła pozycjonujące, np. „aplikacja mnie zawstydza po wpadce”, „liczy dni, ale nie pomaga, gdy chce mi się palić”.

### 5.5 Persona i Jobs-to-be-done (hipotezy do walidacji w becie)

[HIPOTEZA]
- **Persona główna:** dorosły 25–45 lat w Polsce, pali lub wapuje, próbował rzucić ≥1 raz, wraca po „wpadkach”, ma dość aplikacji, które liczą dni i każą zaczynać od zera.
- **Persona 2:** osoba wapująca (e-papieros, saszetki nikotynowe), która chce ograniczyć, a nie od razu rzucić (`GoalMode` w modelu sugeruje obsługę obu celów).
- **JTBD:** „Kiedy nachodzi mnie ochota na papierosa (po kawie, w stresie, po jedzeniu), chcę mieć coś, co pomoże mi przeczekać te kilka minut, bez wykładu i bez poczucia winy, gdy się nie uda.”
- **Do sprawdzenia w becie:** słownik użytkownika („craving” czy „głód”, „ssanie”, „chęć zapalenia”?). Od tego zależy ASO i copy. Obecny CTA „Mam craving teraz” może nie być językiem polskiego masowego odbiorcy. [HIPOTEZA · test: 5–10 wywiadów]

### 5.6 Ryzyka kategorii (zdrowie / tytoń)

[DO WERYFIKACJI w aktualnych politykach przed każdą decyzją]

| Obszar | Ryzyko | Co zrobić |
|---|---|---|
| App Store Review (zdrowie) | twierdzenia medyczne bez podstaw mogą skutkować odrzuceniem; dane zdrowotne mają szczególne wymogi | copy „wsparcie”, nie „leczenie”; źródła przy faktach; brak porad o lekach (zgodne z kanonem) |
| Meta Ads (tytoń, zdrowie) | reklamy rzucania palenia są generalnie dozwolone, ale kreacje z wyrobami tytoniowymi mogą być odrzucane; targetowanie po zainteresowaniach zdrowotnych ograniczone od 2022 | kreacje bez papierosa w kadrze; targetowanie szerokie + kreacja jako filtr; testować tylko po bramce |
| TikTok | treści o paleniu i wapowaniu mogą mieć ograniczony zasięg | testować organicznie z neutralnym językiem |
| Apple Search Ads | najmniej ryzykowny paid kanał dla tej kategorii (intencja w wyszukiwaniu) | pierwszy kandydat na paid po bramce |
| RODO / dane wrażliwe | informacje o nałogu = dane o zdrowiu | utrzymać local-first; każda analityka bez PII i treści; polityka prywatności po polsku, prosta |
| Etyka i ton | marketing nie może zawstydzać ani straszyć (fear appeals) | spójne z UX_Principles; zakaz „before/after” płuc i podobnych obrazów |
| Wiarygodność | brak autorytetu medycznego | oprzeć się na źródłach (WHO, NHS, NCI) i ewentualnie konsultacji z ekspertem (psycholog uzależnień) jako advisor |

---

## 6. Kanały: co robić, w jakiej kolejności, czego unikać

### 6.1 Priorytety kanałów dla Pauseo (zero budżetu)

| Priorytet | Kanał | Dlaczego | Pierwszy krok | Metryka | Kill criteria |
|---|---|---|---|---|---|
| **P0** | **ASO (PL)** | jedyny działający kanał w WowCow; w tej kategorii wyszukiwanie ma wysoką intencję | research fraz PL (Apple Search Ads keyword planner / narzędzia ASO free tier), tytuł 30 znaków + podtytuł 30 + słowa kluczowe 100, 6 screenshotów (pierwszy = moment cravingu) | impressions/dzień, konwersja page view → download | po 6 tyg. impressions <10/dzień → zmiana fraz |
| **P0** | **Kanał własny: pauseo.app + lista oczekujących** | WowCow nie miał listy; każdy launch od zera | jedna strona: problem → 2-minutowe demo (GIF/wideo) → zapis → link TestFlight | zapisy/tydzień, konwersja odwiedzin na zapis | — (infrastruktura, nie eksperyment) |
| **P0** | **Beta zewnętrzna TestFlight** | walidacja aktywacji, język użytkownika, pierwsze recenzje w dniu premiery | rekrutacja 50–100 osób (znajomi, grupy, lista) | % testerów, którzy użyli flow cravingu ≥1 raz w 7 dni; wywiady | <20% aktywacji → problem produktowy, nie marketingowy |
| **P1** | **Krótkie wideo (IG Reels / TikTok), ręcznie, natywnie** | kategoria ma silny ładunek emocjonalny i historie | 5 wideo w 2 tygodnie: „co zrobić w 2 minuty, gdy chcesz zapalić” / historia foundera / „dlaczego licznik dni nie działa po wpadce” | hook rate, avg watch, zapisy, komentarze „jak się nazywa app?” | po 10 wideo <500 wyświetleń średnio → zmiana formatu |
| **P1** | **Społeczności** (grupy FB „rzucam palenie”, fora, r/stopsmoking dla EN) | ludzie w trakcie rzucania szukają wsparcia | **najpierw obecność i pomoc, bez linka** (zgodnie z feedbackiem foundera dot. Reddita) | jakość rozmów, zaproszenia do bety | brak zgody adminów → nie publikować |
| **P2** | **PR / media PL** | historia „solo-dev zrobił darmową, prywatną apkę do rzucania palenia, bez wstydu” plus sezon noworoczny | lista 20 dziennikarzy zdrowie/tech, pitch na koniec grudnia | publikacje, skoki impressions | — |
| **P2** | **Partnerstwa** (poradnie, psychologowie uzależnień, pracodawcy) | autorytet i dystrybucja; pomysł B2B z WowCow | 3 rozmowy z ekspertami jako advisor / recenzja treści kart | rekomendacje, wejścia z referrera | — |
| **P3** | Product Hunt / Hacker News (EN) | mała zgodność z rynkiem PL | dopiero po wersji EN | — | — |
| **⛔** | Paid (Meta/TikTok) | patrz bramka, sekcja 8 | — | — | — |
| **⛔** | Automatyzacja postów | błąd B6 | dopiero gdy format udowodniony ręcznie | — | — |

### 6.2 Kalendarz sezonowy (kluczowe okna)

[DO WERYFIKACJI: daty i skala wolumenu wyszukiwań]

| Data | Okno | Co przygotować |
|---|---|---|
| **1–15.01.2027** | Postanowienia noworoczne, największy szczyt kategorii | app publicznie w App Store najpóźniej ~27.12; listing gotowy; 5–10 wideo na zapas; pitch PR wysłany przed świętami |
| **10.02.2027** (Popielec) | Wielki Post. W Polsce popularne postanowienie „rzucam palenie na Post” | kampania treści „40 dni”, ewentualnie App Store In-App Event [DO WERYFIKACJI: wymogi In-App Events] |
| **31.05.2027** | Światowy Dzień bez Tytoniu (WHO) | PR, partnerstwa, treści |
| X 2027 | Stoptober (UK), przy wersji EN | — |
| ~3. czwartek listopada | Światowy Dzień Rzucania Palenia / Great American Smokeout | — (19.11.2026 już minął) |

### 6.3 Pętle wzrostu zgodne z kanonem (bez wstydu, prywatnie)

[HIPOTEZA, do zaprojektowania z agentem]
- **„Wyślij komuś, kto rzuca”:** udostępnienie karty wsparcia (fakt + źródło + link). Nie ujawnia, że użytkownik sam pali.
- **„Quit buddy”:** zaproszenie jednej osoby wspierającej (bez konta: link lub kod). Wymaga przemyślenia zgodności z „no backend”, możliwe w v2.
- **Recenzje jako pętla ASO:** prośba o ocenę **po pozytywnym wyniku** cravingu („Nie zapaliłem/am”), nigdy po slipie. Max 1 raz, zgodnie z `SKStoreReviewController`. [REKOMENDACJA · pewność: wysoka]

### 6.4 Checklista przed jakimkolwiek wydatkiem na paid (z WowCow)

1. Bramka z sekcji 8 spełniona.
2. Cel kampanii: **App Promotion / App Install**, nigdy Traffic.
3. Budżet ≥10 USD/dzień przez ≥7 dni (≥300 USD/mies.), inaczej algorytm nie wyjdzie z fazy uczenia.
4. Bundle ID + App Store ID zarejestrowane w Meta Developers przed kampanią.
5. Wiek jako twardy limit. Advantage+ placements tylko przy App Install.
6. ≥3 kreacje, każda z hookiem w pierwszej sekundzie i CTA przed 3. sekundą. Najlepiej kreacje, które już zadziałały organicznie.
7. Pomiar: ASC → Sources (nie Campaign Links), SKAdNetwork.
8. Kill criteria zapisane przed startem (np. CPI > X zł po 7 dniach → stop).
9. **Pierwszy kandydat paid dla Pauseo: Apple Search Ads** (intencja wyszukiwania, najmniejsze ryzyko polityk). [REKOMENDACJA · pewność: średnia]

---

## 7. Zaangażowanie i retencja (specyfika rzucania palenia)

### 7.1 Definicje metryk (proponowane)

| Metryka | Definicja | Dlaczego |
|---|---|---|
| **Aktywacja** | ukończony 1. flow „Mam craving teraz” w ciągu 72 h od instalacji | moment „aha”; bez tego appka to ikona |
| **Głęboka aktywacja** | ukończona 1. sekwencja 2-minutowa | dowód wartości rdzenia |
| **North Star (propozycja)** | liczba „przetrwanych cravingów” (wynik „Nie zapaliłem/am” lub „Odłożyłem/am”) na aktywnego użytkownika na tydzień | mierzy pomoc, nie czas w appce |
| **Retencja** | D1 / D7 / D30 (ASC opt-in lub analityka wg ADR) | |
| **Recovery rate** | % użytkowników, którzy po zalogowaniu slipu wracają do appki w 7 dni | kluczowe; w tej kategorii churn po wpadce jest naturalny |

Uwaga: w tej kategorii „sukces” może oznaczać **mniejsze użycie** (mniej cravingów w czasie). Nie optymalizuj ślepo pod DAU. [REKOMENDACJA · pewność: wysoka]

### 7.2 Dźwignie zaangażowania pasujące do Pauseo

| Dźwignia | Opis | Zgodność z kanonem | Priorytet |
|---|---|---|---|
| Szybki dostęp w momencie cravingu | widżet na ekranie blokady / Control Center / Action Button / Shortcut „Mam craving” | ✅ wprost wspiera pętlę | wysoki |
| Live Activity w czasie 2 minut | odliczanie na Dynamic Island, gdy użytkownik wyjdzie z appki | ✅ | średni |
| Przypomnienia w ryzykownych porach | użytkownik sam ustawia (po kawie, po pracy); lokalne powiadomienia, bez backendu | ✅ jeśli opt-in i neutralny ton | wysoki |
| Licznik „przetrwanych cravingów” zamiast streaka dni | nie resetuje się po slipie | ✅ (odpowiedź na abstinence violation effect) [DO WERYFIKACJI: literatura] | wysoki, jako wyróżnik |
| Slip recovery jako moment retencji | po slipie: wsparcie + „co pomogło ostatnio” | ✅ rdzeń | już jest |
| Lokalne insighty o triggerach | „najczęściej po kawie” | ✅ (odroczone w kanonie) | po walidacji |
| Oszczędzone pieniądze / oś zdrowia | standard konkurencji | ⚠️ ryzyko „dashboardu” i wstydu po resecie | niski, ewentualnie bez resetu |
| Streaki, odznaki za dni bez palenia | standard gamifikacji | ⛔ sprzeczne z „no shame” | nie |

### 7.3 Lekcje z pushy WowCow, przeniesione

- Push WowCow = hook do treści. **Push Pauseo = interwencja w ryzykownym momencie albo wsparcie po slipie.** Nigdy jako „przypominajka do otwarcia appki”.
- Spadek open rate WowCow (34% → 26%) przy rosnącej bazie pokazuje, że przewidywalne pushe się starzeją. Częstotliwość w Pauseo ustala użytkownik, domyślnie nisko.

---

## 8. Plan 0–30 / 30–60 / 60–90 dni (propozycja do challenge)

> Założenia: budżet ~0 zł, czas foundera [DO USTALENIA: X h/tydz.], rynek PL. Daty liczone od 2026-11-23.

### Faza 0 (0–30 dni, do ~23.12): „Gotowi na Nowy Rok”

- [x] Decyzja Q2: **publiczna premiera przed 27.12.2026** (potwierdzone przez foundera). Plan wsteczny: listing i screenshoty gotowe ~10.12, wysyłka do review ~15.12 (zapas na odrzucenie i okres świąteczny w App Review [DO WERYFIKACJI: przerwa świąteczna Apple]), premiera ~20–23.12.
- [ ] ADR pomiaru (sekcja 5.3).
- [ ] Internal TestFlight → External TestFlight (review bety [DO WERYFIKACJI: czas]).
- [ ] pauseo.app (domena kupiona): landing z listą oczekujących + polityka prywatności PL. Uwaga: polityka prywatności i URL wsparcia są wymagane w listingu App Store, więc landing jest na ścieżce krytycznej premiery.
- [ ] Rekrutacja 50–100 beta-testerów; 5–10 wywiadów (słownik użytkownika, moment aktywacji).
- [ ] Audyt ASO konkurencji PL + listing (tytuł, podtytuł, słowa kluczowe, 6 screenshotów, opis PL).
- [ ] 5 ręcznych krótkich wideo (test formatów); profil IG/TikTok Pauseo.
- [ ] Pitch PR „na Nowy Rok” do 10–20 mediów.

### Faza 1 (30–60 dni, ~01.01–31.01): premiera i okno noworoczne

- [ ] Premiera publiczna; mail do listy; prośba do beta-testerów o recenzje.
- [ ] 2–3 wideo/tydzień w formacie, który wygrał test.
- [ ] Monitoring: impressions/dzień, konwersja listingu, aktywacja.
- [ ] Iteracja ASO po 2–3 tygodniach (Product Page Optimization A/B, jeśli ruch wystarczy [DO WERYFIKACJI: progi]).

### Faza 2 (60–90 dni, ~luty): Wielki Post + retencja

- [ ] Kampania treści „40 dni bez / mniej”.
- [ ] Pierwsza dźwignia zaangażowania (widżet / przypomnienia w ryzykownych porach), wybrana na podstawie danych z bety.
- [ ] Partnerstwo z 1 ekspertem (recenzja kart wsparcia → wiarygodność).

### Bramka paid (wszystkie warunki naraz)

- ≥200 instalacji organicznych,
- retencja D7 mierzalna i ≥ [DO USTALENIA, np. 20%],
- ≥1 kreacja z hook rate ≥25% organicznie,
- budżet ≥300 USD/mies. na min. 2 miesiące,
- start od Apple Search Ads.

### Cele na 90 dni (propozycja, do challenge)

| Metryka | Cel | Uzasadnienie |
|---|---|---|
| Lista oczekujących przed premierą | 100–300 | realne przy zerowym budżecie i sezonie [SZACUNEK] |
| Instalacje w 90 dni | 300–1000 | WowCow robił ~12/mies. w szczycie; Pauseo ma lepszy problem, sezon i plan [SZACUNEK, niska pewność] |
| Aktywacja (1. craving flow w 72 h) | ≥40% | [HIPOTEZA] |
| Recenzje App Store | ≥20 | social proof dla konwersji |

---

## 9. Decyzje i zasady wypracowane do tej pory

### 9.1 Decyzje (obowiązują)

| Decyzja | Źródło | Uzasadnienie |
|---|---|---|
| Zero paid do spełnienia bramki | lekcja Meta Ads WowCow (~148 USD → 0 instalacji) | B4, B5 |
| App Install (AAC), nigdy Traffic dla app installs | feedback_meta_ads_ios | B5 |
| Reddit / społeczności: nie jako nowe konto z linkami | feedback foundera | spam szkodzi wizerunkowi |
| ASO aktualizowane przy każdej zmianie pozycjonowania | feedback_aso_keywords | B3 |
| Push = hook / interwencja, nie pełna treść | feedback_push_strategy | open rate |
| Raporty z eksportu CSV, z typem metryki (kompletna / opt-in) | ten dokument | B10 |
| **Pomiar v0.1 = A (ASC) + D (badania jakościowe).** B (SDK analityczne) odrzucone dla v0.1. C (dobrowolne podsumowanie przez systemowe udostępnianie, bez sieci) jako kandydat do v0.2 | ADR-014, founder 2026-11-20 | zachowuje „Data Not Collected” i główny wyróżnik prywatności; przy <200 użytkownikach analityka daje szum; dane do North Star są już lokalnie (`guidedLoopOutcome`) |
| **Model: darmowy na premierę, bez zakupów w aplikacji, reklam i donacji.** Komunikat: „Pomoc w momencie cravingu jest i będzie bezpłatna. Bez konta, bez reklam.” Nie używać „za darmo na zawsze” | ADR-015, founder 2026-11-20 | spójne z Product_MVP (monetyzacja odroczona); obietnica możliwa do dotrzymania |
| **Rynek: PL + EN od premiery** (listing PL i EN). Marketing aktywny tylko PL, EN organicznie [założenie agenta, do potwierdzenia] | ADR-016, founder 2026-11-20 (agent rekomendował PL-only) | okno noworoczne także poza PL; karty EN już istnieją (korekta 2026-11-20); **warunek:** listing EN i QA PL/EN gotowe do ~08.12, inaczej fallback PL-only |
| **Inspiracje onboardingowe (2 rolki)** jako materiał, nie zakres. Rekomendacja: onboarding v0.1 skrócony do 1 ekranu | `docs/Inspiration_Onboarding_Reels.md`, 2026-11-20 | 4 z 5 ekranów nic nie dawało (odpowiedzi nie były zapisywane). **Decyzja foundera 2026-11-20: onboarding skrócony do 1 ekranu przed wysyłką do review** (wdrożone; QA sekcja 17) |

| **Pozycjonowanie:** „spokojna pomoc na sam moment cravingu: jedno dotknięcie i 2 minuty prowadzenia, bez wstydu po slipie i bez wysyłania danych z telefonu”. Wyróżniki: (1) moment, nie licznik; (2) slip to dane, nie reset; (3) bez konta, dane zostają w telefonie. Podtytuły robocze: PL „Pomoc, gdy chce Ci się zapalić”, EN „Get through cravings, no shame” | ADR-017, founder 2026-11-20 | wynika z kanonu (ADR-007, ADR-013); bez nazw konkurentów w metadanych; zgodne z claims policy |
| **Founder w treściach: twarz jako twórca, bez osobistej historii nałogu na start** (historia możliwa później). Nigdy „rzuciłem dzięki appce”; bez papierosa w kadrze | ADR-018, founder 2026-11-20 | najmocniejszy hook organiczny [HIPOTEZA]; historię można dodać, ale nie cofnąć |

### 9.2 Odrzucone opcje (z powodem)

| Opcja | Dlaczego odrzucona |
|---|---|
| TikTok Content Posting API | 2× odrzucone, bariery dla małych dev; Buffer lub ręcznie |
| Mnożenie pobrań ×3–5 | pobrania w ASC są kompletne (sekcja 2.4) |
| Rekomendacje Meta „opportunity score” | metryka korzystna dla Meta, nie dla foundera |
| Monetyzacja przed walidacją retencji | WowCow: Pro czekał na 200+ instalacji; ta sama zasada dla Pauseo |

### 9.3 Szablon raportu okresowego (dla Pauseo)

```
Okres: YYYY-MM-DD → YYYY-MM-DD   | Źródło: ASC CSV (lista plików) + [analityka wg ADR]
Kompletne: impressions, page views, first-time downloads, konwersja
Opt-in (~%): sessions, active devices, retention D1/D7/D30, deletions
Produkt: aktywacja, przetrwane cravingi/tydz., recovery rate
Kanały: ASC Sources (Search / Browse / Web Referrer / App Referrer)
Eksperymenty: hipoteza → wynik → decyzja (kontynuuj / zmień / porzuć)
Anomalie: co się zmieniło i dlaczego (albo „przyczyna nieznana”)
```

### 9.4 Inspiracja: case „scaling the app” (transkrypt)

Źródło: `WowCowTest/docs/scalingtheapp.txt`. Założyciel aplikacji do czytania deklaruje 10k użytkowników przy zerowym budżecie. [FAKT: treść transkryptu; liczby niezweryfikowane]
- **Walidacja przed buildem:** viralowe wideo UGC (reakcja twarzy + demo) → ~1 mln wyświetleń → 3000 osób na liście.
- **Badanie formatów:** narzędzia analizujące viralowe TikToki w niszy (HackUGC).
- **Szybki launch z listy:** e-mail do listy w dniu premiery → skok pobrań pierwszego dnia.
- **Wbudowany K-factor** (aplikacja społecznościowa).
- **Dla Pauseo:** produkt już istnieje, więc „walidacja przed buildem” zamienia się w **walidację komunikatu przed premierą**: testuj, które wideo i hasło zbiera zapisy. Format UGC „reakcja + demo” wymaga dopasowania do tematu wstydu. Historia autentyczna > stock UGC. [REKOMENDACJA · pewność: średnia]

---

## 10. Otwarte pytania do foundera (zamknąć przed planem wykonawczym)

| # | Pytanie | Dlaczego ważne |
|---|---|---|
| Q1 | Co się stało w **październiku 2026** w WowCow (12 pobrań, szczyt 24.10)? **Częściowo zamknięte:** founder nie wie i podejrzewał automatyczne rolki IG. Logi CloudWatch to wykluczają (0 postów od 07.05.2026). **Pozostało:** sprawdzić ASC → Sources za październik. | trzeba wiedzieć, co powtórzyć |
| Q2 | ~~Czy realna jest publiczna premiera Pauseo przed 27.12.2026?~~ **Zamknięte: tak**, realna (founder, 2026-11-20). | okno noworoczne |
| Q3 | ~~Czy domena pauseo.app jest kupiona?~~ **Zamknięte: tak.** Otwarte: czy jest skonfigurowana (hosting, DNS, e-mail) i czy istnieją konta social Pauseo (zarezerwować nazwę @pauseo.app na IG/TikTok). | kanał własny |
| Q11 | Co z martwą Lambdą IG WowCow: naprawić (dopisać uprawnienie IAM) czy wyłączyć EventBridge? Teraz generuje ~93 błędne uruchomienia/mies. i alarmy, które uczą ignorowania alertów. | higiena, koncentracja (B7, B14) |
| Q4 | ~~Czy founder chce pokazać twarz lub historię?~~ **Zamknięte: twarz jako twórca, bez historii na start** (ADR-018). | autentyczność = najsilniejszy organiczny hook |
| Q5 | ~~Model biznesowy Pauseo?~~ **Zamknięte: darmowy, rdzeń zawsze bezpłatny, bez zakupów w aplikacji** (ADR-015). | wpływa na pozycjonowanie („za darmo, bez haczyków”) i monetyzację później |
| Q6 | ~~Rynek: tylko PL na start?~~ **Zamknięte: PL + EN od premiery** (ADR-016); karty EN już są, na ścieżce krytycznej zostaje listing EN i QA PL/EN. | B8 |
| Q7 | Budżet czasu (h/tydz.) i pieniędzy (zł/mies.) na marketing Pauseo? | realność planu |
| Q8 | ~~Decyzja ADR pomiaru (A / B / C / D z sekcji 5.3)?~~ **Zamknięte: A + D; B odrzucone dla v0.1; C → v0.2** (ADR-014, 2026-11-20). | B9 |
| Q9 | Co z WowCow? Utrzymanie, wygaszenie, czy cross-promocja (~22 aktywnych to za mała baza na promocję)? | koszt utrzymania i uwagi foundera (B7) |
| Q10 | Czy jest dostęp do eksperta (psycholog uzależnień, lekarz) jako recenzenta lub advisora? | wiarygodność + PR |

---

## 11. Słownik

| Termin | Znaczenie |
|---|---|
| ASC | App Store Connect, panel Apple z danymi aplikacji |
| Opt-in only | metryki tylko od użytkowników, którzy zgodzili się udostępniać dane analityczne (~25–30%) |
| Impressions | ile razy aplikacja pojawiła się w App Store (wyszukiwanie, przeglądanie) |
| Product Page Views | wejścia na stronę aplikacji w App Store |
| First-Time Downloads | pierwsze pobranie przez dane Apple ID (bez ponownych) |
| ASO | App Store Optimization: tytuł, podtytuł, słowa kluczowe, screenshoty, oceny |
| AAC / App Install | cel kampanii Meta optymalizujący pod instalacje (vs. Traffic pod kliknięcia) |
| Hook rate | % widzów, którzy obejrzeli pierwsze ~3 s wideo |
| Learning phase | okres, w którym algorytm reklamowy zbiera sygnały (Meta: ~50 konwersji/tydz.) |
| SKAdNetwork | mechanizm Apple do anonimowej atrybucji instalacji z reklam |
| K-factor | ile nowych użytkowników przyprowadza średnio jeden użytkownik |
| Aktywacja | pierwszy moment realnej wartości (w Pauseo: ukończony flow cravingu) |
| Slip | jednorazowa wpadka (zapalenie) w trakcie rzucania |
| Abstinence violation effect | psychologiczny efekt „skoro raz zapaliłem, to wszystko stracone”, wzmacniany przez resetowane liczniki |
| Ghost | urządzenie bez aktywności >30 dni |
| WIP limit | limit równolegle prowadzonych inicjatyw |
