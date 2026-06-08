import Foundation

struct CravingEvent: Codable, Identifiable {
    let id: UUID
    let timestamp: Date
    let trigger: String?
    let action: String?
    let completed: Bool
}

struct SlipEvent: Codable, Identifiable {
    let id: UUID
    let timestamp: Date
    let context: String?
    let recoveryAction: String?
    let completed: Bool
}

final class EventStore: ObservableObject {
    @Published private(set) var cravingEvents: [CravingEvent] = []
    @Published private(set) var slipEvents: [SlipEvent] = []

    private let cravingKey = "pauseo.cravingEvents"
    private let slipKey    = "pauseo.slipEvents"

    init() { load() }

    func save(_ event: CravingEvent) {
        cravingEvents.append(event)
        persist(cravingEvents, forKey: cravingKey)
    }

    func save(_ event: SlipEvent) {
        slipEvents.append(event)
        persist(slipEvents, forKey: slipKey)
    }

    private func load() {
        cravingEvents = decoded([CravingEvent].self, forKey: cravingKey) ?? []
        slipEvents    = decoded([SlipEvent].self,   forKey: slipKey)    ?? []
    }

    private func persist<T: Encodable>(_ value: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func decoded<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
}
