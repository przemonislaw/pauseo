# Badanie potrzeb użytkowników (wątek B) — 2026-11

> **Data:** 2026-11-26 · **Status:** wynik badania desk research, bez zmian w aplikacji.
> **Cel:** znaleźć lukę do wzmocnienia istniejącego pozycjonowania (ADR-017: moment, slip to dane, bez konta), nie nową funkcję.
> **Etykiety:** [FAKT: źródło] · [HIPOTEZA] · [DO WERYFIKACJI].
> **Prompt źródłowy:** `docs/Prompt_Grafika_i_Badanie_Potrzeb.md` (wątek B).

## 1. Próba i ograniczenia

| Źródło | Zakres | Uwagi |
|---|---|---|
| Recenzje 1–3★ App Store PL (zrzuty foundera, sortowanie „Najbardziej krytyczne”) | ~20 recenzji: QuitNow (4,7, 2,6 tys. ocen), Smoke Free (4,8, 638 ocen), Kwit | Większość ma 5–11 lat. Przypisanie recenzji do aplikacji wnioskowane z odpowiedzi deweloperów i treści |
| Fragmenty recenzji App Store US | quitSTART, EasyQuit, Kwit, Smoke Free, Qwit (Google Play) | Fragmenty z wyszukiwarki, nie pełna próba |
| Google Trends PL | 11.2021–11.2026, eksport CSV: „rzucić palenie”, „rzucanie palenia”, „e-papieros”, „głód nikotynowy”, „jak rzucić e-papierosa” + top queries dla „e-papieros” | Indeks względny 0–100. Wartość 0 oznacza wolumen poniżej progu, a nie brak wyszukiwań |
| Google SERP PL (zrzuty foundera, Wrocław, wyniki spersonalizowane) | „jak rzucić”, „rzucenie e-”, „głód nikotynowy” | „Więcej pytań”, „Inni wyszukiwali również”, chipy |
| App Store, fraza „rzuć” (zrzuty foundera, 26.11.2026) | 14 aplikacji | Tylko pierwsze ekrany wyników |
| Literatura | Rodberg 2025, Fonteyne 2026 (pełny tekst), Shiffman (AVE), Bowen & Marlatt 2009, Hope 2025 (Quit Sense, abstrakt), PMC7568217, NHS/HSE | Patrz sekcja 7 |

Czego brakuje: Google Play PL, Reddit i polskie fora, rozmowy z użytkownikami (beta 15–30 osób to najlepsze źródło weryfikacji).

## 2. Google Trends PL

- **Styczeń to jedyny powtarzalny szczyt.** [FAKT: CSV Trends] „rzucić palenie” rośnie co roku w styczniu, np. 12 (12.2025) → 22 (01.2026), czyli o +83%. „rzucanie palenia” rośnie 10 → 17.
- **Wielki Post i 31 maja: brak sygnału.** [FAKT: CSV Trends] Luty, marzec i maj są na poziomie bazowym (12–15).
- **Ogólny popyt powoli spada.** [FAKT: CSV Trends] Średnia dla „rzucić palenie” spadła z ~19 (2022) do ~14 (2026). „e-papieros” spadł ze 100 (09.2022) do 25 (11.2026). Krótki skok w 08–09.2025 [HIPOTEZA: doniesienia o regulacjach].
- **„e-papieros” to fraza zakupowa.** [FAKT: top queries] Rosnące zapytania to „jednorazowy”, „żabka”, „aroma king”, „cena”, „allegro”, „crystal”, „oxva”.
- **„głód nikotynowy” ma prawie zerowy wolumen**, ok. 1 przy 17 dla „rzucić palenie”. [FAKT: CSV Trends]

## 3. Google SERP PL

- „głód nikotynowy”, sekcja „Więcej pytań”: *Jak długo czuje się głód nikotynowy? · Co zabija głód nikotynowy? · Co zrobić, jak ma się głód nikotynowy?* Powiązane: „ile trwa”, „jak sobie radzić”, „forum”, „domowe sposoby”. [FAKT: zrzut SERP]
- „jak rzucić”: Google podpowiada **„jak rzucić palenie aplikacja”** (chip i „Inni wyszukiwali”), a także „forum”, „tabletki”, „domowe sposoby”, „w pięć dni”. Przegląd AI radzi: „zapisuj, kiedy i dlaczego sięgasz (stres, kawa, nuda)”. [FAKT: zrzut SERP]
- „rzucenie e-”: podpowiedzi „rzucanie e-papierosa objawy”, „jak rzucić e-papierosa forum”, „zamiennik e-papierosa”, „tabletki na rzucenie e-papierosa”. [FAKT: zrzut SERP]

## 4. App Store PL — recenzje krytyczne

