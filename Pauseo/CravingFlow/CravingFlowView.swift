import SwiftUI

struct CravingFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var eventStore: EventStore
    @State private var step: Int = 0
    @State private var selectedTrigger: TriggerCategory? = nil
    @State private var selectedAction: String? = nil

    @State private var phase: PostActionPhase = .invitation
    @State private var hasCreatedEvent = false
    @State private var eventID = UUID()
    @State private var eventTimestamp = Date()
    @State private var guidedLoopStarted = false
    @State private var guidedLoopCompletedFlag = false
    @State private var guidedLoopOutcome: GuidedLoopOutcome? = nil
    @State private var guidedLoopSecondRoundStarted = false
    @State private var guidedLoopDurationSeconds: Int? = nil
    @State private var round1ShownCardIDs: Set<String> = []

    private let microActions = [
        "Wypij wodę",
        "Wyjdź na 2 minuty",
        "Weź 5 spokojnych oddechów",
        "Zajmij ręce",
        "Napisz do kogoś"
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if step > 0 && step < 3 {
                    Button(action: { step -= 1 }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                }
                Spacer()
            }
            .frame(height: 44)
            .padding(.horizontal)
            .padding(.top, 8)

            switch step {
            case 0:
                GroundingStep(onNext: { step = 1 })
            case 1:
                TriggerStep(selection: $selectedTrigger, onNext: { step = 2 })
            case 2:
                MicroActionStep(actions: microActions, selection: $selectedAction, onNext: { step = 3 })
            case 3:
                postActionContent
            default:
                EmptyView()
            }
        }
        .onChange(of: step) { _, newStep in
            guard newStep == 3, !hasCreatedEvent else { return }
            hasCreatedEvent = true
            persistEvent(completed: false)
        }
    }

    @ViewBuilder
    private var postActionContent: some View {
        switch phase {
        case .invitation:
            InvitationStep(
                onAccept: { startGuidedLoop(round: 1) },
                onDecline: finishFlow
            )
        case .guidedLoop(let round):
            GuidedLoopStep(
                usedCardIDs: round == 1 ? [] : round1ShownCardIDs,
                onRoundFinished: { completedFully, shownCardIDs in
                    if round == 1 { round1ShownCardIDs = shownCardIDs }
                    finishRound(round: round, completedFully: completedFully)
                }
            )
            .id(round)
        case .outcome(let round):
            OutcomeStep(onSelect: { outcome in
                selectOutcome(outcome, round: round)
            })
        case .secondRoundOffer:
            SecondRoundOfferStep(
                onAccept: { startGuidedLoop(round: 2) },
                onDecline: finishFlow
            )
        case .completion:
            CompletionStep(onDismiss: { dismiss() })
        }
    }

    // MARK: - Guided loop transitions

    private func startGuidedLoop(round: Int) {
        guidedLoopStarted = true
        guidedLoopDurationSeconds = 120
        if round == 2 { guidedLoopSecondRoundStarted = true }
        phase = .guidedLoop(round: round)
        persistEvent(completed: false)
    }

    private func finishRound(round: Int, completedFully: Bool) {
        if completedFully { guidedLoopCompletedFlag = true }
        phase = .outcome(round: round)
        persistEvent(completed: false)
    }

    private func selectOutcome(_ outcome: GuidedLoopOutcome, round: Int) {
        guidedLoopOutcome = outcome
        if round == 1 && outcome == .postponed {
            phase = .secondRoundOffer
            persistEvent(completed: false)
        } else {
            finishFlow()
        }
    }

    private func finishFlow() {
        phase = .completion
        persistEvent(completed: true)
    }

    private func persistEvent(completed: Bool) {
        eventStore.upsert(CravingEvent(
            id: eventID,
            timestamp: eventTimestamp,
            trigger: selectedTrigger?.rawValue,
            action: selectedAction,
            completed: completed,
            guidedLoopStarted: guidedLoopStarted,
            guidedLoopCompleted: guidedLoopCompletedFlag,
            guidedLoopOutcome: guidedLoopOutcome,
            guidedLoopSecondRoundStarted: guidedLoopSecondRoundStarted,
            guidedLoopDurationSeconds: guidedLoopDurationSeconds
        ))
    }
}

private enum PostActionPhase: Equatable {
    case invitation
    case guidedLoop(round: Int)
    case outcome(round: Int)
    case secondRoundOffer
    case completion
}

// MARK: - Grounding

private struct GroundingStep: View {
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text("Pause for a moment.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("You don't have to solve everything right now. Choose one small action for the next minute.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            Button("Help me now", action: onNext)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.indigo)
                .padding(.horizontal)
                .padding(.bottom, 40)
        }
    }
}

// MARK: - Trigger Selection

private struct TriggerStep: View {
    @Binding var selection: TriggerCategory?
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Text("What triggered the craving?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 24)
                .padding(.bottom, 8)

            Text("You can skip this.")
                .font(.caption)
                .foregroundStyle(.tertiary)
                .padding(.bottom, 16)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(TriggerCategory.allCases, id: \.rawValue) { trigger in
                        CravingChip(
                            title: trigger.rawValue,
                            isSelected: selection == trigger,
                            action: { selection = trigger }
                        )
                    }
                }
                .padding(.horizontal)
            }

            Button("Next", action: onNext)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.indigo)
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 40)
        }
    }
}

