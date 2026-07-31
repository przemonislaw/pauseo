import Foundation

enum SupportCardLibrary {
    /// Bundled cards if `support_cards.json` decodes successfully and is non-empty,
    /// otherwise a small built-in fallback so the guided loop never has zero cards to show.
    static let all: [SupportCard] = loadBundled() ?? fallback

    private static func loadBundled() -> [SupportCard]? {
        guard
            let url = Bundle.main.url(forResource: "support_cards", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let cards = try? JSONDecoder().decode([SupportCard].self, from: data),
            !cards.isEmpty
        else { return nil }
        return cards
    }

    private static let fallback: [SupportCard] = [
        SupportCard(id: "fallback-one-decision", category: .perspective, text: "Nie musisz teraz decydować o całym dniu. Wystarczy decyzja na najbliższe kilkadziesiąt sekund.", sourceLabel: nil, sourceURL: nil),
        SupportCard(id: "fallback-change-position", category: .action, text: "Zmień teraz pozycję ciała — wstań, usiądź inaczej albo zrób kilka kroków.", sourceLabel: nil, sourceURL: nil),
        SupportCard(id: "fallback-not-weakness", category: .normalization, text: "To, że ten moment jest trudny, nie znaczy, że robisz coś źle.", sourceLabel: nil, sourceURL: nil),
        SupportCard(id: "fallback-drink-water", category: .action, text: "Pij wodę małymi łykami, skupiając się na samym piciu.", sourceLabel: nil, sourceURL: nil),
        SupportCard(id: "fallback-postpone-step", category: .perspective, text: "Odłożenie decyzji o kilka minut to już konkretny krok, nawet jeśli później zapalisz.", sourceLabel: nil, sourceURL: nil)
    ]

    /// Builds one round's card order. Cards not in `usedIDs` come first (so a second round
    /// prefers cards the first round didn't show), then a best-effort pass avoids two
    /// adjacent cards from the same category. No state or card order is persisted.
    static func buildSequence(from pool: [SupportCard] = all, excluding usedIDs: Set<String> = [], slotCount: Int = 12) -> [SupportCard] {
        guard !pool.isEmpty else { return [] }

        let unused = pool.filter { !usedIDs.contains($0.id) }.shuffled()
        let used = pool.filter { usedIDs.contains($0.id) }.shuffled()
        let ordered = unused + used

        let uniqueCount = min(slotCount, pool.count)
        var sequence = Array(ordered.prefix(uniqueCount))

        guard sequence.count > 1 else { return sequence }
        for i in 1..<sequence.count {
            guard sequence[i].category == sequence[i - 1].category else { continue }
            if let swapIndex = ((i + 1)..<sequence.count).first(where: { sequence[$0].category != sequence[i - 1].category }) {
                sequence.swapAt(i, swapIndex)
            }
        }
        return sequence
    }
}