| Temat | Ile | Cytaty |
|---|---|---|
| Pieniądze, subskrypcja, reklamy | ~9 (dominuje) | „Subskrypcja, to narzędzie do wyłudzenia pieniędzy” (Smoke Free 1★). „zapłaciłam za rok ponad 200 złotych, i po 4 dniach klapa” (Kwit 1★). „previously free features disappeared behind paywall” (Kwit 1★). „Cwaniakowanie na reklamach… firmy wyłudzające subskrypcje” (QuitNow 1★). „Nie daje odczuć tak bardzo jak np. Kwit, że nie masz do czegoś dostępu póki nie zapłacisz” (Smoke Free 4★) |
| Wpadka → usunięcie aplikacji → paywall przy powrocie | 1 (kluczowy) | „Kupiłem wersję płatną – poległem, zapaliłem. Aplikację usunąłem, a sam paliłem ponownie przez następne 2 miesiące. Teraz kiedy chcę wrócić… za wersję premium musiałbym…” (QuitNow 2★) |
| Brak polskiego | 2 | „Po aktualizacji nie ma polskiego języka. Słabo” (QuitNow 1★). Kwit: „not yet in Polish” |
| Infantylny wygląd | 1 | „Mogłoby być mniej infantylne wizualnie” (QuitNow 3★) |
| Błędy, aktualizacje, bateria, utrata danych | ~6 | „nie startuje”, „zżera baterię”, „dane ucięte”, „rosyjski alfabet”, „less motivational” |

## 5. App Store, fraza „rzuć” — krajobraz konkurencji

[FAKT: zrzuty 26.11.2026]
- Żadna z 14 aplikacji nie ma polskiego tytułu ani podtytułu.
- „Craving” nie jest już unikalny: Breath („Beat cravings”), Quit Smoking & Vaping („Beat cravings every day”), Flamy („SOS instant help”), Freewill („When cravings hit…”).
- Zrzuty to prawie zawsze liczniki (dni, godziny, oszczędności). Część aplikacji ma maskotki (PuffQuit, Freewill).
- Saszetki to osobna nisza (Snusst: „Quit Zyn & Nicotine Pouches”).

## 6. Fonteyne i wsp. 2026, JMIR (pełny tekst przeanalizowany)

**Próba:** 17 wywiadów z osobami w wieku 16–24 lat w Kanadzie (BC, ON, QC), jesień 2022. Wszyscy wapowali, chcieli rzucić i używali aplikacji. **Ograniczenia:** młodzi, a nie ogół dorosłych; próba wybrana z użytkowników aplikacji; dane z 2022.

