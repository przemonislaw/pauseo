# Launch Plan v0.1: lista zadań do premiery

> **Data:** 2026-11-21 · **Cel:** publicznie w App Store przed 27.12.2026, wysyłka do App Review ~15.12.
> **Źródła:** `docs/PAUSEO_GROWTH_BRIEF.md` (sekcje 4, 6, 8, 10), ADR-012–018, `docs/Inspiration_Onboarding_Reels.md` (rolka 3).
> **Zasada WIP (brief B7):** jeden kanał akwizycji (ASO + lista) i jeden eksperyment (wideo foundera) naraz.
> Ten plik to lista zadań. Decyzje zostają w ADR, a uzasadnienia w briefie.

## Ścieżka krytyczna (dlaczego ta kolejność)

Listing PL i EN musi być gotowy do ~08.12 (ADR-016). ADR-017 każe przed tym sprawdzić w rozmowach, jakimi słowami ludzie mówią o cravingu. Rozmowy wymagają testerów z zewnątrz, a ci wymagają **External TestFlight**. External TestFlight potrzebuje adresu e-mail do feedbacku i (najpewniej) URL polityki prywatności. Dlatego **e-mail w domenie i minimalna strona pauseo.app trzeba zrobić przed betą, nie przed review.**

```
Internal TF (22–24.11) ─┐
e-mail + strona min. (do 28.11) ─┴→ External TF (~29.11) → rozmowy (01–07.12) → copy listingu (08.12) → review (15.12) → premiera (20–23.12)
```

## A. Archive → Internal TestFlight (22–24.11)

- [x] **Team ID = `36WKZ8Q4L5`** (2026-11-21). W Xcode team „Przemyslaw Pietruszewski” to jedyny team, a certyfikat ma `OU=36WKZ8Q4L5`. `5T4Z65558R` to identyfikator osoby w nazwie certyfikatu. Poprawione w `project.yml`, pbxproj wygenerowany przez xcodegen.
- [x] **Wersja `1.0.0`, build `1`** (decyzja foundera). W ASC jest „iOS App Version 1.0” → zmienić numer na **1.0.0**, żeby zgadzał się z buildem (pole jest edytowalne w stanie Prepare for Submission). Każdy kolejny upload: `CURRENT_PROJECT_VERSION` +1.
- [ ] Przed Archive: nie commitować szumu z `Localizable.xcstrings` („stale”, puste `%@`). Nie klikać „Remove stale”.
- [x] Xcode: schemat Pauseo, cel „Any iOS Device (arm64)” → Product → Archive (konfiguracja Release jest w `project.yml`).
- [x] Organizer → Distribute App → App Store Connect → Upload. Automatic signing utworzy certyfikat dystrybucyjny (lokalnie jest tylko Apple Development).
- [x] Export compliance: `ITSAppUsesNonExemptEncryption = false` jest już w Info.plist (ADR-013), więc ASC nie powinien pytać.
- [x] ASC → TestFlight: build przetworzony (zwykle 5–30 min), grupa wewnętrzna z founderem, instalacja z aplikacji TestFlight, smoke test na telefonie.
- [x] QA sekcja 17: dwa niezaznaczone punkty sprawdzić na buildzie z TestFlight.
- [ ] Commit tylko po `git diff` (VS Code potrafi zapisać nieaktualny bufor).

**A zrobione 2026-11-21:** Archive 1.0.0 (1) wysłany (ostrzeżenie 90725 o SDK iOS 26.5 jest informacyjne; od 04.2027 wymagany Xcode 27, więc v1.1 buduj nowym Xcode), build Complete, testy na iPhonie z TestFlight przeszły.

**Strona (2026-11-21):** pauseo.app działa na Vercelu z folderu `web/` (DNS w GoDaddy ustawiony: A `@` 216.198.79.1, CNAME `www` do vercel-dns-017), jasna wersja PL/EN z `/privacy` i `/support`. **22.11:** `support@pauseo.app` działa (ImprovMX, odbiór, filtr w Gmailu), SEO i dwie podstrony treściowe wdrożone, wersja mobilna sprawdzona. **Zostaje:** wersja ASC 1.0 → 1.0.0, zewnętrzny TestFlight. Pełna lista w `docs/Next_Session_Prompt.md`.

