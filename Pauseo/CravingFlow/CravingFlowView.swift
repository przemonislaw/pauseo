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

    /// Micro-actions that are done away from the screen. For these the
    /// invitation must not say "stay with me": the user first needs explicit
    /// permission to put the phone down or switch apps.
    /// Choosing this action opens an in-app guided breathing exercise
    /// (5 × in 4 s / out 6 s) before the guided-loop invitation.
    private let breathingAction = "Weź 5 spokojnych oddechów"

    private let awayFromPhoneActions: Set<String> = [
        "Wyjdź na 2 minuty",
        "Napisz do kogoś"
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if step == 1 {
                    Button(action: { step -= 1 }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }
            .frame(height: 44)
            .padding(.horizontal)
            .padding(.top, 8)

            switch step {
            // Help first, ask later: grounding → micro-action → (optional guided
            // loop → outcome) → trigger reflection → completion.
            case 0:
                GroundingStep(onNext: { step = 1 })
            case 1:
                MicroActionStep(actions: microActions, selection: $selectedAction, onNext: {
                    phase = selectedAction == breathingAction ? .breathing : .invitation
                    step = 2
                })
            case 2:
                postActionContent
            default:
                EmptyView()
            }
        }
        .background(Color.pauseoBackground.ignoresSafeArea())
        .onChange(of: step) { _, newStep in
            guard newStep == 2, !hasCreatedEvent else { return }
            hasCreatedEvent = true
            persistEvent(completed: false)
        }
    }

    @ViewBuilder
    private var postActionContent: some View {
        switch phase {
        case .breathing:
            BreathingStep(onFinished: { phase = .invitation })
        case .invitation:
            InvitationStep(
                awayFromPhone: selectedAction.map(awayFromPhoneActions.contains) ?? false,
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
        case .trigger:
            TriggerStep(selection: $selectedTrigger, onNext: {
                phase = .completion
                persistEvent(completed: true)
            })
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

    /// The support part of the flow is done here, so the event is marked
    /// completed before the optional trigger question. Dismissing the sheet
    /// on the trigger step keeps a completed event with no trigger.
    private func finishFlow() {
        phase = .trigger
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
    case breathing
    case invitation
    case guidedLoop(round: Int)
    case outcome(round: Int)
    case secondRoundOffer
    case trigger
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
                .buttonStyle(PauseoPrimaryButtonStyle())
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

            Text("Helps next time. You can skip this.")
                .font(.caption)
                .foregroundStyle(.secondary)
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
                .buttonStyle(PauseoPrimaryButtonStyle())
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 40)
        }
    }
}

// MARK: - Micro-Action Selection

/// Craving-flow-only display copy for some micro-actions. The stored value
/// (`CravingEvent.action`) stays the original Polish string; only the label
/// changes. "Napisz do kogoś" is shared with the slip flow, which keeps its
/// own label, so the override lives here rather than in the catalog entry.
private let microActionDisplayKeys: [String: String] = [
    "Napisz do kogoś": "Text someone: “how are you?”"
]

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
                .foregroundStyle(.secondary)
                .padding(.bottom, 16)

            VStack(spacing: 10) {
                ForEach(actions, id: \.self) { action in
                    CravingChip(
                        title: microActionDisplayKeys[action] ?? action,
                        isSelected: selection == action,
                        action: { selection = action }
                    )
                }
            }
            .padding(.horizontal)

            Spacer()

            Button("I'll do it", action: onNext)
                .buttonStyle(PauseoPrimaryButtonStyle())
                .padding(.horizontal)
                .padding(.bottom, 40)
        }
    }
}

// MARK: - Guided breathing

/// Guided breathing for the "5 breaths" micro-action: 5 cycles of
/// in 4 s / out 6 s (50 s). Wall-clock based like the guided loop, so
/// backgrounding does not desync it. With Reduce Motion the circle stays
/// still and only the text and counter change.
private struct BreathingStep: View {
    let onFinished: () -> Void

    private let inhale: TimeInterval = 4
    private let exhale: TimeInterval = 6
    private let cycles = 5
    private var cycleLength: TimeInterval { inhale + exhale }
    private var totalDuration: TimeInterval { cycleLength * Double(cycles) }

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var startDate = Date()
    @State private var hasFinished = false

    var body: some View {
        TimelineView(.animation(minimumInterval: reduceMotion ? 1 : nil)) { context in
            let elapsed = min(context.date.timeIntervalSince(startDate), totalDuration)
            let isDone = elapsed >= totalDuration
            let cycleIndex = min(Int(elapsed / cycleLength), cycles - 1)
            let inCycle = elapsed - Double(cycleIndex) * cycleLength
            let isInhale = inCycle < inhale
            let phaseProgress = isInhale ? inCycle / inhale : (inCycle - inhale) / exhale
            let secondsLeft = Int(ceil((isInhale ? inhale : exhale) * (1 - phaseProgress)))
            let eased = 0.5 - 0.5 * cos(phaseProgress * .pi)
            let scale = reduceMotion ? 0.8 : (isInhale ? 0.6 + 0.4 * eased : 1.0 - 0.4 * eased)
            let breathsLeft = cycles - cycleIndex

            VStack(spacing: 0) {
                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.pauseoPrimary.opacity(0.15))
                    Circle()
                        .stroke(Color.pauseoPrimary, lineWidth: 2)
                    Text("\(max(secondsLeft, 1))")
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundStyle(Color.pauseoTextPrimary)
                }
                .frame(width: 220, height: 220)
                .scaleEffect(scale)
                .accessibilityHidden(true)
                .padding(.bottom, 32)

                Group {
                    if isInhale {
                        Text("Breathe in")
                    } else {
                        Text("Breathe out")
                    }
                }
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 8)

                Group {
                    if breathsLeft == 1 {
                        Text("Last breath")
                    } else {
                        Text("\(breathsLeft) breaths left")
                    }
                }
                .font(.body)
                .foregroundStyle(.secondary)

                Spacer()

                Button("Skip breathing") { finish() }
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity)
            .onChange(of: isDone) { _, done in
                guard done else { return }
                finish()
            }
        }
    }

    private func finish() {
        guard !hasFinished else { return }
        hasFinished = true
        onFinished()
    }
}

// MARK: - Invitation

private struct InvitationStep: View {
    var awayFromPhone: Bool = false
    let onAccept: () -> Void
    let onDecline: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text(LocalizedStringKey(awayFromPhone
                     ? "Go ahead, do it now. I'll be here."
                     : "Stay with me for 2 more minutes?"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text(LocalizedStringKey(awayFromPhone
                     ? "When you're back, you can stay with me for 2 more minutes. Or end here."
                     : "You can stay with me before deciding. No pressure — you can also end now."))
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            VStack(spacing: 12) {
                Button("Stay with me", action: onAccept)
                    .buttonStyle(PauseoPrimaryButtonStyle())
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
                    .tint(.pauseoPrimary)
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
            .buttonStyle(PauseoSecondaryButtonStyle())
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
                    .buttonStyle(PauseoPrimaryButtonStyle())
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
                Text("That's enough for now.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("One small action counts. If it comes back, just come back here.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            Button("Back to home", action: onDismiss)
                .buttonStyle(PauseoPrimaryButtonStyle())
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
            HStack {
                Text(LocalizedStringKey(title))
                    .font(.callout)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.callout.weight(.semibold))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isSelected ? Color.pauseoPrimary : Color.pauseoSurface)
            .foregroundStyle(isSelected ? Color.white : Color.pauseoTextPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.clear : Color.pauseoBorder, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    CravingFlowView()
        .environmentObject(EventStore())
}