| Wniosek | Dowód | Znaczenie dla Pauseo |
|---|---|---|
| Zerowanie serii po jednej wpadce boli | „you have like a huge streak and then if you hit it once, you lose all of it” (P15) | Drugie, niezależne potwierdzenie potrzeby 1 |
| Brak oceniania jest wartością | „[it's a] guilt free approach… it doesn't judge” (P19) | Potwierdza ton z CLAUDE.md |
| Wstyd i prywatność | „It's embarrassing when you want to quit something you've tried so hard to quit, and you can't… not something I want to share with the community” (P8) | Potwierdza „bez konta, bez społeczności” |
| Sam licznik dni to commodity | „I could track on a piece of paper… it's not really anything special” (P8) | Zrzut #1 nie powinien być licznikiem |
| Aplikacja pomaga w chwili impulsu | „that itch to vape… I open the app… it helps me control those urges” (P4) | Potwierdza moment cravingu |
| Autonomia („Quitting on my own terms”) | Temat 1 | Copy bez dyrektyw i bez „musisz” |
| Aplikacjom brakuje reakcji na wpadkę | Dyskusja: rekomendacja, by traktować wpadki jako okazję do nauki, nie porażkę (dziennik, refleksja) | To dokładnie „slip to dane” (ADR-017) |
| Część osób chce społeczności, człowieka, grywalizacji, nagród finansowych | Tematy 2–3 | **Poza zakresem MVP** (brak social, brak nadmiernej grywalizacji). Nie zmieniamy, odnotowujemy jako odroczone |
| Mało kto korzysta z aplikacji przy rzucaniu | Wstęp, cyt. Dai 2023: 5,9% młodych wapujących użyło aplikacji lub SMS, 63,7% rzucało bez wsparcia | Kontekst dla oczekiwań co do pozyskania |

## 7. Tabela potrzeb (wynik)

| # | Potrzeba | Dowód | Pewność | Co to znaczy dla Pauseo | Zmiana w app? |
|---|---|---|---|---|---|
| 1 | Wrócić po wpadce bez kary, bez zerowania i bez płacenia | Cytat z QuitNow (sekcja 4); Fonteyne P15; Shiffman (AVE) | **wysoka** | Główny komunikat listingu, np. „Wpadka niczego nie zeruje. Wróć, kiedy chcesz.” | nie |
| 2 | Uczciwość: bez subskrypcji i reklam | ~9 recenzji PL; Rodberg (koszt: 38 krytycznych wzmianek) | **wysoka** | „Za darmo. Bez reklam. Bez konta.” w podtytule albo w pierwszej linii opisu | nie |
| 3 | Ile trwa craving i co zrobić teraz | „Więcej pytań” w SERP; NHS „kilka minut”, HSE 3–5 min; Fonteyne P4 | wysoka | Zrzut #1: moment cravingu z rundą 2 minut. Strona: „Ile trwa głód nikotynowy i co zrobić teraz” (źródło NHS) | nie |
| 4 | Po polsku | 2 recenzje; zero polskich tytułów w wynikach „rzuć” | wysoka | Polski tytuł i podtytuł jako przewaga ASO | nie |
| 5 | Prywatnie, bez oceniania | Fonteyne P8, P19; Qwit wymusza konto | wysoka | „Dane zostają na telefonie” jako drugi komunikat | nie |
| 6 | Dorosły wygląd, bez maskotek i bez obrazów papierosów | Recenzja „infantylne”; PMC7568217 (obraz papierosa wywołuje craving) | średnia | Bez maskotki i ikonek zaciągnięć (spójne z wynikiem wątku A) | nie |
| 7 | Rzucanie vape, nie kupowanie vape | Top queries Trends; Rodberg (aplikacje vape kopiują aplikacje do papierosów) | wysoka | Słowa kluczowe „rzucić e-papierosa”, „vape”, „saszetki”. Unikać gołego „e-papieros” | nie |
| 8 | Licznik nie wystarcza | Fonteyne P8; zrzuty konkurencji | średnia | Licznik nie może być pierwszym ekranem listingu | nie |
| 9 | Sezon | Trends | wysoka | Styczeń potwierdzony. Wielki Post: brak sygnału | nie |

**Rekomendowana kolejność zrzutów w App Store:** (1) moment cravingu i 2 minuty, (2) slip bez wstydu i bez zerowania, (3) wyzwalacze, (4) prywatność, darmowa, bez konta.

**Wniosek:** żaden wynik nie wymaga zmiany w aplikacji przed zamrożeniem UI 06.12. Wszystko trafia do listingu, na stronę i do kolejności zrzutów.

## 8. Źródła

- Rodberg D i wsp. User Perceptions of E-Cigarette Cessation Apps: Content Analysis of App Reviews. J Med Internet Res 2025;27:e59997. https://pmc.ncbi.nlm.nih.gov/articles/PMC12041815/
- Fonteyne K i wsp. Exploring Vaping Cessation App Use Among Youth: Qualitative Descriptive Study. J Med Internet Res 2026;28:e85778. https://doi.org/10.2196/85778
- Shiffman i wsp., nawracające lapse i AVE w rzucaniu palenia. https://pmc.ncbi.nlm.nih.gov/articles/PMC3296289
- Bowen S, Marlatt GA. Surfing the urge. Psychol Addict Behav 2009. https://pubmed.ncbi.nlm.nih.gov/20025372/
- Hope i wsp. 2025, Quit Sense, ewaluacja jakościowa (tylko abstrakt). https://pmc.ncbi.nlm.nih.gov/articles/PMC12290499
- Gowarty i wsp. 2020, aplikacje do rzucania palenia u młodych w opiece psychiatrycznej. https://pmc.ncbi.nlm.nih.gov/articles/PMC7568217/
- NHS, wyzwalacze i craving. https://www.nhs.uk/better-health/quit-smoking/staying-smoke-free/understand-your-smoking-triggers-and-cravings/
- HSE, craving i odstawienie. https://www2.hse.ie/living-well/quit-smoking/get-help-to-quit/cravings-withdrawal/
- IBS 2025, konsumpcja nikotyny w Polsce (cyt. Jankowski 2024). https://ibs.org.pl/wp-content/uploads/2025/12/IBS_Policy_Paper_Konsumpcja_Nikotyny-1.pdf
- App Store: quitSTART https://apps.apple.com/us/app/quitstart-quit-smoking/id494552000 · EasyQuit https://apps.apple.com/us/app/easyquit-stop-smoking/id1508110799 · Kwit PL https://apps.apple.com/pl/app/quit-smoking-for-good-kwit/id525441365 · QuitNow PL https://apps.apple.com/pl/app/quitnow/id483994930?l=pl · Smoke Free PL https://apps.apple.com/pl/app/smoke-free-quit-smoking-now/id577767592
- Google Trends PL, eksporty CSV z 26.11.2026 (pliki lokalne foundera, nie w repo).
