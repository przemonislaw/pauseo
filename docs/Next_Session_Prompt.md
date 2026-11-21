# Prompt na następną sesję (wklej na start nowego wątku)

> Wersja z 2026-11-21, ~02:30. Poprzedni wątek jest za długi. Ten plik zastępuje go jako punkt startu.

---

Kontynuujemy pracę nad Pauseo (iOS, SwiftUI, v1.0.0), publiczna premiera przed 27.12.2026, wysyłka do App Review ~15.12.

Najpierw przeczytaj: `CLAUDE.md`, `docs/Current_State.md`, `docs/Launch_Plan_v0.1.md` (to jest aktualna lista zadań), `docs/PAUSEO_GROWTH_BRIEF.md`, `docs/Inspiration_Onboarding_Reels.md`, ADR-014–018 w `docs/Architecture_Decisions.md`, `docs/Privacy_Safety.md`. Odpowiadaj po polsku. Zasady pracy z mojej pamięci: plan → zgoda → zmiany → `git diff` → commit; przy plikach i git nie pytaj o zgodę, ale przed commitem zawsze `git diff` (VS Code potrafi zapisać nieaktualny bufor).

## Stan na 21.11.2026 (zrobione)

- **Team ID = `36WKZ8Q4L5`** (certyfikat ma `OU=36WKZ8Q4L5`; `5T4Z65558R` to tylko ID osoby w nazwie certyfikatu). Wersja **1.0.0**, build **1**. W `project.yml` i pbxproj.
- **Archive i upload zrobione.** Build 1.0.0 (1) w ASC → TestFlight: Complete, Ready to Submit. Ostrzeżenie 90725 (SDK iOS 26.5; od 04.2027 wymagany Xcode 27) jest tylko informacją: przy v1.1 buduj nowym Xcode.
- **Testy na iPhonie z TestFlight przeszły** (QA sekcja 17 zamknięta). Obserwacja: „Kończę na teraz” na zaproszeniu do 2-minutowej sekwencji nie zapisuje wyniku, więc licznik „Przetrwane cravingi” się nie pokazuje (celowo; w sekwencji ten sam napis prowadzi do pytania o wynik). Pytać o to w becie; kandydat na v1.0.1. Zapisane w `docs/Current_State.md`.
- **Strona pauseo.app działa** (Vercel projekt `pauseo-web`, Root Directory `web`, folder `web/` w tym repo, auto-deploy z `main`). DNS w GoDaddy: A `@` = `216.198.79.1`, CNAME `www` = `5a7864dbec6591f5.vercel-dns-017.com.`; `pauseo.app` główne, `www` przekierowuje. Strony: `/`, `/privacy`, `/support` i wersje `/en/...`. **Jasna, bez trybu ciemnego** (decyzja foundera). Ramki telefonów to makiety CSS z prawdziwych tekstów aplikacji (PL/EN z `Localizable.xcstrings`).
- Stitch: projekt „pauseo.app — website” (`11718551952973042349`), ekran „Pauseo — Top Section” (desktop, białe tło); projekt aplikacji „pauseo — iOS MVP” (`10453210848545566223`). Generowanie często zwraca timeout: nie ponawiaj od razu, sprawdzaj `list_screens`; krótsze prompty działają lepiej. Pobieranie plików tylko przez `mcp__stitch__download_file`.

## Do zrobienia (w tej kolejności)

