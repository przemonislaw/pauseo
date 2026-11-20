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
        .background(Color.pauseoBackground.ignoresSafeArea())
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
                Text("A slip doesn't mean it's over.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("You don't have to start from zero. Just come back to one small decision now.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            Button("Let's continue", action: onNext)
                .buttonStyle(PauseoPrimaryButtonStyle())
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
        "Po jedzeniu", "Kawa", "Praca", "Emocje", "Zmęczenie", "Inne"
    ]

    var body: some View {
        VStack(spacing: 0) {
            Text("What was happening just before?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 24)
                .padding(.bottom, 8)

            Text("You can skip this.")
                .font(.caption)
                .foregroundStyle(.secondary)
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

            Button("Next", action: onNext)
                .buttonStyle(PauseoPrimaryButtonStyle())
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
            Text("What will you do now?")
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

            Button("Continue", action: onNext)
                .buttonStyle(PauseoPrimaryButtonStyle())
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
                Text("You're getting back on track.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("Your next decision matters more than a perfect record. If the urge comes back, come back here.")
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

private struct SlipChip: View {
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
    SlipRecoveryView()
        .environmentObject(EventStore())
}
