import Foundation

enum GuidedLoopOutcome: String, Codable {
    case didNotSmoke
    case postponed
    case smoked
}

struct CravingEvent: Codable, Identifiable {
    let id: UUID
    let timestamp: Date
    let trigger: String?
    let action: String?
    let completed: Bool
    let guidedLoopStarted: Bool?
    let guidedLoopCompleted: Bool?
    let guidedLoopOutcome: GuidedLoopOutcome?
    let guidedLoopSecondRoundStarted: Bool?

    init(
        id: UUID,
        timestamp: Date,
        trigger: String?,
        action: String?,
        completed: Bool,
        guidedLoopStarted: Bool? = nil,
        guidedLoopCompleted: Bool? = nil,
        guidedLoopOutcome: GuidedLoopOutcome? = nil,
        guidedLoopSecondRoundStarted: Bool? = nil
    ) {
        self.id = id
        self.timestamp = timestamp
        self.trigger = trigger
        self.action = action
        self.completed = completed
        self.guidedLoopStarted = guidedLoopStarted
        self.guidedLoopCompleted = guidedLoopCompleted
        self.guidedLoopOutcome = guidedLoopOutcome
        self.guidedLoopSecondRoundStarted = guidedLoopSecondRoundStarted
    }
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

    /// Creates the record on first call, then updates it in place on every
    /// subsequent call with the same `id` — used so a single craving-flow
    /// session (including the guided loop) never produces duplicate events.
    func upsert(_ event: CravingEvent) {
        if let index = cravingEvents.firstIndex(where: { $0.id == event.id }) {
            cravingEvents[index] = event
        } else {
            cravingEvents.append(event)
        }
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

    func deleteAll() {
        cravingEvents = []
        slipEvents = []
        UserDefaults.standard.removeObject(forKey: cravingKey)
        UserDefaults.standard.removeObject(forKey: slipKey)
    }

    private func decoded<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
}