## A0. Przed External TestFlight (do 28.11): fundamenty, których brakowało w WowCow

- [ ] **Zarezerwować nazwy** (10 min, bez publikowania): Instagram, TikTok, Threads (z IG), YouTube, strona na Facebooku. Ta sama nazwa wszędzie, np. `@pauseo.app` albo `@pauseoapp` [DO WERYFIKACJI: dostępność]. Bio na razie: jedno zdanie + pauseo.app. Pytanie Q3 w briefie.
- [x] **E-mail w domenie (zrobione 2026-11-22, ImprovMX, filtr w Gmailu)**: `support@pauseo.app` (decyzja 2026-11-21, jak `support@wowcow.app`) (kontakt, polityka prywatności, feedback z TestFlight, kontakt dla App Review), na razie tylko odbiór z przekierowaniem na prywatną skrzynkę. DNS jest w GoDaddy (NS `domaincontrol.com`), więc Cloudflare Email Routing odpada (wymaga przeniesienia NS). Opcje: przekierowanie w GoDaddy → E-mail, jeśli jest w planie, albo ImprovMX free (2 rekordy MX + SPF TXT) [DO WERYFIKACJI: aktualne limity]. Uwaga: w DNS jest już `_dmarc` z `p=quarantine`; nie ruszać przy dodawaniu MX.
- [x] **Hosting strony: folder `web/` w tym repo → Vercel → domena GoDaddy (zrobione 2026-11-21, 200 na żywo)** (tak jak WowCow):
  - Vercel: nowy projekt z repo `pauseo`, Root Directory = `web`, bez frameworka (statyczny HTML/CSS).
  - Ignored Build Step: `git diff HEAD^ HEAD --quiet -- .` (w katalogu `web`), żeby commity aplikacji iOS nie budowały strony.
  - GoDaddy DNS: rekord `A @` dziś wskazuje na „WebsiteBuilder Site” → zamienić na wartość podaną przez Vercel; `CNAME www` → wartość z Vercel (dziś `pauseo.app.`). Wartości przepisać z ekranu Vercel → Domains, nie z pamięci.
  - Bez Vercel Web Analytics i bez Meta Pixel (inaczej niż WowCow), bez banera cookies.
  - [DO WERYFIKACJI] Plan Hobby jest dla użytku niekomercyjnego; darmowa aplikacja bez przychodu raczej się mieści, sprawdzić warunki.
- [x] **Minimalna strona pauseo.app: kod gotowy w `web/` (2026-11-21)**, do wdrożenia na Vercel. Strona główna, `/privacy`, `/support` + `/en/...`. Zapis do bety na razie przez `mailto:` (zero dostawców danych); formularz listy dopiero po wyborze dostawcy (statyczna; hosting np. Cloudflare Pages lub GitHub Pages; bez AWS, bez frameworka):
  - `/`: co to jest i co z tego masz (rolka 3), 3 wyróżniki z ADR-017, zapis na listę / do bety,
  - `/privacy` (PL) i `/en/privacy` (EN): aplikacja nie zbiera danych (zgodnie z `docs/Privacy_Safety.md`); osobno strona i lista mailowa: jaki e-mail, po co, kto przetwarza, jak się wypisać (RODO),
  - `/support`: kontakt + 3–5 pytań (jak usunąć dane, czy jest konto, czy to porada medyczna).
  - Bez cookies i bez analityki na stronie. Wtedy nie trzeba banera cookies, a strona mówi to samo co aplikacja.
- [ ] **Lista mailowa** (kanał własny, błąd B11): formularz od dostawcy z UE z podwójnym potwierdzeniem, np. MailerLite [DO WERYFIKACJI: darmowy plan, umowa powierzenia]. Jedna lista, z polem PL/EN albo bez niego.
- [ ] ASC → TestFlight → Test Information: opis bety, e-mail do feedbacku, dane kontaktowe [DO WERYFIKACJI: czy dla grup zewnętrznych wymagany jest URL polityki prywatności].

## D. Beta i rozmowy (29.11–10.12)

