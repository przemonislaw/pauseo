import SwiftUI

struct CravingFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var eventStore: EventStore
    @State private var step: Int = 0
    @State private var selectedTrigger: TriggerCategory? = nil
    @State private var selectedAction: String? = nil
    @State private var hasSavedCompletionEvent = false

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
                            Text("Wstecz")
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
                CompletionStep(onDismiss: { dismiss() })
            default:
                EmptyView()
            }
        }
        .onChange(of: step) { _, newStep in
            guard newStep == 3, !hasSavedCompletionEvent else { return }
            eventStore.save(CravingEvent(
                id: UUID(),
                timestamp: .now,
                trigger: selectedTrigger?.rawValue,
                action: selectedAction,
                completed: true
            ))
            hasSavedCompletionEvent = true
        }
    }
}

// MARK: - Grounding

private struct GroundingStep: View {
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text("Zatrzymaj się na chwilę.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("Nie musisz teraz rozwiązywać wszystkiego. Wybierz jedną małą akcję na najbliższą minutę.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            Button("Pomóż mi teraz", action: onNext)
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
            Text("Co odpaliło craving?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 24)
                .padding(.bottom, 8)

            Text("Możesz pominąć.")
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

            Button("Dalej", action: onNext)
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
            Text("Wybierz jedną małą akcję.")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 24)
                .padding(.bottom, 8)

            Text("Na najbliższą minutę.")
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

            Button("Zrobię to", action: onNext)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.indigo)
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
                Text("Dobra. Jedna mała akcja wystarczy na teraz.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("Jeśli craving wróci, możesz odpalić ten flow jeszcze raz.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            Button("Wróć do Home", action: onDismiss)
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
            Text(title)
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
