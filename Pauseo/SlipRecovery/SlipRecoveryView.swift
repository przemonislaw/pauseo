import SwiftUI

struct SlipRecoveryView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var eventStore: EventStore
    @State private var step: Int = 0
    @State private var selectedContext: String? = nil
    @State private var selectedAction: String? = nil
    @State private var hasSavedCompletionEvent = false

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
                ShameReductionStep(onNext: { step = 1 })
            case 1:
                ContextStep(selection: $selectedContext, onNext: { step = 2 })
            case 2:
                RecoveryActionStep(selection: $selectedAction, onNext: { step = 3 })
            case 3:
                SlipCompletionStep(onDismiss: { dismiss() })
            default:
                EmptyView()
            }
        }
        .onChange(of: step) { _, newStep in
            guard newStep == 3, !hasSavedCompletionEvent else { return }
            eventStore.save(SlipEvent(
                id: UUID(),
                timestamp: .now,
                context: selectedContext,
                recoveryAction: selectedAction,
                completed: true
            ))
            hasSavedCompletionEvent = true
        }
    }
}

// MARK: - Shame Reduction

private struct ShameReductionStep: View {
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text("To był slip, nie koniec.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("Nie musisz zaczynać od zera. Wystarczy wrócić do jednej małej decyzji teraz.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            Button("Idziemy dalej", action: onNext)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.indigo)
                .padding(.horizontal)
                .padding(.bottom, 40)
        }
    }
}

// MARK: - Context Selection

private struct ContextStep: View {
    @Binding var selection: String?
    let onNext: () -> Void

    private let contexts = [
        "Stres", "Alkohol", "Nuda", "Towarzystwo",
        "Po jedzeniu", "Praca", "Emocje", "Zmęczenie", "Inne"
    ]

    var body: some View {
        VStack(spacing: 0) {
            Text("Co było najbliżej tego momentu?")
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
                    ForEach(contexts, id: \.self) { context in
                        SlipChip(
                            title: context,
                            isSelected: selection == context,
                            action: { selection = selection == context ? nil : context }
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

// MARK: - Recovery Action

private struct RecoveryActionStep: View {
    @Binding var selection: String?
    let onNext: () -> Void

    private let actions = [
        "Wypij wodę",
        "Odłóż nikotynę poza zasięg",
        "Wyjdź na 2 minuty",
        "Napisz do kogoś",
        "Zacznij od następnej godziny"
    ]

    var body: some View {
        VStack(spacing: 0) {
            Text("Co zrobisz teraz?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 24)
                .padding(.bottom, 24)

            VStack(spacing: 10) {
                ForEach(actions, id: \.self) { action in
                    SlipChip(
                        title: action,
                        isSelected: selection == action,
                        action: { selection = selection == action ? nil : action }
                    )
                }
            }
            .padding(.horizontal)

            Spacer()

            Button("Idę dalej", action: onNext)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.indigo)
                .padding(.horizontal)
                .padding(.bottom, 40)
        }
    }
}

// MARK: - Completion

private struct SlipCompletionStep: View {
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text("Wracasz na tor.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("Najważniejsza jest następna decyzja, nie idealna historia.")
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

private struct SlipChip: View {
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
    SlipRecoveryView()
        .environmentObject(EventStore())
}
