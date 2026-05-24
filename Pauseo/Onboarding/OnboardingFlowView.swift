import SwiftUI

struct OnboardingFlowView: View {
    @EnvironmentObject private var appState: AppState
    @State private var step: Int = 0
    @State private var nicotineType: NicotineType? = nil
    @State private var goalMode: GoalMode? = nil
    @State private var mainTrigger: TriggerCategory? = nil

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if step > 0 {
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
                WelcomeStep(onNext: { step = 1 })
            case 1:
                NicotineTypeStep(selection: $nicotineType, onNext: { step = 2 })
            case 2:
                GoalModeStep(selection: $goalMode, onNext: { step = 3 })
            case 3:
                TriggerStep(selection: $mainTrigger, onNext: { step = 4 })
            case 4:
                NotificationsStep(onComplete: { appState.completeOnboarding() })
            default:
                EmptyView()
            }
        }
    }
}

// MARK: - Welcome

private struct WelcomeStep: View {
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text("Pomoc na moment cravingu.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("pauseo pomaga wybrać jedną małą akcję, gdy pojawia się głód nikotynowy.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            Button("Zacznij spokojnie", action: onNext)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.indigo)
                .padding(.horizontal)
                .padding(.bottom, 40)
        }
    }
}

// MARK: - Nicotine Type

private struct NicotineTypeStep: View {
    @Binding var selection: NicotineType?
    let onNext: () -> Void

    var body: some View {
        SelectionStep(
            title: "Z czego korzystasz?",
            options: NicotineType.allCases,
            selection: $selection,
            onNext: onNext
        )
    }
}

// MARK: - Goal Mode

private struct GoalModeStep: View {
    @Binding var selection: GoalMode?
    let onNext: () -> Void

    var body: some View {
        SelectionStep(
            title: "Co jest Twoim celem?",
            options: GoalMode.allCases,
            selection: $selection,
            onNext: onNext
        )
    }
}

// MARK: - Main Trigger

private struct TriggerStep: View {
    @Binding var selection: TriggerCategory?
    let onNext: () -> Void

    var body: some View {
        SelectionStep(
            title: "Co najczęściej odpala craving?",
            options: TriggerCategory.allCases,
            selection: $selection,
            onNext: onNext
        )
    }
}

// MARK: - Notifications

private struct NotificationsStep: View {
    let onComplete: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text("Przypomnienia później.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("Na razie zaczniemy bez ustawiania powiadomień. Najważniejsze jest, żeby pomoc była pod ręką, gdy pojawi się craving.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            VStack(spacing: 12) {
                Button("Przejdź do aplikacji", action: onComplete)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(.indigo)
                Button("Nie teraz", action: onComplete)
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .tint(.indigo)
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
}

// MARK: - Generic Selection Step

private struct SelectionStep<T: RawRepresentable & CaseIterable & Hashable>: View
    where T.RawValue == String {
    let title: String
    let options: T.AllCases
    @Binding var selection: T?
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 24)
                .padding(.bottom, 24)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(Array(options), id: \.rawValue) { option in
                        OptionChip(
                            title: option.rawValue,
                            isSelected: selection == option,
                            action: { selection = option }
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

// MARK: - Option Chip

private struct OptionChip: View {
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
    OnboardingFlowView()
        .environmentObject(AppState())
}