// MARK: - Micro-Action Selection

private struct MicroActionStep: View {
    let actions: [String]
    @Binding var selection: String?
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Text("Choose one small action.")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 24)
                .padding(.bottom, 8)

            Text("For the next minute.")
                .font(.caption)
                .foregroundStyle(.tertiary)
                .padding(.bottom, 16)

            VStack(spacing: 10) {
                ForEach(actions, id: \.self) { action in
                    CravingChip(
                        title: action,
                        isSelected: selection == action,
                        action: { selection = action }
                    )
                }
            }
            .padding(.horizontal)

            Spacer()

            Button("I'll do it", action: onNext)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.indigo)
                .padding(.horizontal)
                .padding(.bottom, 40)
        }
    }
}

// MARK: - Invitation

private struct InvitationStep: View {
    let onAccept: () -> Void
    let onDecline: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text("Stay with me for 2 more minutes?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("You can stay with me before deciding. No pressure — you can also end now.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            VStack(spacing: 12) {
                Button("Stay with me", action: onAccept)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(.indigo)
                Button("I'm done for now", action: onDecline)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
}

// MARK: - Guided Loop

private struct GuidedLoopStep: View {
    let onRoundFinished: (_ completedFully: Bool, _ shownCardIDs: Set<String>) -> Void

    private let totalDuration: TimeInterval = 120
    private let cardInterval: TimeInterval = 10
    private let cardSequence: [SupportCard]

    @State private var startDate = Date()
    @State private var hasFinished = false

    init(usedCardIDs: Set<String>, onRoundFinished: @escaping (_ completedFully: Bool, _ shownCardIDs: Set<String>) -> Void) {
        self.onRoundFinished = onRoundFinished
        self.cardSequence = SupportCardLibrary.buildSequence(excluding: usedCardIDs, slotCount: 12)
    }

    var body: some View {
        TimelineView(.periodic(from: startDate, by: 1)) { context in
            let elapsed = min(context.date.timeIntervalSince(startDate), totalDuration)
            let remaining = max(totalDuration - elapsed, 0)
            let isDone = elapsed >= totalDuration
            let card = currentCard(elapsed: elapsed)

            VStack(spacing: 0) {
                Spacer()

                Text(timeString(remaining))
                    .font(.system(.title, design: .rounded))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 8)

                ProgressView(value: elapsed, total: totalDuration)
                    .tint(.indigo)
                    .padding(.horizontal, 48)
                    .padding(.bottom, 32)

                if let card {
                    Text(LocalizedStringKey(card.text))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .accessibilityAddTraits(.updatesFrequently)
                }

                Spacer()

                Button("I'm done for now") {
                    finish(completedFully: false)
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.bottom, 40)
            }
            .onChange(of: isDone) { _, done in
                guard done else { return }
                finish(completedFully: true)
            }
        }
    }

    private func currentCard(elapsed: TimeInterval) -> SupportCard? {
        guard !cardSequence.isEmpty else { return nil }
        let index = min(Int(elapsed / cardInterval), cardSequence.count - 1)
        return cardSequence[index]
    }

    private func finish(completedFully: Bool) {
        guard !hasFinished else { return }
        hasFinished = true
        onRoundFinished(completedFully, Set(cardSequence.map(\.id)))
    }

    private func timeString(_ interval: TimeInterval) -> String {
        let total = Int(interval.rounded())
        return String(format: "%d:%02d", total / 60, total % 60)
    }
}

// MARK: - Outcome

private struct OutcomeStep: View {
    let onSelect: (GuidedLoopOutcome) -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("What's happening now?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()
            VStack(spacing: 10) {
                Button("I didn't smoke") { onSelect(.didNotSmoke) }
                Button("I've put off the decision") { onSelect(.postponed) }
                Button("I smoked") { onSelect(.smoked) }
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
}

// MARK: - Second Round Offer

private struct SecondRoundOfferStep: View {
    let onAccept: () -> Void
    let onDecline: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text("Still need support?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Text("You can stay a little longer.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            VStack(spacing: 12) {
                Button("I'll take 2 more minutes", action: onAccept)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(.indigo)
                Button("I'm done for now", action: onDecline)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
}

// MARK: - Completion

private struct CompletionStep: View {
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text("Good. One small action is enough for now.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("If the craving comes back, you can start this flow again.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            Button("Back to home", action: onDismiss)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.indigo)
                .padding(.horizontal)
                .padding(.bottom, 40)
        }
    }
}

// MARK: - Chip

private struct CravingChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(LocalizedStringKey(title))
                .font(.callout)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.indigo : Color(.systemGray6))
                .foregroundStyle(isSelected ? Color.white : Color.primary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CravingFlowView()
        .environmentObject(EventStore())
}