- [ ] Grupa zewnętrzna + publiczny link TestFlight; Beta App Review [DO WERYFIKACJI: aktualny czas, zwykle ~1–2 dni].
- [ ] Rekrutacja, realnie 15–30 osób, a nie 50–100 [SZACUNEK: bez widowni źródłem są tylko znajomi i znajomi znajomych]: osobiste wiadomości do palących lub wapujących znajomych, prośba „podeślij komuś, kto próbuje rzucić”, zapisy ze strony.
- [ ] Grupy FB „rzucam palenie”: najpierw zgoda admina, potem jeden post od foundera jako twórcy, z prośbą o testerów, a nie o pobrania [DO WERYFIKACJI: regulaminy grup].
- [ ] **5–10 rozmów (01–07.12)**, 15 min każda. Pytania:
  1. „Jak mówisz o tym momencie, kiedy chce Ci się zapalić?” (craving / głód / ssanie / chęć)
  2. „Kiedy ostatnio to było i co wtedy zrobiłeś/aś?”
  3. Po pierwszym użyciu: „Gdzie się zatrzymałeś/aś?”, „Czy pytanie o to, co uruchomiło craving, pojawiło się za późno?”
  4. „Jak opisałbyś/opisałabyś Pauseo komuś w jednym zdaniu?” (gotowe copy do listingu)
- [ ] Wynik do 08.12: słownik użytkownika → decyzja o słowach w podtytule, słowach kluczowych i screenshotach. Zmiany w aplikacji (np. „Mam craving teraz”) dopiero w v0.1.x, za zgodą foundera.
- [ ] Trigger po zmianie kolejności flow: pytać w rozmowach (ADR-014: bez analityki).

## B. Listing w App Store Connect, PL i EN (01–10.12)

