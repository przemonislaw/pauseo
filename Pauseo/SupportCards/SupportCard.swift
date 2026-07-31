import Foundation

enum SupportCardCategory: String, Codable, CaseIterable {
    case normalization
    case fact
    case bodyEffect
    case action
    case perspective
}

struct SupportCard: Codable, Identifiable, Equatable {
    let id: String
    let category: SupportCardCategory
    let text: String
    let sourceLabel: String?
    let sourceURL: String?
}