1. **`support@pauseo.app`**: strona i polityka już go podają, ale poczta nie działa (brak rekordów MX). Sprawdzić GoDaddy → E-mail (przekierowanie bez płatnego planu), w przeciwnym razie darmowy ImprovMX (2× MX + TXT SPF, nie ruszać `_dmarc`). Wyślij test z innego konta. Weryfikacja: `dig MX pauseo.app @8.8.8.8`.
2. **Sprawdzić deploy strony** po commicie `95f6a5b` (na żywo `https://pauseo.app`; lokalny resolver bywa w cache, używaj `curl --resolve pauseo.app:443:216.198.79.1`). Obejrzeć wersję mobilną na prawdziwym telefonie.
3. **ASC**: zmienić wersję „1.0” na **1.0.0** (Distribution). Wpisać Privacy Policy URL `https://pauseo.app/privacy`, Support URL `https://pauseo.app/support`, Marketing URL `https://pauseo.app`. Wykluczyć Chiny kontynentalne (Pricing and Availability). App Privacy: „Data Not Collected”. Odznaczyć „Sign-in required”.
4. **Zewnętrzny TestFlight**: grupa zewnętrzna + publiczny link, Test Information (opis bety, e-mail `support@pauseo.app`), Beta App Review.
5. **Zrzuty ekranu z TestFlight** (Home, karta w sekwencji, zakończenie z licznikiem, slip). Wstawić je na stronę zamiast makiet CSS i do listingu (6 zrzutów, każdy z jedną korzyścią, #1 = moment cravingu, bez nazw konkurencji).
6. **Rekrutacja bety (15–30 osób) i 5–10 rozmów** (01–07.12): słownik („craving” czy „głód/ssanie/chęć zapalenia”), gdzie się zatrzymali, co z „Kończę na teraz”. Pytania są w `docs/Launch_Plan_v0.1.md`, sekcja D.
7. **Listing PL i EN** (do 08.12 wg ADR-016, inaczej fallback PL-only): tytuł, podtytuł, słowa kluczowe, opis, promo text, copyright; audyt top 10 konkurencji w PL (wewnętrznie).
8. **Konta social**: zarezerwować nazwy (IG, TikTok, YouTube, FB), jedno konto aktywne (rekomendacja: IG Reels), ręcznie, twarz jako twórca (ADR-018), bez automatyzacji.
9. **Higiena**: wyłączyć martwą Lambdę IG z WowCow (brief Q11).
9b. **SEO (kod gotowy 2026-11-21, do zrobienia ręcznie po deployu):** (a) Google Search Console: dodać właściwość domeny `pauseo.app` (weryfikacja TXT w GoDaddy), wysłać `https://pauseo.app/sitemap.xml`, poprosić o indeksację `/`, `/en`, `/co-robic-gdy-chce-sie-zapalic` i `/en/what-to-do-when-you-want-to-smoke` (podstrony treściowe są na razie bez imienia autora, podpis „twórca Pauseo”, decyzja foundera 2026-11-21); (b) Bing Webmaster Tools (import z GSC), bo z Bingiem korzysta m.in. ChatGPT Search; (c) po deployu sprawdzić `https://pauseo.app/robots.txt`, `/sitemap.xml`, `/llms.txt`, test „Rich Results” dla FAQPage/MobileApplication; (d) po premierze: dodać `<meta name="apple-itunes-app" content="app-id=...">` (Smart App Banner), link do App Store w JSON-LD (`downloadUrl`) i w `llms.txt`, a w tekstach zamienić „w grudniu 2026” na „w App Store”; (e) linki zwrotne (to one budują widoczność w Google i cytowania AI): wpis w katalogach aplikacji/zdrowia, wzmianki w społecznościach i mediach PL, profile IG/YT z linkiem do pauseo.app; (f) opcjonalnie podstrony treściowe (np. „Co robić, gdy chce Ci się zapalić”, oparte na kartach wsparcia ze źródłami WHO/NHS/NCI) po zgodzie na zakres.

Odłożone (bez mojej zgody nie robić przed premierą): widget/Action Button, przypomnienie w ryzykownej porze, lokalne podsumowanie triggerów, zakres „C”, podsumowanie do udostępnienia, zmiana zachowania „Kończę na teraz”.

Budżet czasu: 5–6 h/tydz. na marketing. Cięcia w kolejności: PR, liczba wideo, nigdy listing i polityka prywatności.

## Niezmienne ograniczenia

Bez backendu, konta, analityki, AI-coacha, HealthKit, porad medycznych, dawek NRT/leków. Bez streaków, odznak i wstydu po wpadce. Copy: spokojne, bezpośrednie, dorosłe. Bez obietnic skuteczności („rzucisz”, „skuteczne”, „oparte na dowodach”), bez liczb zdrowotnych w marketingu, bez nazw konkurencji w metadanych, bez papierosa w kadrze i fear appeals. Strona: bez cookies, bez analityki, bez Meta Pixel, bez fontów z zewnętrznych serwerów (RODO). Nie commitować szumu z `Localizable.xcstrings` ani zmian Xcode w pbxproj bez `git diff` (nie klikać „Remove stale”: skasowałoby tłumaczenia kart wsparcia i liczby mnogiej). Tylko prawdziwe teksty aplikacji w makietach; żadnych wymyślonych liczb, ocen ani opinii.

## Co wie najlepszy 1% (psychologia, UX, marketing) w takich aplikacjach: zaadaptuj jako sugestie, nie dogmaty

Dla każdego punktu: zakwestionuj go względem kanonu produktu, oznacz [HIPOTEZA] / [DO WERYFIKACJI] i zaproponuj najtańszy test w ramach ADR-014 (ASC + rozmowy, bez analityki). Nie wprowadzaj niczego do aplikacji bez mojej zgody.

**Psychologia**
1. **Chęć zapalenia mija sama** (urge surfing, Marlatt; NHS: zwykle kilka minut). Najsilniejszy komunikat to nie „walcz”, tylko „to minie, a Ty masz plan na te minuty”. Wykorzystać w copy listingu, strony i wideo. Zweryfikować sformułowania ze źródłami z `support_cards.json`.
2. **Plany „jeśli–to”** (implementation intentions, Gollwitzer): „Gdy po kawie przychodzi ochota, zrobię X” działa lepiej niż ogólna motywacja [DO WERYFIKACJI: wielkość efektu]. Pytanie o trigger po fakcie to materiał na przyszłą, lokalną podpowiedź w v1.1, nie teraz.
3. **Efekt naruszenia abstynencji** (Marlatt): jedna wpadka → „i tak wszystko stracone”. Liczniki dni to wzmacniają. To jest nasz wyróżnik; przekazywać go konkretnym zdaniem, nie hasłem („licznik nigdy nie spada”).
4. **Poczucie własnej skuteczności** (Bandura): licznik „przetrwanych cravingów” to dowód „dałem radę”, a nie punktacja. Zawsze pokazywać jako fakt, nigdy jako nagrodę czy rywalizację.
5. **Appeals strachu bez poczucia skuteczności zwiększają unikanie** (Witte, model EPPM) [DO WERYFIKACJI]. Dlatego zero obrazów płuc i „palenie zabija”; zawsze „masz co zrobić teraz”.
6. **Reaktancja** (Brehm): „musisz”, „powinieneś” budzą opór. Tekst autonomii („możesz”, „jeśli chcesz”, „skończ w każdej chwili”) jest już w aplikacji; trzymać ten ton też w marketingu.
7. **Peak-end rule** (Kahneman): użytkownik zapamiętuje szczyt i koniec. Końcowe ekrany (zakończenie cravingu, slip) są ważniejsze niż reszta; testować je w rozmowach jako pierwsze.
8. **Efekt świeżego startu** (Dai, Milkman, Riis 2014): ludzie podejmują zmiany po „datach-początkach” (Nowy Rok, poniedziałek, Popielec). Używać do **czasu pozyskiwania** (okno 1–15.01, Wielki Post od 10.02.2027), ale nie do mechaniki w aplikacji („zacznij od nowa” zostaje zakazane).

**UX**
9. **Czas do pierwszej pomocy**: w tej kategorii liczą się sekundy. Mierzyć w rozmowach: ile dotknięć i sekund od otwarcia do pierwszej podpowiedzi. Największa dźwignia po premierze to dostęp jednym ruchem (widget ekranu blokady, Action Button) w v1.1, bo moment użycia jest nieplanowalny.
10. **Moment odkrycia ≠ moment użycia**: ludzie instalują, gdy są zmotywowani (styczeń), a używają w losowej chwili głodu. Onboarding ma „przygotować na ten moment” (np. opcjonalne 30-sekundowe demo, hipoteza v0.2 w `Inspiration_Onboarding_Reels.md`), a nie zbierać dane.
11. **Domyślne ustawienia i 3–5 opcji** zamiast wyboru z dużej listy; pierwszy ekran z jednym działaniem. Już stosowane; chronić przed „dopisywaniem” funkcji.
12. **Konkret wygrywa z urokiem** (rolka 3): „2 minuty”, „co 10 sekund”, „5 oddechów: wdech na 4, wydech na 6” są wiarygodne dlatego, że są liczbami. Każdy komunikat ma odpowiadać na „co to jest i co z tego mam”.
13. **Sukces w tej kategorii = czasem mniejsze użycie.** Nie optymalizować pod DAU i czas w aplikacji; North Star to „przetrwane cravingi na aktywnego użytkownika”, ale w v1.0 mierzymy go tylko jakościowo.

**Marketing**
14. **Wyszukiwanie w momencie głodu to osobny, wysokointencyjny kanał.** Ludzie wpisują potoczne frazy („jak przestać chcieć zapalić”, „ile trwa głód nikotynowy”, „ssanie na papierosa”), a nie „aplikacja do rzucania”. Zbadać frazy w rozmowach i w ASC → Sources/Search; rozważyć 3–5 krótkich, rzetelnych stron na pauseo.app (ze źródłami WHO/NHS) jako kanał, który działa bez social mediów [HIPOTEZA; najtańszy test: jedna strona + Search Console].
15. **Kupujący ≠ jedyny odbiorca**: osoby bliskie (partner, rodzic, przyjaciel) szukają, jak pomóc. Wątek „podeślij komuś, kto próbuje rzucić” jest w briefie (6.3). Dla osoby rzucającej udostępnianie jest wstydliwe i prywatne, więc dobrze działa tylko, gdy nie ujawnia jej (karta z faktem i linkiem, nie „używam Pauseo”).
16. **Zaufanie przy danych wrażliwych buduje konkret, nie hasło**: „co dokładnie zapisujemy i gdzie” (jest w polityce) + odnośnik do etykiety prywatności w App Store, gdy będzie opublikowana. Nie obiecywać nic, czego nie da się sprawdzić.
17. **Pierwsze oceny decydują o konwersji listingu.** Prośba o ocenę tylko po sukcesie (jest w aplikacji; w TestFlight się nie pokaże). Przed premierą poprosić betatesterów o recenzję w dniu publikacji. Nie kupować i nie wymyślać opinii.
18. **Jedna twarz, jeden format, powtarzalność**: konto od zera nie zbuduje zasięgu przed premierą. Cel eksperymentu to sprawdzić hooki (pierwsza sekunda) i mieć materiał na styczeń. Hook z audytu: „Większość aplikacji do rzucania palenia zadaje 10 pytań, zanim pomoże. Pauseo ma jeden ekran” (wolno ogólnie, bez nazw; najpierw policzyć ekrany konkurencji).
19. **Kanały zaufania w PL** (Telefoniczna Poradnia Pomocy Palącym, apteki, psychologowie uzależnień) dają rekomendację, której nie kupisz reklamą. Zacząć od jednej rozmowy z ekspertem o recenzji kart wsparcia (Q10 w briefie).
20. **Premiera to proces, nie dzień**: szczyt styczniowy trwa ~2 tygodnie; plan wideo, PR i maili rozpisać na 15.12–15.01, a nie na jeden dzień.

## Jak pracować w tej sesji

Zacznij od krótkiego podsumowania stanu i listy rzeczy, których nie da się sprawdzić w repo (zapytaj mnie o nie). Potem wykonuj zadania z sekcji „Do zrobienia” po kolei, od punktu 1. Do każdej zmiany: CURRENT STATE / SMALLEST SAFE CHANGE / ACCEPTANCE CRITERIA / TEST PLAN (jak w `CLAUDE.md`). Kwestionuj moje założenia, kiedy dane (ASC, rozmowy) mówią co innego. Raporty z liczbami zawsze z okresem, typem metryki (kompletna czy opt-in) i źródłem.