- [ ] Audyt top 10 aplikacji w App Store PL (tytuły, screenshot #1, skargi w recenzjach 1–3★), tylko na użytek wewnętrzny; bez nazw konkurencji w metadanych (ADR-017).
- [ ] Tytuł, podtytuł, słowa kluczowe (100 znaków), opis, promo text: PL i EN.
- [ ] 6 zrzutów ekranu, każdy z jedną konkretną korzyścią; #1 to moment cravingu (Home z jednym przyciskiem + „bez konta”).
- [ ] Support URL `pauseo.app/support`, Marketing URL `pauseo.app`, Privacy Policy URL `pauseo.app/privacy`, Copyright.
- [ ] App Privacy: „Data Not Collected”. App Review: odznaczyć „Sign-in required”, notatka dla recenzenta (brak konta, brak sieci, brak porad medycznych).
- [ ] **Dostępność: wykluczyć Chiny kontynentalne** (Pricing and Availability). ASC wymaga tam Security Assessment i deklaracji AIGC (banery w ASC, 2026-11-21). Dla aplikacji z marketingiem PL/EN to koszt bez zysku.
- [ ] Opcja do rozważenia: **pre-order** w App Store. Jeśli build przejdzie review wcześniej, link do App Store działa przed premierą, a zamówieni użytkownicy dostają aplikację automatycznie [DO WERYFIKACJI: wymogi i wpływ na termin review].

## C. pauseo.app v2 (do 12.12)

- [ ] Struktura z rolki 3: problem → krótkie demo (nagranie ekranu 2-minutowego flow, 15–20 s) → jedno CTA (przed premierą zapis, po premierze App Store).
- [ ] Po premierze: link do App Store z tokenem kampanii (`ct=`) osobno dla strony, IG i TikToka, żeby w ASC → Sources widać było źródła (ADR-014, bez SDK).
- [ ] Press kit: ikona, 3 zrzuty, zdjęcie foundera, 3 zdania o produkcie.

## E. Treści i premiera (30.11 → 15.01)

- [ ] Eksperyment: 5 wideo foundera do 14.12, ręcznie (ADR-018): twarz jako twórca + nagranie ekranu, hook w 1. sekundzie, bez papierosa w kadrze. Aktywnie jedna platforma, rekomendacja: IG Reels [HIPOTEZA: grupa 25–45 w PL]. Ten sam plik można wrzucić też na TikToka, ale bez prowadzenia dwóch kanałów.
- [ ] Realistyczne oczekiwania: konto od zera do premiery nie zbuduje zasięgu [SZACUNEK]. Cel eksperymentu to sprawdzić hooki i mieć gotowe materiały na szczyt 1–15.01.
- [ ] Kill criteria (brief 6.1): po 10 wideo średnio <500 wyświetleń → zmiana formatu.
- [ ] PR: lista 10–20 mediów (zdrowie, tech, lokalne) do 10.12; pitch 14–17.12 z datą premiery, temat „darmowa, prywatna aplikacja bez wstydu po wpadce, na postanowienia noworoczne”.
- [ ] Dzień premiery: mail do listy, wiadomość do beta-testerów z prośbą o ocenę (prośba w aplikacji działa tylko po wyniku „Nie zapaliłem/am”).
- [ ] Raport po 2 tygodniach według szablonu z briefu (9.3).

## F. SEO i Search Console (kod wdrożony 21–22.11, reszta ręcznie)

Zrobione: canonical i hreflang, OG, JSON-LD, FAQ, `robots.txt`, `sitemap.xml`, `llms.txt`, dwie podstrony treściowe (PL/EN), wszystko 200 na żywo.

- [ ] **Google Search Console (ręcznie, ~15 min):** właściwość domeny `pauseo.app` (weryfikacja TXT w GoDaddy; po dodaniu sprawdzić na serwerze autorytatywnym), wysłać `https://pauseo.app/sitemap.xml`, poprosić o indeksację `/`, `/en`, `/co-robic-gdy-chce-sie-zapalic`, `/en/what-to-do-when-you-want-to-smoke`.
- [ ] **Bing Webmaster Tools** (import z GSC; z Bingiem korzysta m.in. ChatGPT Search).
- [ ] Test „Rich Results” dla FAQPage i MobileApplication.
- [ ] Kolejne podstrony treściowe (np. „ile trwa głód nikotynowy”, „co robić po wpadce”) dopiero po sprawdzeniu w GSC, czy pierwsze dwie się indeksują. Metryka: indeksacja i wyświetlenia w GSC (kompletna dla Google). Kryterium stop: brak indeksacji po 4 tygodniach → przegląd treści.
- [ ] Po premierze: `<meta name="apple-itunes-app" content="app-id=...">`, `downloadUrl` w JSON-LD i link App Store w `llms.txt`; w tekstach „w grudniu 2026” → „w App Store”.
- [ ] Linki zwrotne (budują widoczność w Google i cytowania AI): katalogi aplikacji i zdrowia, wzmianki w społecznościach i mediach PL, profile IG/YT z linkiem.
- [ ] Autor podstron: dziś „twórca Pauseo”; imię i nazwisko dodać tylko decyzją foundera.

## Do zrobienia ręcznie (higiena, poza repo)

- [ ] WowCow: wyłączyć albo naprawić martwą Lambdę IG (EventBridge lub uprawnienie IAM, brief Q11), żeby alarmy nie uczyły ignorowania alertów. Nie dotyczy kodu Pauseo.

## Budżet czasu: 5–6 h/tydz. na marketing (Q7, 2026-11-21)

Około 25–30 h do premiery. Kolejność cięć, gdy brakuje czasu: najpierw PR, potem liczba wideo (5 → 3), nigdy listing i polityka prywatności.

| Tydzień | Zadania (≈5–6 h) |
|---|---|
| 23–29.11 | nazwy w social media (0,5 h), e-mail w domenie (0,5 h), strona min. + polityka prywatności (2 h z Claude), Test Information + External TF (0,5 h), wiadomości do znajomych (1 h) |
| 30.11–06.12 | 5 rozmów po 15 min (2 h), audyt konkurencji (1 h), 2 wideo (2 h) |
| 07–13.12 | listing PL/EN + zrzuty (3 h), strona v2 z demo (1 h), 1–2 wideo (1,5 h) |
| 14–20.12 | wysyłka do review, lista 10 mediów i pitch (2 h), 1 wideo, mail na premierę (1 h) |

## Otwarte pytania do foundera

- Q10: czy jest ekspert (psycholog uzależnień), którego warto zapytać już teraz o recenzję kart wsparcia? To potrwa tygodnie.

## Odłożone na v1.1 (bez zgody foundera nie robimy przed premierą)

Widget na ekranie blokady lub w Centrum sterowania, przypomnienie w ryzykownej porze, lokalne podsumowanie triggerów, zakres „C” (ekran prywatności), podsumowanie do udostępnienia (ADR-014 C, v0.2).
